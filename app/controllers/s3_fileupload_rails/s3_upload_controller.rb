require_dependency "s3_fileupload_rails/application_controller"

module S3FileuploadRails
  class S3UploadController < ApplicationController
  	def index
  	  render json: '{"key":"/upload/path"}'
  	end

  	def index
      render json: {
        policy: policy,
        signature: signature,
        key: key
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

    def key
      "uploads/#{SecureRandom.uuid}/#{(params[:file] if params)}"
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

    def signature
      Base64.encode64(
        OpenSSL::HMAC.digest(
          OpenSSL::Digest::Digest.new('sha1'),
          ENV['AWS_SECRET_ACCESS_KEY'] ||= "", 
          policy
        )
      ).gsub("\n", "")
    end

  end
end
