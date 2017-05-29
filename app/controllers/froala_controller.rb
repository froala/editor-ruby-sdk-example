class FroalaController < ActionController::Base

  # Index.
  def index
    options = {
        bucket: ENV['S3_BUCKET'],
        region: ENV['S3_REGION'],
        keyStart: ENV['S3_KEY_START'],
        acl: 'public-read',
        accessKey: ENV['S3_ACCESS_KEY'],
        secretKey: ENV['S3_SECRET_KEY']
    }

    @aws_data = FroalaEditorSDK::S3.data_hash(options)
  end

  # Upload file.
  def upload_file
    render :json => FroalaEditorSDK::File.upload(params, "public/uploads/files/")
  end

  # Delete file.
  def delete_file
    render :json => FroalaEditorSDK::File.delete(params[:src], "public/uploads/files/")
  end

  # Upload image.
  def upload_image
    render :json => FroalaEditorSDK::Image.upload(params, "public/uploads/images/")
  end

  # Upload image.
  def upload_image_jpeg
    render :json => FroalaEditorSDK::Image.upload(params, "public/uploads/images/", {
      validation: {
        allowedExts: ['.jpeg', '.jpg'],
        allowedMimeTypes: ['image/jpeg', 'image/pjpeg']
      }
    })
  end

  # Upload image.
  def upload_image_resize
    render :json => FroalaEditorSDK::Image.upload(params, "public/uploads/images/", {
      resize: {
        height: 300,
        width: 600
      }
    })
  end

  # Load images.
  def load_images
      render :json => FroalaEditorSDK::Image.load_images("public/uploads/images/")
  end

  # Delete image.
  def delete_image
      render :json => FroalaEditorSDK::Image.delete(params[:src], "public/uploads/images/")
  end

  # Upload video.
  def upload_video
      render :json => FroalaEditorSDK::Video.upload(params,"public/uploads/videos/")
  end

  # Access uploaded files.
  def access_file
    if File.exists?(Rails.root.join('public', 'uploads', 'images', params[:name]))
      send_data File.read(Rails.root.join('public', 'uploads', 'images', params[:name])), :filename => ::File.basename(params[:name]), :disposition => 'inline'
    else
      render :nothing => true
    end
  end

end