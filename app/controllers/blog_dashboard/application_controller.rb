module BlogDashboard
  class ApplicationController < ::ApplicationController

    before_filter :set_locale

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options(options={})
      logger.debug "default_url_options is passed options: #{options.inspect}\n"
      { locale: I18n.locale }
    end

    # before_filter :authenticate_user!
    helper_method :current_user, :blog_dashboard_conf

    def self.blog_dashboard_authenticate(options ={})
      before_filter blog_dashboard_conf.authentication_method, options
    end


    # A helper method to access the BlogDashboard::configuration
    # at the class level
    def self.blog_dashboard_conf
      BlogDashboard::configuration
    end


    # A helper method to access the BlogDashboard::configuration
     # at the controller instance level
     def blog_dashboard_conf
       self.class.blog_dashboard_conf
     end

     # Returns the currently logged in blogger by calling
     # whatever BlogDashboard.current_user_method is set to
     def current_user_method
       send blog_dashboard_conf.current_user_method
     end


  end
end
