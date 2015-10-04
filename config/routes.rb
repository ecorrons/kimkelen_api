Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :students, only: [:show] do
      	member do
      		get 'marks/:school_year', to: 'students#marks'
          get 'absences/:school_year', to: 'students#absences'
          get 'disciplinary_sanctions/:school_year', to: 'students#disciplinary_sanctions'
          get 'school_years', to: 'students#school_years'
      	end
      end
      resources :tutors, only: [:show]
      resources :school_years, only: [:index]
    end
  end
  get '*unmatched_route', to: 'application#invalid_request'
  
end