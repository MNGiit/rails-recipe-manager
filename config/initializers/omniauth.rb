Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'] # client id and client secret
end
# , callback_path: '/login/auth/github/callback' 
# , :redirect_uri => 'http://localhost:3000/auth/github/callback'
# , {:provider_ignores_state => true, :redirect_uri => "http://localhost:3000/login/auth/github/callback"}