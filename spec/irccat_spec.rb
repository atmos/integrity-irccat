require File.dirname(__FILE__) +  "/../lib/notifier/irccat"
require Integrity.root / "spec" / "spec_helper"

describe Integrity::Notifier::IRC do
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
    describe "with a field for the IRC URI" do
      it "should have the proper name, id and label and a default value" do
        the_form.should have_textfield("irc_notifier_uri").
          named("notifiers[IRC][uri]").
          with_label("Send to").
          with_value("irc://irc.freenode.net:6667/test")
      end
      
      it "should use the config's 'uri' value if available" do
        the_form(:config => { "uri" => "irc://irc.freenode.net/integrity" }).
          should have_textfield("irc_notifier_uri").
          with_value("irc://irc.freenode.net/integrity")
      end
    end
  end

  describe "Delevering the build" do
    def do_notify
      notifier.deliver!
    end

    before do
      @channel = mock("channel", :say => "")
      ShoutBot.stub!(:shout).and_yield(@channel)
    end

    it "should connect to the given URI as IntegrityBot" do
      ShoutBot.should_receive(:shout).
        with(notifier_config["uri"], {:as => "IntegrityBot"})
      do_notify
    end

    it "should give the build status and project name" do
      notifier.build.project.should_receive(:name).and_return("Integrity")
      notifier.should_receive(:short_message).and_return("short message")
      @channel.should_receive(:say).with("Integrity: short message")
      do_notify
    end

    it "should give the build url" do
      notifier.should_receive(:build_url).and_return("http://example.org")
      @channel.should_receive(:say).with("http://example.org")
      do_notify
    end
  end
end
