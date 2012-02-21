require 'spec_helper'
describe 'buildbot' do
  let(:facts) { {:operatingsystem => 'Debian'} }
  let(:params) {
    {
      project: 'compile_stuff',
      user:    'buildbot',
      admin:   'alice',
      mail:    'alice@dot.com',
      master_ip: '192.168.0.8',
      master_pass: 'my_pass',
    }}
  it { should include_class('buildbot::install') }
  it { should include_class('buildbot::service') }
  it { should include_class('buildbot::config') }
  it { should include_class('buildbot::slave') }
  it { should contain_user('buildbot').with_ensure('present') }
  it { should contain_package('git-core').with_ensure('present') }
  it { should contain_package('buildbot').with_ensure('present') }
  it { should contain_service('buildbot').with_ensure('running') }
  it { should contain_file('/home/buildbot/').with_ensure('directory') }
  it { should contain_file('/etc/init.d/vboxload').with_ensure('file') }
  it { should contain_file('/home/buildbot/compile_stuff/info/admin').with(
                                                        'owner' => 'buildbot',
                                                        'group' => 'buildbot',) }
  it { should contain_file('/home/buildbot/compile_stuff/info/host').with_owner('buildbot') }
  it "should have a valid default" do
    content = catalogue.resource('file', '/etc/default/buildbot').send(:parameters)[:source]
    expected_lines = [
      'BB_NUMBER[0]=0                            # index for the other values; negative disables the bot',
      'BB_NAME[0]="buildbot"                     # short name printed on startup / stop',
      'BB_USER[0]="buildbot"                      # user to run as',
      'BB_BASEDIR[0]="/home/buildbot/compile_stuff"    # basedir argument to buildbot (absolute path)',
      'BB_OPTIONS[0]=""                          # buildbot options',
      'BB_PREFIXCMD[0]=""                        # prefix command, i.e. nice, linux32, dchroot',
    ]
    (content.split("\n") & expected_lines).should == expected_lines
  end
  it "should have the right admin information" do
    content = catalogue.resource('file', '/home/buildbot/compile_stuff/info/admin').send(:parameters)[:content]
    expected_lines = ["alice <alice@dot.com>"]
    (content.split("\n") & expected_lines).should == expected_lines
  end

  it { should contain_exec('basic-init').with(
                                         'creates' => '/home/buildbot/compile_stuff/buildbot.tac',
                                         'command' => 'buildbot create-slave compile_stuff 192.168.0.8 my_pass') }
end
end
