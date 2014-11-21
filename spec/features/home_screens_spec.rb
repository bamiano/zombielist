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

feature "View Wishlist", :type => :feature do
  scenario "User can view wishlist" do
    #1. setup phase
    u = create(:user)
    visit login_path

    fill_in "email", with: u.email
    fill_in "password", with: u.password
    click_button "Log In"

    supply_list = []
        3.times do |i|
      supply_list << create(:favorite, name: "Water #{i}", image: "image #{i}", link: "www.example.com #{i}")
    end

    #2. exercise phase
    visit user_favorites_path(u)

    #3. verification phase
    supply_list.each do |fav|
      expect(page).to have_text(fav.name)
    end
  end
end

feature "Add Locations", :type => :feature do
  scenario "User can add locations" do
    #1. setup phase
    u = create(:user)
    visit login_path

    fill_in "email", with: u.email
    fill_in "password", with: u.password
    click_button "Log In"

    # fill_in "location_location_type", with: "Home"
    # fill_in "location_name", with: "My House"
    # fill_in "location_address", with: "56 Glover St."
    # click_button "Create Location"

    fav_location = []
        3.times do |i|
      fav_location << create(:location)
    end

    #2. exercise phase
    visit new_user_location_path(u)

    #3. verification phase
    fav_location.each do |fav|
      expect(page).to have_text(fav.location_type, fav.name, fav.address)
    end
  end
end