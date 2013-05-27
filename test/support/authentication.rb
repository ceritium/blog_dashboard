def mock_login
  @current_user = User.new
  @current_user.email =  'user@foo.bar'
  @current_user.password = @current_user.password_confirmation = 'monkeymonkey'
  @current_user.save
  @request.env["devise.mapping"] = Devise.mappings[:user]
  sign_in :user, @current_user
end

def reset_configuration
  BlogDashboard.configure do |config|
    config.current_user_method = :current_user
    config.authentication_method = :authenticate_user!
  end
end