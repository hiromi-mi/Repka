source 'https://rubygems.org'

# to make i18n >= 1.1.0
gem 'rails',                   '>= 5.2.2'
gem 'bcrypt',                  '>= 3.1.11'
gem 'bootstrap-sass',          '>= 3.3.7'
gem 'puma',                    '>= 3.9.1'
gem 'sassc-rails'
gem 'uglifier',                '>= 3.2.0'
gem 'coffee-rails',            '>= 4.2.2'
gem 'jquery-rails',            '>= 4.3.1'
gem 'turbolinks',              '>= 5.0.1'
gem 'jbuilder',                '>= 2.6.4'
gem 'therubyracer'
gem 'roo'
gem 'roo-xls'
gem 'sanitize'
gem 'jquery-datatables-rails'
# Restore behavior of #filter method
gem 'ajax-datatables-rails', git: 'https://github.com/jbox-web/ajax-datatables-rails'

group :development, :test do
    # FIXME: this is bug of rails: due to https://www.reddit.com/r/rails/comments/ap36xe/specified_sqlite3_for_database_adapter_but_the/
    gem 'sqlite3', '>= 1.3.13'
    gem 'byebug',  '>= 9.0.6', platform: :mri
    gem 'nokogiri', '>= 1.8.2'
    gem 'capybara',              '>= 2.17.0'
    gem 'selenium-webdriver'
end

group :development do
    gem 'web-console',           '>= 3.5.1'
    gem 'listen',                '>= 3.0.8'
    gem 'spring',                '>= 2.0.2'
    gem 'spring-watcher-listen', '>= 2.0.1'
    gem 'faker',                 '>= 1.8.7'
end

group :test do
    gem 'rails-controller-testing', '>= 1.0.2'
    gem 'minitest-reporters',       '>= 1.1.14'
    gem 'guard',                    '>= 2.14.1'
    gem 'guard-minitest',           '>= 2.4.6'
end

group :production do
    gem 'pg',   '>= 0.20.0'
end
