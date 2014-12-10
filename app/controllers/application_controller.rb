class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def refresh_database
    DatabaseRefresher.refresh
  end
end
