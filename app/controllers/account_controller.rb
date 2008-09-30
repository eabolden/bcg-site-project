class AccountController < ApplicationController
  
  #  require a login to do anything with this controller. (can't see reports without login)
#before_filter :login_required, :except => :login
  #  Put include AuthenticatedSystem in your application controller (make sure you put it in the class, not before it), and put before_filter :login_required in every controller you want protected. More details in account_controller.rb.
  
  #  To get to user info inside a controller or view (like, say, their login name):
  #  current_user.login
  # Be sure to include AuthenticationSystem in Application Controller instead
  #include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  #before_filter :login_from_cookie
  
  # say something nice, you goof!  something sweet.
  def index
    redirect_to(:action => 'signup') unless logged_in? || User.count > 0
  end

  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default(:controller => '/account', :action => 'index')
      flash[:notice] = "Logged in successfully"
    end
  end


  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => '/account', :action => 'index')
  end
  
  def signup
    if logged_in?
      begin
      		@user = User.new(params[:user])
          return unless request.post?
          @user.save!
          self.current_user = @user
          redirect_back_or_default(:controller => '/account', :action => 'index')
          flash[:notice] = "Thanks for signing up!"
      rescue ActiveRecord::RecordInvalid 
          render :action => 'signup'
      end
    else
      flash[:notice] = "Must be logged in to create an account"
      redirect_to(:controller => "account", :action => "login")
    end

  end
  
  private
  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_uri] = request.request.uri
      flash[:notice] = "Please log in"
      redirect_to(:controller => "login", :action => "login")
    end
  end
  

  
end
