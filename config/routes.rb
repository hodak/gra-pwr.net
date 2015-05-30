Rails.application.routes.draw do
  namespace :api do
    resources :user_exams, only: [:index] do
      member do
        put :sync_user_answers
      end
    end
  end

  get 'api' => proc { [404, {}, ['Invalid API endpoint']] }
  get 'api/*path' => proc { [404, {}, ['Invalid API endpoint']] }

  root 'home#index'
  get '*path', to: 'home#index'
end

