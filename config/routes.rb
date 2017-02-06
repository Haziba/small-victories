Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :questionnaire do
    resources :question

    post '/answer', to: 'questionnaire#answer', as: :answer
  end
end
