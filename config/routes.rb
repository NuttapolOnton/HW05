Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/", to: "main#main";
  post "/select", to: "main#select";
  get "/main/test", to: "main#test";
  post "/submit", to: "main#submit";
  get "/result", to: "main#result";
  get "/main/showAll", to: "main#showAll"
  get "/score/list", to: "main#scoreList"
  get "/main/add", to: "main#add"
  get "/main/delete", to: "main#delete"
  get "main/edit", to: "main#edit"
  get "score/edit", to: "main#editScore"
  post "score/confirmedit", to: "main#confirmEdit"
  # Defines the root path route ("/")
  # root "articles#index"
end
