class FroalaController < ActionController::Base

  # Index.
  def index
    options = {
        bucket: 'bucket_name',
        region: 'us-east-1',
        keyStart: 'uploads/',
        acl: 'public-read',
        accessKey: 'aws_access_key',
        secretKey: 'aws_secret_key'
    }

    @aws_data = FroalaEditorSDK::S3.data_hash(options)
  end

  # Upload file.
  def upload_file
    render :json => FroalaEditorSDK::File.upload(params, { 
      file_upload_path: "public/uploads/files/",
      file_access_path: '/uploads/' 
    })
  end

  # Validate if file is smaller than 10Mb.
  def upload_file_validation
    render :json => FroalaEditorSDK::File.upload(params, {
      validation: Proc.new do |file, type|
        if File.size(file) > 10 * 1024 * 1024
          raise 'File size exceeded'
        end
      end,
      file_upload_path: "public/uploads/files/",
      file_access_path: '/uploads/'
    })
  end

  # Delete file.
  def delete_file
    render :json => FroalaEditorSDK::File.delete(params[:src], { 
      file_upload_path: "public/uploads/files/" 
    })
  end

  # Upload image.
  def upload_image
    render :json => FroalaEditorSDK::Image.upload(params, { 
      file_upload_path: "public/uploads/images/",
      file_access_path: '/uploads/' 
    })
  end

  # Upload image.
  def upload_image_jpeg
    render :json => FroalaEditorSDK::Image.upload(params, {
      validation: {
        allowedExts: ['.jpeg', '.jpg'],
        allowedMimeTypes: ['image/jpeg', 'image/pjpeg']
      },
      file_upload_path: "public/uploads/images/",
      file_access_path: '/uploads/'
    })
  end

  # Upload image.
  def upload_image_resize
    render :json => FroalaEditorSDK::Image.upload(params, {
      resize: {
        height: 300,
        width: 600
      },
      file_upload_path: "public/uploads/images/",
      file_access_path: '/uploads/'
    })
  end

  # Validate if image is square.
  def upload_image_validation
    render :json => FroalaEditorSDK::Image.upload(params, {
      validation: Proc.new do |file, type|
        img = MiniMagick::Image.open(file)
        if img.width != img.height
          raise 'Image is not square'
        end
      end,
      file_upload_path: "public/uploads/images/",
      file_access_path: '/uploads/'
    })
  end

  # Load images.
  def load_images
      render :json => FroalaEditorSDK::Image.load_images({
        file_upload_path: "public/uploads/images/", 
        file_access_path: '/uploads/' 
      })
  end

  # Delete image.
  def delete_image
      render :json => FroalaEditorSDK::Image.delete(params[:src], { 
        file_upload_path: "public/uploads/images/" 
      })
  end

  # Upload video.
  def upload_video
      render :json => FroalaEditorSDK::Video.upload(params, { 
        file_upload_path: "public/uploads/videos/",
        file_access_path: '/uploads/' 
      })
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