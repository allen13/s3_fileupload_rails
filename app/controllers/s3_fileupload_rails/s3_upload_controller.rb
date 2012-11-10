module S3FileuploadRails
  class S3UploadController < ApplicationController

  	def index
      render json: {
        key: key,
        signature: signature,
        policy: policy
      }
    end

    private

      def key
        "uploads/#{SecureRandom.uuid}/#{(params[:file] if params)}"
      end
      
      def signature
        Base64.encode64(
          OpenSSL::HMAC.digest(
            OpenSSL::Digest::Digest.new('sha1'),
            ENV['AWS_SECRET_ACCESS_KEY'] ||= "", 
            policy
          )
        ).gsub("\n", "")
      end

      def policy
        Base64.encode64(policy_data.to_json).gsub("\n", "")
      end
  
      def policy_data
        {
          expiration: 10.hours.from_now,
          conditions: [
            ["starts-with", "$utf8", ""],
            ["starts-with", "$key", ""],
            ["content-length-range", 0, 500.megabytes],
            {bucket: (ENV['AWS_S3_BUCKET'] ||= "")},
            {acl: "public-read"}
          ]
        }
      end
  end
end
