class SessionBuilder
  def self.create(team_name, email, password)
    session = Capybara::Session.new(:poltergeist)

    session.visit "https://#{team_name}.slack.com/customize/emoji"

    if session.first('strong', text: /^email address$/) && session.first('strong', text: /^password$/)
      session.fill_in 'email', with: email
      session.fill_in 'password', with: password
      session.find('#signin_btn').click
    else
      session.click_on 'Sign in with Google'
      session.fill_in 'Email', with: email
      session.click_on 'Next'
      session.fill_in 'Password', with: password
      session.click_on 'Sign in'
    end
    session
  end
end
