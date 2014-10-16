require 'spec_helper'

describe "Addwalk::Category" do

  it "returns all categories" do
    category_request = Addwalk::Category.new(@service_provider.token).index()
    expect(category_request[:success]).to eq(true)
    #obj = []
    # tags_request[:tags].each do |category|
    #   obj << { id: category[:id], identifier: category[:identifier], parent_id: category[:parent_id] }
    # end

    expect(category_request[:success]).to eq(true)
    expect(category_request[:categories].size).to eq(10)
  end

  it "returns categories with identifier like area_apparel" do
    search_for_category = "area_apparel"
    category_request = Addwalk::Category.new(@service_provider.token).index(identifier: search_for_category)
    expect(category_request[:success]).to eq(true)

    expect(category_request[:success]).to eq(true)
    expect(category_request[:categories].size).to eq(1)
    expect(category_request[:categories].first[:identifier]).to eq(search_for_category)
  end

  it "returns categories with parent_id = 0" do
    # get valid category
    search_for_category = "area_apparel"
    category_request = Addwalk::Category.new(@service_provider.token).index(identifier: search_for_category)
    search_for_parent_id = category_request[:categories].first[:id]

    category_request = Addwalk::Category.new(@service_provider.token).index(parent_id: search_for_parent_id, per_page: 1000)
    expect(category_request[:success]).to eq(true)
    category_request[:categories].each do |category|
      expect(category[:parent_id]).to eq(search_for_parent_id)
    end
  end

end
