source 'https://rubygems.org'

gem 'rails', '~> 5.2.3'
gem 'sassc-rails'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer',  platforms: :ruby
gem 'kaminari', '~> 1.2.1'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.9'
gem 'sdoc', '~> 1.0.0',          group: :doc

gem 'bootstrap-sass', '~> 3.4.1'

gem 'bcrypt', '= 3.1.13'

group :development do
  gem 'listen'
  gem 'guard'
  gem 'guard-minitest'
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
  gem 'spring'
end

group :test do
  gem 'minitest-reporters', '~> 1.0.0'
  gem 'mini_backtrace', '0.1.3'
  gem 'coveralls', require: false
  gem 'rails-controller-testing'

  # rake gem is required by travis
  gem 'rake'
end

group :production do
  gem 'pg', '~> 1.1.4'
  gem "puma", ">= 4.3.1"
end
