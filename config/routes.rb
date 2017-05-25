Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/upload_image' => 'upload#upload_image', :as => :upload_image
  post '/delete_image' => 'upload#delete_image', :as => :delete_image

  post '/upload_file' => 'upload#upload_file', :as => :upload_file
  post '/delete_file' => 'upload#delete_file', :as => :delete_file

  post '/upload_video' => 'upload#upload_video', :as => :upload_video

  get '/uploads/:name' => 'upload#access_file', :as => :upload_access_file, :name => /.*/
  get '/load_images' => 'upload#load_images', :as => :load_images

  get '/' => 'application#index', :as => :root
end
