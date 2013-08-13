include ApplicationHelper

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_title do |text|
  match do |page|
    Capybara.string(page.body).has_selector?('title', text: text)
  end
end

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara 
    remeber_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, Usaer.encrypt(remember_token))
  else
    visit signin_page
    fill_in "Email",  with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end
