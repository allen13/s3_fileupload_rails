Rails.application.routes.draw do
  root to: 'home#index'
  mount S3FileuploadRails::Engine => "/s3_fileupload_rails"
end
