class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(auth)

    if user.persisted?

      # update tokens

      #user.update_attributes({:oauth_token => auth['credentials']['token'],
      #                        :oauth_secret => auth['credentials']['token']}, :without_protection => true)

      sign_in_and_redirect user
    else
      session['devise.user_attributes'] = user.attributes
      redirect_to register_url
    end
  end

  def new_session_path(auth)
    # no alternative session creation. redirecting to root.
    root_path
  end

  alias_method :fitbit, :all
end
