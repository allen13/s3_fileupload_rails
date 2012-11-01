require_dependency "s3_fileupload_rails/application_controller"

module S3FileuploadRails
  class S3UploadController < ApplicationController
  	def index
  	  render json: '{"key":"/upload/path"}'
  	end

  	def index
      render json: {
        policy: s3_upload_policy_document,
        signature: s3_upload_signature,
        key: "uploads/#{SecureRandom.uuid}/"
      }
    end

    private

      # generate the policy document that amazon is expecting.
      def s3_upload_policy_document
        Base64.encode64(
          {
            expiration: 30.minutes.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z'),
            conditions: [
              { bucket: ENV['AWS_S3_BUCKET'] ||= "" },
              { acl: 'public-read' },
              ["starts-with", "$key", "uploads/"],
              { success_action_status: '201' }
            ]
          }.to_json
        ).gsub(/\n|\r/, '')
      end
  
      # sign our request by Base64 encoding the policy document.
      def s3_upload_signature
        Base64.encode64(
          OpenSSL::HMAC.digest(
            OpenSSL::Digest::Digest.new('sha1'),
            ENV['AWS_SECRET_ACCESS_KEY'] ||= "",
            s3_upload_policy_document
          )
        ).gsub(/\n/, '')
      end
  end
end
