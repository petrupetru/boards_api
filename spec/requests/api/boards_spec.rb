# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/boards' do
  let(:user) do
    User.create(email: 'any@any.com', password: 'pass1234', password_confirmation: 'pass1234')
  end
  let(:role) do
    Role.create(name: 'admin')
  end
  before do
    user.roles << role
    sign_in(user)
  end
  path '/boards' do
    get('list boards') do
      tags 'Boards'
      # produces 'application/json'
      response(200, 'successful') do
        run_test!
      end
    end
  end
end
