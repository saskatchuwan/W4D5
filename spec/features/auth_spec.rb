require 'rails_helper'
require 'spec_helper'

RSpec.feature "Auths", type: :feature do
  feature 'the signup process' do
    scenario 'has a new user page' do
      visit new_user_url
      expect(page).to have_content('Sign Up')
    end

    feature 'signing up a user' do
      subject(:user) { User.new(username: 'Ana', password: 'anapassword')}
      # before(:each) do
      #   fill_in 'username', with: 'Ana'
      #   fill_in 'password', with: 'anapassword'
      #   click_on 'Create User'
      # end

      scenario 'shows username on the homepage after signup' do
         visit new_user_url
        expect(page).to have_content('Ana')
      end
    end
  end

  feature 'logging in' do
    scenario 'shows username on the homepage after login'

  end

  feature 'logging out' do
    scenario 'begins with a logged out state'

    scenario 'doesn\'t show username on the homepage after logout'

  end
end
