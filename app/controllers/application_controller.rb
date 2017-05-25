class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    options = {
        bucket: 'froala-radu-us',
        region: 's3',
        keyStart: 'editor/',
        acl: 'public-read',
        accessKey: 'AKIAJP7HA6M5JSUYWXEA',
        secretKey: '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'
    }
    @aws_data = FroalaEditor::S3.data_hash(options)

    respond_to do |format|
        format.html {render :template => 'index.html.erb'}
      end
  end
end