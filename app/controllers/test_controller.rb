class TestController < ApplicationController
  before_filter :login_required
  
  layout "application.rhtml"

  def index
  end
end
