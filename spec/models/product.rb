require 'spec_helper'

describe "Addwalk::Product" do

  it "finds some basic products" do
    product_request = Addwalk::Product.new(@service_provider.token).index()
    expect(product_request[:success]).to eq(true)
    expect(product_request[:products].size).to eq(10)
  end

  it "finds products in category" do
    search_for_category = "area_apparel"
    category_request = Addwalk::Category.new(@service_provider.token).index(identifier: search_for_category)
    search_for_category_id = category_request[:categories].first[:id]

    products_request = Addwalk::Product.new(@service_provider.token).index(
      category_id: search_for_category_id,
      page_size: 100,
    )
    expect(products_request[:success]).to eq(true)
    expect(products_request[:products].size).to eq(100)

    products_request[:products].each do |product|
      # todo next
      # expect(product[:category_identifier]).to eq(category_request[:categories].first[:identifier])
    end
  end

  it "get a simple product" do
    # get token
    products_request = Addwalk::Product.new(@service_provider.token).index()
    expect(products_request[:success]).to eq(true)
    expect(products_request[:products].size).to eq(10)
    product_id = products_request[:products].first[:id].to_i
    expect(product_id).to be > 0

    # call product
    product_request = Addwalk::Product.new(@service_provider.token).show(product_id)
    expect(product_request[:success]).to eq(true)
    expect(product_request[:product][:id].to_i).to eq(product_id)
  end

  xit "finds product" do
    search_for_category = "area_apparel"
    category_request = Addwalk::Category.new(@service_provider.token).index(identifier: search_for_category)
    search_for_category_id = category_request[:categories].first[:id]

    products_request = Addwalk::Product.new(@service_provider.token).index(
      category_id: search_for_category_id,
      page_size: 100,
    )
    expect(products_request[:success]).to eq(true)
    expect(products_request[:products].size).to eq(100)

    products_request[:products].each do |product|
      expect(product[:category_identifier]).to eq(category_request[:categories].first[:identifier])
    end
  end


end
