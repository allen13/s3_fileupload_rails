require 'spec_helper'

def s3_fields
  [
    :key,
    :acl,
    :policy,
    :signature ,
    :AWSAccessKeyId
  ]
end

describe S3FileuploadRails::S3FileuploadFormHelper do

  before :each do
    @form = helper.s3_fileupload_form   
  end

  it "should be a multipart form" do
    @form.should have_selector 'form.s3-fileupload[enctype="multipart/form-data"][action][method=post]'
  end

  it "should have s3 hidden inputs" do
    s3_fields.map do |name|
      @form.should have_selector "input##{name}[name=#{name}][type=hidden][value]"
    end
  end

  it "should have file input" do
    @form.should have_selector "input#file[type=file]"
  end
end
