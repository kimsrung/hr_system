class HomeController < ApplicationController
  before_action :check_signed_in!
  def index
  end
end
