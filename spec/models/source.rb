require 'spec_helper'

describe "Addwalk::Source" do

  def create_random_source source_set_id = 0
    source = Addwalk::Source.new(@service_provider.token).create({
      url: "http://www.testimage.com/"+((0...8).map { (65 + rand(26)).chr }.join)+".jpg",
      source_set_id: source_set_id
    })
    return source
  end

  before :all do
    source_set_request = Addwalk::SourceSet.new(@service_provider.token).create({
      name: "test source set",
      description: "test description"
    })
    expect(source_set_request[:success]).to eq(true)
    @source_set = source_set_request[:source_set]
  end

  it "should fail while creating a new source without source_set" do
    source = Addwalk::Source.new(@service_provider.token).create({
      url: "http://www.testimage.com/"+((0...8).map { (65 + rand(26)).chr }.join)+".jpg",
    })
    expect(source[:success]).to eq(false)
  end

  it "should create a new source in source_set with source_set_id" do
    source = create_random_source(@source_set[:id])

    expect(source[:success]).to eq(true)
    expect(source[:source][:source_set_id]).to eq(@source_set[:id])
    expect(source[:source][:id]).to be > 0

    Addwalk::Source.new(@service_provider.token).destroy(source[:source][:id])
  end

  it "should create a new source in source_set with source_set_token" do
    source = create_random_source(@source_set[:token])

    expect(source[:success]).to eq(true)
    expect(source[:source][:source_set_id]).to eq(@source_set[:id])
    expect(source[:source][:id]).to be > 0

    Addwalk::Source.new(@service_provider.token).destroy(source[:source][:id])
  end


  xit "should return all sources of a source_set by source_set_id" do
    sources = Addwalk::Source.new(@service_provider.token).index({ source_set_id: @source_set.id })
    sources.count.should == 0
  end

  xit "should return all sources of a source_set by token" do
    sources = Addwalk::Source.new(@service_provider.token).index({ token: @source_set.token })
    sources.count.should == 0
  end

  it "should create and find a new source" do
    source = create_random_source(@source_set[:token])

    new_source = Addwalk::Source.new(@service_provider.token).show(source[:source][:id])
    expect(new_source[:source]).to eq(source[:source])

    destroyed_source = Addwalk::Source.new(@service_provider.token).destroy(source[:source][:id])
    destroyed_source[:success] = true
  end

  it "should update a source" do
    source = create_random_source(@source_set[:token])

    updated_source = Addwalk::Source.new(@service_provider.token).update(source[:source][:id], {
      name: "new test name",
      description: "new test description"
    })

    # check the response
    expect(updated_source[:success]).to eq(true)
    expect(updated_source[:source][:name]).to eq("new test name")

    # check if saved correctly
    new_source = Addwalk::Source.new(@service_provider.token).show(source[:source][:id])
    expect(new_source[:source][:name]).to eq("new test name")
    expect(new_source[:source][:description]).to eq("new test description")

    destroyed_source = Addwalk::Source.new(@service_provider.token).destroy(source[:source][:id])
    destroyed_source[:success] = true
  end

  it "should delete a source" do
    source = create_random_source(@source_set[:token])
    expect(source[:success]).to eq(true)

    destroyed_source = Addwalk::Source.new(@service_provider.token).destroy(source[:source][:id])
    destroyed_source[:success] = true

    destroyed_source = Addwalk::Source.new(@service_provider.token).show(source[:source][:id])
    destroyed_source[:success] = false
  end

  it "should create a new source with source-set-name" do
    # Ich verwende im Model zwei werte:
    # url -> Bild-URL z.B. http://cdn1.twitter.com/jydhgfjhsfg/sdfhjg_dhsgfhsdgfjaadsf.jpg
    # original_source_url -> Bild zum Post z.B. http://twitter.com/pin/1114
    source_request = Addwalk::Source.new(@service_provider.token).create({
      name: "test source set 123",
      description: "test description",
      url: "http://www.testimages.com/image1.jpg",
      original_source_url: "http://www.testimages.com/post1",
      source_set: {
        name: @source_set[:name]
      }
    });

    expect(source_request[:success]).to eq(true)
    source = source_request[:source]
    source[:source_set_id].should == @source_set[:id]

    destroyed_source = Addwalk::Source.new(@service_provider.token).destroy(source[:id])
    destroyed_source[:success] = true
  end

  it "should create a new source with source-set-id" do
    source_request = Addwalk::Source.new(@service_provider.token).create({
      name: "test source set 123",
      description: "test description",
      url: "http://www.testimages.com/image1.jpg",
      original_source_url: "http://www.testimages.com/post1",
      source_set: {
        id: @source_set[:id]
      }
    });

    expect(source_request[:success]).to eq(true)
    source = source_request[:source]
    source[:source_set_id].should == @source_set[:id]

    destroyed_source = Addwalk::Source.new(@service_provider.token).destroy(source[:id])
    destroyed_source[:success] = true
  end

  it "should create a new source with one item" do
    source_request = Addwalk::Source.new(@service_provider.token).create({
      name: "test source set 123",
      description: "test description",
      url: "http://www.testimages.com/image1.jpg",
      original_source_url: "http://www.testimages.com/post1",
      source_set: {
        id: @source_set[:id]
      },
      items: [
        {
          x: "10.0",
          y: "10.0",
          tags: [ "gender_men", "color_green", "color_red","capstypes_ballooncap" ]
        },{
          x: "15.0",
          y: "15.0",
          tags: [ "color_black" ]
        }
      ]
    });

    expect(source_request[:success]).to eq(true)
    source = source_request[:source]
    source[:source_set_id].should == @source_set[:id]

    # check items and tags
    source[:items].size.should == 2
    source[:items].each do |item|
      if item[:x] == 10.0
        item[:tags].size.should == 4
      else
        item[:tags].size.should == 1
      end
    end

    destroyed_source = Addwalk::Source.new(@service_provider.token).destroy(source[:id])
    destroyed_source[:success] = true
  end

  after :all do
    Addwalk::SourceSet.new(@service_provider.token).destroy(@source_set[:id])
  end

end
