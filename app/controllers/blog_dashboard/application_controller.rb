module BlogDashboard
  class ApplicationController < ::ApplicationController


    private

    before_filter :set_locale

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options(options={})
      logger.debug "default_url_options is passed options: #{options.inspect}\n"
      { locale: I18n.locale }
    end

    helper_method :current_user, :blog_dashboard_conf

    def self.blog_dashboard_authenticate(options ={})
      if blog_dashboard_conf.authentication_method.present?
        before_filter blog_dashboard_conf.authentication_method
      end
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
