BlogDashboard.configure do |config|

  # The name of the before filter we'll call to authenticate the current user.
  # Defaults to :authenticate_user!
  config.authentication_method = :authenticate_user!

  # The name of the controller method we'll call to return the current_user.
  config.current_user_method = :current_user


  # Should the routes of the main app be accessible without
  # the "main_app." prefix ?
  # config.inline_main_app_named_routes

  # Defaults to nil, use the layout of the BlogDashboard
  # config.layout = nil


  # Regular expresion for the public path of a post
  # accepted only :id as params
  # config.post_public_path_expresion = '/posts/:id'

  # I18n support
  # config.i18n_support = false
  # config.translates = {
  #   post: {
  #     fields: [:title, :body, :slug],
  #     fallbacks_for_empty_translations: true,
  #     relevant: :title
  #   },
  #   category: {
  #     fields: [:name, :slug],
  #     relevant: :name,
  #     fallbacks_for_empty_translations: true
  #   }
  # }


end