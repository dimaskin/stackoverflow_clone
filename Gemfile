source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'slim'
gem 'devise'


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # gem 'rspec-rails'
  gem 'rspec-core', git: 'https://github.com/rspec/rspec-core'
  gem 'rspec-expectations', git: 'https://github.com/rspec/rspec-expectations'
  gem 'rspec-mocks', git: 'https://github.com/rspec/rspec-mocks'
  gem 'rspec-rails', git: 'https://github.com/rspec/rspec-rails' #, branch: '4-0-dev'
  gem 'rspec-support', git: 'https://github.com/rspec/rspec-support'

  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
  gem 'launchy'
  gem 'selenium-webdriver'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
