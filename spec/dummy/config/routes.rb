Rails.application.routes.draw do
  mount S3FileuploadRails::Engine => "/s3_fileupload_rails"
end
