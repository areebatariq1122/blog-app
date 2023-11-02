class CloudinaryService
    def initialize
      Cloudinary.config do |config|
        config.cloud_name = ENV["CLOUD_NAME"]
        config.api_key = ENV["CLOUD_API_KEY"]
        config.api_secret = ENV["CLOUD_API_SECRET"]
        config.secure = true
        config.cdn_subdomain = true
      end
    end
  
    def upload_image(uploaded_file)
      Cloudinary::Uploader.upload(uploaded_file.tempfile)
    end

  end
  