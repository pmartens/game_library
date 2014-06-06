Rails.application.routes.draw do

  mount GameLibrary::Engine => "/game_library"
end
