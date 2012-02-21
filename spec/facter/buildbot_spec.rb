require 'spec_helper'

describe "buildbot facts" do
  before :each do
    Facter.fact(:operatingsystem).stubs(:value).returns("Debian")
    IO.stubs(:readlines).with("/etc/default/buildbot").\
    returns(["BB_NUMBER[0]=0","BB_NAME[0]=\"project1\"",
              "BB_BASEDIR[0]=\"/home/bbslave/project1\"",
              "BB_NUMBER[1]=1 #with comments.","BB_NAME[1]=\"project2\" # with comments.",
              "BB_BASEDIR[1]=\"/home/bbslave/project2\"",])
  end
  describe "buildbot_count" do
    it "should return the last value of BB_NUMBER" do
      Facter.fact(:buildbot_count).value.should == '1'
    end
  end

  describe "buildbot_names" do
    it "should return all the configured buildbot's names" do
      Facter.fact(:buildbot_names).value.should == 'project1,project2'
    end
  end

  describe "buildbot_dirs" do
    it "should return all the configured buildbot's directories" do
      Facter.fact(:buildbot_dirs).\
      value.should == '/home/bbslave/project1,/home/bbslave/project2'
    end
  end
end
