require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  include Devise::Test::ControllerHelpers

  # create a user
  let!(:user) do
    User.create!(
      email:                 'test@example.com',
      username:              'testuser',
      password:              'Password123',
      password_confirmation: 'Password123',
      introduction:          'hi'
    )
  end

  before { sign_in user }

  describe 'GET #edit' do
    it 'return HTTP 200' do
      get :edit
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #update' do
    context 'Parameters are valid' do
      it 'Update username and redirect to account_path，set flash notice' do
        expect {
          patch :update, params: { user: { username: 'newname' } }
        }.to change { user.reload.username }.from('testuser').to('newname')

        expect(response).to redirect_to(account_path)
        expect(flash[:notice]).to eq 'Information updated'
      end
    end

    context 'Illegal parameter' do
      it 'Render without modifying data edit（HTTP 200）' do
        allow_any_instance_of(User).to receive(:update).and_return(false)

        original_username = user.username
        patch :update, params: { user: { username: '' } }
        expect(user.reload.username).to eq original_username
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
