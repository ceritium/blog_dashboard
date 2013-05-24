BlogDashboard.configure do |config|

  config.post_public_path_expresion = '/posts/:id'
  config.i18n_support = true
  config.translates = {
    post: {
      fields: [:title, :body],
      fallbacks_for_empty_translations: true,
      relevant: :title
    },
    category: {
      fields: [:name],
      relevant: :name,
      fallbacks_for_empty_translations: true
    }

  }
end