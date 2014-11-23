require 'rails_helper'

# feature "Signup", :type => :feature do
#   scenario "User can create an accout" do
#     #1. setup phase
#     #  supply_list = []
#     # 3.times do |i|
#     #   supply_list << (:todo, name: "my todo #{i}")

#     # end

#     #2. exercise phase
#     visit create_user_path

#     #3. verification phase
#     todos.each do |todo|
#       expect(page).to have_text(todo.name)
#     end
#   end

feature "Signup", :type => :feature do
  scenario "creating an account from the signup page" do
    #1. setup phase
    visit create_user_path

    #2. exercise phase
    fill_in "user_email", with: "matthew@email.com"
    fill_in "user_password", with: "secret"
    click_button "Sign Up"

    #3. verification phase
    expect(page).to have_text("You have create an account!")
  end
end

feature "Login", :type => :feature do
  scenario "User can login" do
    #1. setup phase
    u = create(:user)
    visit login_path

    #2. exercise phase
    fill_in "email", with: u.email
    fill_in "password", with: u.password
    click_button "Log In"

    #3. verification phase
    expect(page).to have_text("You are now logged in!")
  end
end

feature "Add Favorites", :type => :feature do
  scenario "User can add locations" do
    #1. setup phase
    u = create(:user)
    visit login_path

    fill_in "email", with: u.email
    fill_in "password", with: u.password
    click_button "Log In"

    #2. exercise phase
    visit new_user_favorite_path(u)

    fill_in "favorite[name]", with: "Water"
    fill_in "favorite[image]", with: "www.example.com"
    fill_in "favorite[link]", with: "image"
    click_button "Create Favorite"

    #3. verification phase
      expect(page).to have_text('Favorite was successfully created.')

  end
end

# feature 'Save A location' do
#   scenario 'User Can Save A location', js: true do
#     #1. setup phase
#     u = create(:user)
#     visit log_path

#     fill_in "email", with: u.email
#     fill_in "password", with: u.password
#     click_button "Log In"

#     #2. exercise phase
#     visit user_path(u)
#     click_button "Save to favorites"

#     #3. verification phase
#     expect(page).to have_text(location_type)
#   end


describe "404 page" do
  it "is customized" do

    visit "/404"

    expect(page.status_code).to eq 404
  end


# RSpec - will retest when feature is working...
# feature "Add Locations", :type => :feature do
#   scenario "User can add locations" do
#     #1. setup phase
#     u = create(:user)
#     visit login_path

#     fill_in "email", with: u.email
#     fill_in "password", with: u.password
#     click_button "Log In"

#     #2. exercise phase
#     visit new_user_location_path(u)

#     fill_in "location[location_type]", with: "Home"
#     fill_in "location[name]", with: "My house"
#     fill_in "location[address]", with: "56 Glover St."
#     click_button "Create Location"

#     #3. verification phase
#       expect(page).to have_text("Home")
#       expect(page).to have_text("My house")
#       expect(page).to have_text("56 Glover St.")
#   end
# end


end

