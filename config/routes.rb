Rails.application.routes.draw do
  # シート一覧のルート
  get 'sheets/index'
  resources :sheets, only: [:index]

  # アプリの正常性確認用
  get "up" => "rails/health#show", as: :rails_health_check

  # 映画一覧と個別表示
  resources :movies, only: [:index, :show] do
    get 'reservation', to: 'movies#reservation' # 座席予約用のルート
    resources :schedules do
      resources :reservations, only: [:new, :create], controller: 'reservations'
    end
  end
  
   # テスト用に /reservations のPOSTルートを追加
  post 'reservations', to: 'reservations#create'
  
  # 管理画面のネストされたリソース
  namespace :admin do
    resources :movies, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
      resources :schedules, only: [:new, :create]
    end
    resources :schedules, only: [:index, :show, :edit, :update, :destroy]
  end


end
