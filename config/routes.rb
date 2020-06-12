Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'
  resources :users, only: [:edit, :update]
  resources :groups, only: [:new, :create, :edit, :update]
end



# messageのindexは恐らく後ほど追加。
# indexアクションカリキュラムだと2回記載している。