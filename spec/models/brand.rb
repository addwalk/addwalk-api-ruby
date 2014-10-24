require 'spec_helper'

describe "Addwalk::Brand" do

  it "get all tags" do
    tags_request = Addwalk::Brand.new(@service_provider.token).index(per: 100)
    p tags_request
    expect(tags_request[:success]).to eq(true)
    expect(tags_request[:brands].size).to be > 80
    expect(tags_request[:brands].size).to be == 100

    #@source_sets = tags_request[:tags_request]
  end

end
