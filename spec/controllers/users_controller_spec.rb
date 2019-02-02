require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do  
    it 'should render new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'valid_params' do
      it 'logs in user' do
        post :create, params: {user: {username: 'Ana', password: 'anapassword'}}
        expect(session[:session_token]).to eq(User.last.session_token)
      end

      it 'redirects to user\'s show page' do
        post :create, params: {user: {username: 'Ana', password: 'anapassword'}}
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end

end
