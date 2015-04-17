Rails.application.routes.draw do
  get 'gitarchive/:archive' => 'gitarchive#archive'
end
