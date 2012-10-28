require 'spec_helper'

describe S3FileuploadRails::S3UploadController do
  describe "response" do
    it "responds with json" do
      get :index ,use_route: :s3_fileupload_rails
      response.should be_success
      body = JSON.parse(response.body)
      body.should include('key')
    end
  end
end
