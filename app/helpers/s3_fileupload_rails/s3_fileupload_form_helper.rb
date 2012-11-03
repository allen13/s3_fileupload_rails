module S3FileuploadRails
  module S3FileuploadFormHelper
  	def s3_fileupload_form(options = {}, &block)
      uploader = S3Uploader.new(options)
      form_tag(uploader.url, uploader.form_options) do
        uploader.s3_fields.map do |name, value|
          hidden_field_tag(name, value)
        end.join.html_safe +
        file_field_tag(:file, multiple: true) +
        (capture(&block) if block)
      end
    end

    class S3Uploader
      def initialize(options)
        @options = options.reverse_merge(
          class: "s3-fileupload",
          bucket: ENV["AWS_S3_BUCKET"],
          aws_access_key_id: (ENV["AWS_ACCESS_KEY_ID"] ||= ""),
          acl: "public-read",
          expiration: 10.hours.from_now,
          max_file_size: 500.megabytes,
          as: "file"
        )
      end
  
      def form_options
        {
          class: @options[:class],
          method: "post",
          authenticity_token: false,
          multipart: true
        }
      end
  
      def s3_fields
        {
          :key => '',
          :acl => @options[:acl],
          :policy => '',
          :signature => '',
          "AWSAccessKeyId" => @options[:aws_access_key_id],
        }
      end
  
      def url
        "https://#{@options[:bucket]}.s3.amazonaws.com/"
      end
      
    end
  end
end


