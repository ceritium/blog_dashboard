BlogDashboard.configure do |config|
  config.post_public_path_expresion = '/posts/:id'
  config.i18n_support = true
  config.translates = {
    post: {
      title: true,
      body: true,
      relevant: :title
    }
  }
end