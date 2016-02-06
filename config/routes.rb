Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  # TODO get?
  get 'logout', to: 'sessions#destroy'
  get 'login', to: 'sessions#new'

  namespace :api do
    resources :user_exams, only: [:index, :update, :destroy] do
      member do
        put :sync_user_answers
      end
    end

    get 'user_exams/:exam_id', to: 'user_exams#show'

    resources :exams, only: [:show, :update]
  end

  resources :exams, only: [:index]

  get '/fb-privacy-policy', to: 'home#fb_privacy_policy'

  get 'api' => proc { [404, {}, ['Invalid API endpoint']] }
  get 'api/*path' => proc { [404, {}, ['Invalid API endpoint']] }

  # TODO: Hack for serving fonts from cuirass, lol
  get '/fonts/:name.:ext', to: redirect('/assets/%{name}.%{ext}')

  root 'home#index'
  # TODO: 404
  # get '*path', to: 'home#index'
end
