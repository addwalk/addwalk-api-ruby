require 'spec_helper'

describe "Addwalk::SourceSet" do

  before :all do
    @source_set = Addwalk::SourceSet.new(@service_provider.token).create({
      name: "test name",
      description: "test description"
    })
  end

  it "should create a new source_set" do
    expect(@source_set[:success]).to eq(true)
  end

  it "lists all source_sets of user" do
    source_set_request = Addwalk::SourceSet.new(@service_provider.token).index()
    expect(source_set_request[:success]).to eq(true)
    expect(source_set_request[:source_sets].size).to eq(1)
  end

  it "should find a new source_set by id" do
    new_source_set = Addwalk::SourceSet.new(@service_provider.token).show(@source_set[:source_set][:id])
    expect(@source_set[:source_set]).to eq(new_source_set[:source_set])
  end

  it "should find a new source_set by token" do
    new_source_set2 = Addwalk::SourceSet.new(@service_provider.token).show(@source_set[:source_set][:token])
    expect(@source_set[:source_set]).to eq(new_source_set2[:source_set])
  end

  it "should update a source_set by id" do
    updated_source_set = Addwalk::SourceSet.new(@service_provider.token).update(@source_set[:source_set][:id], {
      name: "new test name",
      description: "new test description"
    })

    # check the response
    expect(updated_source_set[:success]).to eq(true)
    expect(updated_source_set[:source_set][:name]).to eq("new test name")

    # check if saved correctly
    new_source_set = Addwalk::SourceSet.new(@service_provider.token).show(@source_set[:source_set][:id])
    expect(new_source_set[:source_set][:name]).to eq("new test name")
    expect(new_source_set[:source_set][:description]).to eq("new test description")
  end

  it "should destroy a source_set" do

    source_set_new = Addwalk::SourceSet.new(@service_provider.token).create({
      name: "test name",
      description: "test description"
    })

    deleted_source = Addwalk::SourceSet.new(@service_provider.token).destroy(source_set_new[:source_set][:id])
    expect(deleted_source[:success]).to eq(true)

    new_source_set2 = Addwalk::SourceSet.new(@service_provider.token).show(source_set_new[:source_set][:id])
    expect(new_source_set2[:success]).to eq(false)

  end

  after :all do
    Addwalk::SourceSet.new(@service_provider.token).destroy(@source_set[:source_set][:id])
  end

end
