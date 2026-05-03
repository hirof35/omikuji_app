Rails.application.routes.draw do
  root 'omikuji#show'
  # 履歴削除用のルート
  delete 'omikuji/destroy_all', to: 'omikuji#destroy_all', as: 'destroy_all_results'
end