# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_bcg_internal_web_session_id'
  
  #  Using plugin acts_as_authenticated
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie
  
  
  #  from http://snippets.dzone.com/posts/show/2016
   before_filter :instantiate_controller_and_action_names
   def instantiate_controller_and_action_names
       @current_action = action_name
       @current_controller = controller_name
   end

   before_filter :instantiate_sidebar_items
   def instantiate_sidebar_items    
       #quoting info from wikipedia
       @newsitems = %q*<h2>01.09.2006</h2>
       <p>This is where you can put your latest news.</p>
       <p><a href="#">read more ...</a></p>
       <p></p>
       <p></p>
       <h2>01.09.2006</h2>
       <p>This is where you can put your latest news.</p>
       <p><a href="#">read more ...</a></p>*

       @additional_links = %q*<ul>
               <li><a href="http://www.opendesigns.org">open designs</a></li>
               <li><a href="http://www.w3schools.com/xhtml/default.asp">learn XHTML</a></li>
               <li><a href="http://www.w3schools.com/css/default.asp">learn CSS</a></li>
               <li><a href="http://www.mozilla.com/firefox">get firefox</a></li>
             </ul>*
       @other_info = %q*      <p>
       	            This space can be used for additional information such as a contact phone number, address
       	            or maybe even a graphic.
       	          </p>*
   end
  
  
  
end
