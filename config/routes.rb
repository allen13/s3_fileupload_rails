S3FileuploadRails::Engine.routes.draw do
  #resources :s3_uploads
  get '/s3_upload' => 's3_upload#index'
  #root to: 's3_upload#index'
end
