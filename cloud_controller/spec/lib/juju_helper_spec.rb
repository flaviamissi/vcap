require 'spec_helper'
require 'juju_helper'

describe "juju_helper#create_environment" do

  before :all do
    RSpec::Mocks::setup(self)
    Kernel.stub!(:exec)
  end

  before :each do
    @juju = JujuHelper.new
  end

  it "should create a new environment based on the app framework" do
    Kernel.should_receive(:exec).with("juju deploy --repository=/home/charms local:oneiric/django")
    @juju.create_environment("django", "my_app").should be_true
  end

  it "should send the code to the environment using juju scp" do
    Kernel.should_receive(:exec).with("juju scp arquivo.zip my_app/0:/home/application/")
    @juju.upload_code("arquivo.zip", "my_app").should be_true
  end

end
