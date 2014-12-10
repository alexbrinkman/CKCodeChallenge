class HomeController < ApplicationController
  before_filter :refresh_database
end
