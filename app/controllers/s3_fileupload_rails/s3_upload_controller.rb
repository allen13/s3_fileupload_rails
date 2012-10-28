require_dependency "s3_fileupload_rails/application_controller"

module S3FileuploadRails
  class S3UploadController < ApplicationController
  	def index
  	  render json: '{"key":"/upload/path"}'
  	end
  end
end
