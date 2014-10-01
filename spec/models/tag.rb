require 'spec_helper'

describe "Addwalk::Tag" do

  xit "get all tags" do
    tags_request = Addwalk::Tag.new(@service_provider.token).index(per: 100)
    expect(tags_request[:success]).to eq(true)
    expect(tags_request[:tags].size).to be > 80
    expect(tags_request[:tags].size).to be == 100
    #@source_sets = tags_request[:tags_request]
  end

  it "returns all tags" do
    tags_request = Addwalk::Tag.new(@service_provider.token).index(per: 30000)
    expect(tags_request[:success]).to eq(true)
    obj = []
    tags_request[:tags].each do |tag|
      obj << { id: tag["id"], name: tag["name"], parent_id: tag["parent_id"] }
      #expect(tag["name"]).to start_with "color_"
    end
    p obj.to_json
  end

  xit "returns all colors" do
    tags_request = Addwalk::Tag.new(@service_provider.token).index(type: 'color', per: 20)
    expect(tags_request[:success]).to eq(true)
    tags_request[:tags].each do |tag|
      expect(tag["name"]).to start_with "color_"
    end
    #@source_sets = tags_request[:tags_request]
  end

  xit "returns all features" do
    tags_request = Addwalk::Tag.new(@service_provider.token).index()
    expect(tags_request[:success]).to eq(true)
    expect(tags_request[:tags].size).to be > 80
    #@source_sets = tags_request[:tags_request]
  end

end
