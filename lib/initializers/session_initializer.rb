require 'capybara/poltergeist'

Capybara.default_max_wait_time = 20

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
