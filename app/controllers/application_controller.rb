# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
private
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
    before_filter :adjust_format_for_iphone
  def adjust_format_for_iphone
    request.format = :iphone if iphone_request?
  end 
  def iphone_request?
    (agent = request.env["HTTP_USER_AGENT"]) && agent[/(Mobile\/.+Safari)/]
  end

end
