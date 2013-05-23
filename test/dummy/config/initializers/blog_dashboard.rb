BlogDashboard.configure do |config|

  config.post_public_path_expresion = '/posts/:id'
  config.i18n_support = true
  config.translates = {
    post: {
      title: true,
      body: false,
      fallbacks_for_empty_translations: true
    },
    category:{
      name: true,
      fallbacks_for_empty_translations: true
    }

  }
end