module BlogDashboard
  class Configuration

    # The name of the before filter we'll call to authenticate the current user.
    # Defaults to :login_required
    attr_accessor :authentication_method

    # Should the routes of the main app be accessible without
    # the "main_app." prefix ?
    attr_accessor :inline_main_app_named_routes

    # Defaults to nil, use the layout of the BlogDashboard
    attr_accessor :layout

    # The name of the controller method we'll call to return the current_user.
    attr_accessor :current_user_method

    # Regular expresion for the public path of a post
    # accepted only :id as params
    # example: /posts/:id.html
    attr_accessor :post_public_path_expresion

    def initialize
      @inline_main_app_named_routes = false
      @current_user_method          = :current_user
      @authentication_method        = :authenticate_user!
    end

  end
end
