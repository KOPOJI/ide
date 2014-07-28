Ide::Application.routes.draw do
  resources :directories
  delete '/directories', to: 'directories#destroy'

  resources :data_sets, controller: 'files'

  get '/projects/:action', to: 'projects#:action', constraints: {action: /open|close/i}
  resources :projects

  root 'projects#index'
  get '/:project', to: 'directories#index', constraints: {project: /[-_.a-z0-9а-яёЁ]+/i}

  get 'file/:action', to: 'files#:action', constraints: {action: /index|new_(?:project|file(?:_from_template)?)|open_(?:project|file)|(?:close|save)_file|(?:close|save)_all_files|close_project|(?:default_)?settings|print/i}

  devise_for :users, path: 'user', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register',
    password: 'secret',
    confirmation: 'verification',
    unlock: 'unblock',
    registration: ''
  }

end
