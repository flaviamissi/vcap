require 'spec_helper'

describe "Creating a new App" do
  before do
    RSpec::Mocks::setup(self)
    build_admin_and_user
  end

  it "is successful when given a unique name" do
    Kernel.stub!(:exec)
    User.any_instance.stubs(:no_more_apps?).returns(false)

    data = { 'name' => random_name, 'staging' => {'model' => 'sinatra', 'stack' => 'ruby18' }}

    lambda do
      post app_create_path, nil, headers_for(@user.email, nil, data)
      response.should be_success
    end.should change(App, :count).by(1)
  end

  it "fails when given a duplicate name"
end
