Rails.application.routes.draw do
  resources :banners
  resources :campaigns
  resources :banners
  resources :banner_videos
  resources :targets
  resources :rtb_standards
  resources :documents
  resources :categories
  resources :users
  resources :attachments
  resources :lists

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  
  get '/myaccount' => 'users#myaccount'
  patch '/myaccountUpdate' => 'users#myaccountUpdate'
  
  root 'dashboards#home'
  get '/' => 'dashboards#home'
  get 'dashboards/campaigndetail' => 'dashboards#campaigndetail'  
  
  get 'dashboards' => 'dashboards#home'
  get 'dashboards/home' => 'dashboards#home'
  
  get 'reports' => 'reports#home'
  get 'reports/home' => 'reports#home'
  
  get 'getCampaignDates' => 'campaigns#getDates'
  get 'getExchangeAttributes' => 'campaigns#getExchangeAttributes'
  get 'biddersSynchAll' => 'campaigns#biddersSynchAll'
  
  get 'duplicatedoc' => 'documents#duplicate'
  get 'duplicatertb_standard' => 'rtb_standards#duplicate'  
  
  get 'help' => 'help#list'
  get 'help/list' => 'help#list'
  get 'help/open' => 'help#open'
  
  post '/attachments/create' => 'attachments#create'
  
  post "/lists/upload" => "lists#upload"


 namespace :api, defaults: {format: 'json'} do
     namespace :v1 do
      namespace :report do
        post 'summary'
        get 'summary'
      end
    end
  end  
  
end
