class UploadController < ActionController::Base

  def upload_file
    render :json => FroalaEditor::File.upload(params, "public/uploads/files/")
  end

  def delete_file
    render :json => FroalaEditor::File.delete(params[:src], "public/uploads/files/")
  end


  def upload_image
    options = {
        fieldname: 'file',
        validation: {
            allowedExts: [".gif", ".jpeg", ".jpg", ".png", ".svg", ".blob"],
            allowedMimeTypes: [ "image/gif", "image/jpeg", "image/pjpeg", "image/x-png", "image/png", "image/svg+xml" ]
        },
        resize: {
            height: 200,
            width: 600
        }
    }

    render :json => FroalaEditor::Image.upload(params, "public/uploads/images/", options)
  end

  def load_images
      render :json => FroalaEditor::Image.load_images("public/uploads/images/")
  end

  def delete_image
      render :json => FroalaEditor::Image.delete(params[:src], "public/uploads/images/")
  end

  def upload_video
      render :json => FroalaEditor::Video.upload(params,"public/uploads/videos/")
  end

  def access_file
    if File.exists?(Rails.root.join('public', 'uploads', 'images', params[:name]))
      send_data File.read(Rails.root.join('public', 'uploads', 'images', params[:name])), :filename => ::File.basename(params[:name]), :disposition => 'inline'
    else
      render :nothing => true
    end
  end

end