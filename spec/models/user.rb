require 'spec_helper'

describe "Addwalk::User" do

  it "should return all users" do
    sources = Addwalk::Source.new(@service_provider.token, "LlFMICO1ktemg4cXpO_v1Q").get(status: "untagged")
    p sources
  end

  after(:each) do
    # this is here as an example, but is not really
    # necessary. Since each example is run in its
    # own object, instance variables go out of scope
    # between each example.
    @account = nil
  end

end
