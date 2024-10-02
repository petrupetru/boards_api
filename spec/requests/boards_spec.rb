require 'rails_helper'

RSpec.describe "Boards", type: :request do
  let!(:board) {
    Board.create(name: "any")
  }
  let(:user) {
    User.create(email: "any@any.com", password: "pass1234", password_confirmation: "pass1234")
  }
  let(:role) {
    Role.create(name: "admin")
  }
  describe "GET /index" do
    it "assigns @boards" do
      user.roles << role
      sign_in(user)
      get ''
      expect(response).to have_http_status(:success)
      expect(assigns(:boards)).to eq([board])
    end
  end

  describe "GET /show" do
    it "assigns @board, @users" do
      user.roles << role
      sign_in(user)
      get board_path(board)
      expect(response).to have_http_status(:success)
      expect(assigns(:board)).to eq(board)
      expect(assigns(:users)).to eq(User.all)
    end
  end

  describe "GET /new" do
    context "with permisions" do
      it "renders a successful response" do
        user.roles << role
        sign_in(user)
        get new_board_path
        expect(response).to be_successful
      end
    end 

    context "without permissions" do 
      it "raises permission error" do 
        sign_in(user)
        expect {
          get new_board_path
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

  end

  describe "GET /edit" do
    context "with permisions" do
      it "renders a successful response" do
        user.roles << role
        sign_in(user)
        get edit_board_path(board)
        expect(response).to be_successful
      end
    end
    context "without permissions" do 
      it "raises permission error" do 
        sign_in(user)
        expect {
          get edit_board_path(board)
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Board" do
        user.roles << role
        sign_in(user)
        expect {
          post boards_path, params: { board: { name: "any"} }
        }.to change(Board, :count).by(1)
      end

      it "assigns default columns" do 
        user.roles << role
        sign_in(user)
        post boards_path, params: { board: { name: "any"} }
        board_created = Board.last
        expect(board_created.columns.count).to eq(5)
      end
    end

    context "with missing parameters" do
      it "raises parameter error" do
        user.roles << role
        sign_in(user)
        expect {
          post boards_path, params: {  }
        }.to raise_error(ActionController::ParameterMissing)
      end
    end

    context "without edit role" do
      it "raises policy error" do
        sign_in(user)
        expect {
          post boards_path, params: { board: { name: "any"} }
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end


  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates board" do
        user.roles << role
        sign_in(user)
        old_name = board.name
        patch board_path(board), params: { board: {name: "new"} }
        board.reload
        expect(board.name).not_to eq(old_name)
      end
    end

    context "with missing parameters" do
      it "raises parameter error" do
        user.roles << role
        sign_in(user)
        expect {
          patch board_path(board), params: { }
        }.to raise_error(ActionController::ParameterMissing)
      end
    end

    context "without edit role" do
      it "raises policy error" do
        sign_in(user)
        expect {
          patch board_path(board), params: { board: {name: "new"} }
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested board" do
      user.roles << role
      sign_in(user)
      expect {
        delete board_path(board)
      }.to change(Board, :count).by(-1)
    end
  end





end
