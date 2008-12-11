require File.dirname(__FILE__) +  "/../lib/notifier/irccat"
require Integrity.root / "spec" / "spec_helper"

describe Integrity::Notifier::IrcCat do
  include AppSpecHelper
  include NotifierSpecHelper
  
  it_should_behave_like "A notifier"

  def klass
    Integrity::Notifier::IrcCat
  end

  def notifier_config(opts={})
    {"host" =>"127.0.0.1", "port" => 5678}
  end

  def notifier
    @notifier ||= Integrity::Notifier::IrcCat.new(mock_build, notifier_config)
  end

  it "should have an host" do
    notifier.host.should == "127.0.0.1"
  end

  it "should have an port" do
    notifier.port.should == 5678
  end

  describe "Generating a form for configuration" do
    describe "with a field for the IrcCat host" do
      it "should have the proper name, id and label and a default value" do
        the_form.should have_textfield("irccat_notifier_host").
          named("notifiers[IrcCat][host]").
          with_label("Send to host").
          with_value("127.0.0.1")
      end
      
      it "should use the config's 'host' value if available" do
        the_form(:config => { "host" => "127.0.0.1" }).
          should have_textfield("irccat_notifier_host").
          with_value("127.0.0.1")
      end
    end

    describe "with a field for the IrcCat port" do
      it "should have the proper name, id and label and a default value" do
        the_form.should have_textfield("irccat_notifier_port").
          named("notifiers[IrcCat][port]").
          with_label("Send to port").
          with_value("5678")
      end
      
      it "should use the config's 'port' value if available" do
        the_form(:config => { "port" => 5678 }).
          should have_textfield("irccat_notifier_port").
          with_value("5678")
      end
    end
  end

  describe "Delevering the build" do
    def do_notify
      notifier.deliver!
    end

    it "should give the build status, project name and the build url" do
      IrcCat::TcpClient.should_receive(:notify).with("127.0.0.1", 5678,
        "[Integrity] Build e7e02b was successful - http://localhost:4567/integrity/builds/e7e02bc669d07064cdbc7e7508a21a41e040e70d")
      do_notify
    end
  end
end
