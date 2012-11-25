require 'jquery-fileupload-rails'
require 'jquery-rails'
require 'sass-rails'
require 'ruby-haml-js'
require 'coffee-rails'

module S3FileuploadRails
  class Engine < ::Rails::Engine
    isolate_namespace S3FileuploadRails

    initializer 's3_fileupload_rails.s3_fileupload_form_helper' do
      ActionView::Base.send :include, S3FileuploadFormHelper
    end
  end
end


