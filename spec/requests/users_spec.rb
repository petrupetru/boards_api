require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:board) {
    Board.create(name: "any")
  }
  let!(:user_admin) {
    User.create(email: "admin@admin.com", password: "pass1234", password_confirmation: "pass1234")
  }
  let!(:user) {
    User.create(email: "any@any.com", password: "pass1234", password_confirmation: "pass1234")
  }
  let!(:role) {
    Role.create(name: "admin")
  }
  let!(:column) {
    board.columns.create(name: "column_test")
  }
  let!(:task) {
    board.tasks.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test", column_id: column.id)
  }

  describe "GET /index" do
    it "assigns @users without current" do
      user_admin.roles << role
      sign_in(user_admin)
      get '/users'
      expect(response).to have_http_status(:success)
      expect(assigns(:users)).to eq([user])
    end
  end

  describe "GET /show" do
    it "assigns @user" do
      user_admin.roles << role
      sign_in(user_admin)
      get users_path(user)
      expect(response).to have_http_status(:success)
      #expect(assigns(:user)).to eq(user)
    end
  end



end
