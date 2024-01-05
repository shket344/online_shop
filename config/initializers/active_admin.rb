ActiveAdmin.setup do |config|
  config.site_title = 'Online Shop'
  config.site_title_link = :root
  config.authentication_method = :authenticate_user!
  config.authorization_adapter = ActiveAdmin::CanCanAdapter
  config.cancan_ability_class = 'Ability'
  config.on_unauthorized_access = :access_denied
  config.current_user_method = :current_user
  config.logout_link_path = :destroy_user_session_path
  config.comments = false
  config.comments_registration_name = 'AdminComment'
  config.comments_menu = false
  config.batch_actions = true
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]
  config.localize_format = :long
end
