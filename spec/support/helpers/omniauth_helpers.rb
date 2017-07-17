module OmniauthHelpers
  def mock_auth_hash(user = nil)
    user ||= build :user
    OmniAuth.config.mock_auth[:facebook] = facebook_hash(user)
  end

  private

  def facebook_hash(user)
    OmniAuth::AuthHash.new provider: 'facebook',
                           uid: user.uid,
                           info: facebook_info_hash(user),
                           credentials: {
                             token: 'mock_token',
                             expires_at: 1_321_747_205,
                             expires: true
                           }
  end

  def facebook_info_hash(user)
    {
      email: user.email,
      name: user.name,
      image: user.avatar_url
    }
  end
end
