# Be sure to restart your server when you modify this file.

# HaonzhaoAdmin::Application.config.session_store :cookie_store, key: '_haonzhao_admin_session'
HaonzhaoAdmin::Application.config.session_store :active_record_store, {:key => '_haonzhao_admin_session', :secret => '34292119910727272X', expire_after: 30.minutes}
ActiveRecord::SessionStore::Session.attr_accessible :data, :session_id