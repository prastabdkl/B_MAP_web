def full_title(page_title)
  base_title = "Business Management App"
  if page_title.empty?
    base_title
  else
    page_title + " | " + base_title
  end
end

def log_in(user, options={})
  if options[:no_capybara]
    # Logging in without using capybara
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
  else
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end
end
