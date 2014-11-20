require 'rails_helper'

# feature "Signup", :type => :feature do
#   scenario "User can create an accout" do
#     #1. setup phase
#       users = []
#         2.times do
#           users << create(:user)
#         end
#     #  = []
#     # 3.times do |i|
#     #   todos << create(:todo, name: "my todo #{i}")

#     # end

#     #2. exercise phase
#     visit create_user_path

#     #3. verification phase
#     todos.each do |todo|
#       expect(page).to have_text(todo.name)
#     end
#   end

feature "Signup", :type => :feature do
  scenario "creating a todo from the home screen" do
    #1. setup phase
    visit create_user_path

    #2. exercise phase
    fill_in "user_email", with: "matthew@e.com"
    fill_in "user_password", with: "secret"
    fill_in "user_location", with: "94109"
    click_button "Sign Up"

    #3. verification phase
    expect(page).to have_text("You are now logged in!")
  end

  # scenario "creating a todo from the home screen" do
  #   #1. setup phase
  #   visit root_path

  #   #2. exercise phase
  #   fill_in "Name", with: "Write some specs!"
  #   click_button "Create"

  #   #3. verification phase
  #   expect(page).to have_text("Write some specs!")
  # end

  #   scenario "creating a todo from the home screen" do
  #   #1. setup phase
  #   visit root_path

  #   #2. exercise phase
  #   fill_in "Name", with: "Write some specs!"
  #   click_button "Create"

  #   #3. verification phase
  #   expect(page).to have_text("Write some specs!")
  # end

  #   scenario "creating a todo from the home screen" do
  #   #1. setup phase
  #   visit root_path

  #   #2. exercise phase
  #   fill_in "Name", with: "Write some specs!"
  #   click_button "Create"

  #   #3. verification phase
  #   expect(page).to have_text("Write some specs!")
  # end
end