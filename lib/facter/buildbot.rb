require 'facter'
class Buildbot
  class Facter
    class Helpers
      def get_values_of(key)
        IO.readlines('/etc/default/buildbot').grep(/^#{key}/).\
        map {|n| n.split(/[= ]/)[1].strip.gsub(/"/,'')}
      end
      attr_reader :buildbot_conf
      def initialize
        @buildbot_conf = {
          buildbot_count: 'BB_NUMBER',
          buildbot_names: 'BB_NAME',
          buildbot_dirs:  'BB_BASEDIR',
        }
      end
    end
  end
end
b = Buildbot::Facter::Helpers.new

b.buildbot_conf.each do |fact, conf|
  Facter.add(fact) do
    confine :operatingsystem => %w{Debian}
    setting = []
    setting = b.get_values_of(conf)
    setcode do
      if fact == :buildbot_count
        setting.last
      else
        setting.join(',')
      end
    end
  end
end
