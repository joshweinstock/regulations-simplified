Rails.application.routes.draw do
  devise_for :users
  root to: "regulations#index"


  # Routes for the Regulation agency resource:

  # CREATE
  post("/insert_regulation_agency", { :controller => "regulation_agencies", :action => "create" })
          
  # READ
  get("/regulation_agencies", { :controller => "regulation_agencies", :action => "index" })
  
  get("/regulation_agencies/:path_id", { :controller => "regulation_agencies", :action => "show" })
  
  # UPDATE
  
  post("/modify_regulation_agency/:path_id", { :controller => "regulation_agencies", :action => "update" })
  
  # DELETE
  get("/delete_regulation_agency/:path_id", { :controller => "regulation_agencies", :action => "destroy" })

  #------------------------------

  # Routes for the Agency resource:

  # CREATE
  post("/insert_agency", { :controller => "agencies", :action => "create" })
          
  # READ
  get("/agencies", { :controller => "agencies", :action => "index" })
  
  get("/agencies/:path_id", { :controller => "agencies", :action => "show" })
  
  # UPDATE
  
  post("/modify_agency/:path_id", { :controller => "agencies", :action => "update" })
  
  # DELETE
  get("/delete_agency/:path_id", { :controller => "agencies", :action => "destroy" })

  #------------------------------

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
