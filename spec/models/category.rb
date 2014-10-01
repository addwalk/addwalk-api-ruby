require 'spec_helper'

describe "Addwalk::Category" do

  it "returns all categories" do
    tags_request = Addwalk::Category.new(@service_provider.token).index(per: 30000)
    expect(tags_request[:success]).to eq(true)
    obj = []
    tags_request[:tags].each do |category|
      obj << { id: category["id"], identifier: category["identifier"], parent_id: category["parent_id"] }
      #expect(tag["name"]).to start_with "color_"
    end
    p obj.to_json
  end

end
