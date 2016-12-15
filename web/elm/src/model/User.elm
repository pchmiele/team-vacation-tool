module Model.User exposing (..)

type alias Model = 
  { email : String
  , password : String
  }

empty_user : Model
empty_user =
  { email = ""
  , password = ""
  }

update_password : Model -> String -> Model
update_password user new_password = 
  { user | password = new_password }


update_email : Model -> String -> Model
update_email user new_email = 
  { user | email = new_email }