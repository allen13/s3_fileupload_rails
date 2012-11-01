require 's3_fileupload_rails/view_helpers'
module S3FileuploadRails
  class Railtie < Rails::Railtie
    initializer "s3_fileupload_rails.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end