require 'spec_helper'

describe "Addwalk::Shop" do

  it "get all shop" do
    tags_request = Addwalk::Shop.new(@service_provider.token).index(page_size: 100)
    expect(tags_request[:success]).to eq(true)
    expect(tags_request[:shops].size).to be > 80
    expect(tags_request[:shops].size).to be == 100
  end

end
