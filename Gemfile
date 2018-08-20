source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'
gem 'rails', '~> 5.2.1'
gem 'puma', '~> 3.11'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false

gem 'rack-cors'
gem 'devise'

gem 'jwt'

group :development, :test do
  gem 'faker', "~> 1.9.1"
  gem 'sqlite3'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', ">= 3.4.4"
  gem 'factory_girl_rails', "~> 4.4.1"
  gem 'rails-controller-testing'
end

group :test do
  gem 'capybara', "~> 2.4.3"
  gem 'database_cleaner', "~> 1.3.0"
  gem 'launchy', "~> 2.4.2"
  gem 'selenium-webdriver', "~> 2.43.0"
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg', '0.18.1'
  gem 'rails_12factor', group: :production
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
