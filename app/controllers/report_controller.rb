class ReportController < ApplicationController
  
  #  require a login to do anything with this controller. (can't see reports without login)
  before_filter :login_required

  def index
    redirect_to(:action => 'report')
  end
  def report
  end
end
