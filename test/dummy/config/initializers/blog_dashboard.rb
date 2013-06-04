BlogDashboard.configure do |config|

  # A simple blog to test the data on http://../demo
  # Can copy demo blog files to your application with:
  # $ rake blog_dashboard:demo
  # config.demo_blog = false

  # Regular expresion for the public path of a post
  # accepted only :post_id as params
  # config.post_public_path_expresion = '/demo/posts/:post_id'


  # The name of the before filter we'll call to authenticate the current user.
  # Defaults to :authenticate_user!
  # config.authentication_method = :authenticate_user!

  # The name of the controller method we'll call to return the current_user.
  # config.current_user_method = :current_user


  # Should the routes of the main app be accessible without
  # the "main_app." prefix ?
  # config.inline_main_app_named_routes

  # Defaults to nil, use the layout of the BlogDashboard
  # config.layout = nil


  # I18n support
  config.i18n_support = true
  # Models and fields with i18n support
  config.translates = {
    post: {
      fields: [:title, :body, :slug],
      fallbacks_for_empty_translations: true,
      relevant: :title
    },
    category: {
      fields: [:name, :slug],
      relevant: :name,
      fallbacks_for_empty_translations: true
    }
  }


end