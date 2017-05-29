Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/upload_image' => 'froala#upload_image', :as => :froala_upload_image
  post '/upload_image_jpeg' => 'froala#upload_image_jpeg', :as => :froala_upload_image_jpeg
  post '/upload_image_resize' => 'froala#upload_image_resize', :as => :froala_upload_image_resize
  post '/upload_image_validation' => 'froala#upload_image_validation', :as => :froala_upload_image_validation
  post '/delete_image' => 'froala#delete_image', :as => :froala_delete_image

  post '/upload_file' => 'froala#upload_file', :as => :froala_upload_file
  post '/upload_file_validation' => 'froala#upload_file_validation', :as => :froala_upload_file_validation
  post '/delete_file' => 'froala#delete_file', :as => :froala_delete_file

  post '/upload_video' => 'froala#upload_video', :as => :froala_upload_video

  get '/uploads/:name' => 'froala#access_file', :as => :froala_upload_access_file, :name => /.*/
  get '/load_images' => 'froala#load_images', :as => :froala_load_images

  get '/' => 'froala#index', :as => :root
end
