Rails.application.routes.draw do
  devise_for :users
  root to: "regulations#index"


  # Routes for the Bookmark resource:

  # CREATE
  post("/insert_bookmark", { :controller => "bookmarks", :action => "create" })
          
  # READ
  get("/bookmarks", { :controller => "bookmarks", :action => "index" })
  
  get("/bookmarks/:path_id", { :controller => "bookmarks", :action => "show" })
  
  # UPDATE
  
  post("/modify_bookmark/:path_id", { :controller => "bookmarks", :action => "update" })
  
  # DELETE
  get("/delete_bookmark/:path_id", { :controller => "bookmarks", :action => "destroy" })

  #------------------------------

  # Routes for the Regulation resource:

  # CREATE
  post("/insert_regulation", { :controller => "regulations", :action => "create" })
          
  # READ
  get("/regulations", { :controller => "regulations", :action => "index" })
  
  get("/regulations/:path_id", { :controller => "regulations", :action => "show" })
  
  # UPDATE
  
  post("/modify_regulation/:path_id", { :controller => "regulations", :action => "update" })
  
  # DELETE
  get("/delete_regulation/:path_id", { :controller => "regulations", :action => "destroy" })

  #------------------------------

  
end
