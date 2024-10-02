require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let!(:board) {
    Board.create(name: "any")
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

  describe "GET /show" do
    it "assigns @task" do
      user.roles << role
      sign_in(user)
      get board_task_path(board, task)
      expect(response).to have_http_status(:success)
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "GET /edit" do
    context "with permissions" do
      it "renders a successful response" do
        user.roles << role
        sign_in(user)
        get edit_board_task_path(board, task)
        expect(response).to be_successful
      end
    end
    context "without permissions" do
      it "renders a successful response" do
        sign_in(user)
        expect {
          get edit_board_task_path(board, task)
        }.to raise_error(Pundit::NotAuthorizedError)
      end

    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task" do
        user.roles << role
        sign_in(user)
        expect {
          post board_tasks_path(board), params: { task: { title: "any", type: "Task::Bug", column_id: column.id} }
        }.to change(Task, :count).by(1)
      end
    end

    context "with missing parameters" do
      it "raises parameter error" do
        user.roles << role
        sign_in(user)
        expect {
          post board_tasks_path(board), params: { }
        }.to raise_error(ActionController::ParameterMissing)
      end
    end

    context "without edit role" do
      it "raises policy error" do
        sign_in(user)
        expect {
          post board_tasks_path(board), params: { task: { title: "any", type: "Task::Bug", column_id: column.id} }
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

  end


  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates task title" do
        user.roles << role
        sign_in(user)
        old_title = task.title
        #Task::Bug
        patch board_task_path(board, task), params: { task_bug: {title: "new"} }

        task.reload
        expect(task.title).not_to eq(old_title)
      end

      it "updates task description" do
        user.roles << role
        sign_in(user)
        old_description = task.description
        #Task::Bug
        patch board_task_path(board, task), params: { task_bug: {description: "new"} }

        task.reload
        expect(task.description).not_to eq(old_description)
      end

      it "updates task users" do
        user.roles << role
        sign_in(user)
        #Task::Bug
        patch board_task_path(board, task), params: { task_bug: {title: task.title, description: task.description}, task: {user_ids: [user.id]} }

        task.reload
        expect(task.users).to eq([user])
      end

    end
  

    context "with missing parameters" do
      it "raises parameter error" do
        user.roles << role
        sign_in(user)
        expect {
          patch board_task_path(board, task), params: {  }
        }.to raise_error(ActionController::ParameterMissing)
      end
    end

    context "without edit role" do
      it "raises policy error" do
        sign_in(user)
        expect {
          patch board_task_path(board, task), params: { task_bug: {title: "new"} }
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  
  end

  describe "DELETE /destroy" do
    it "destroys the requested board" do
      user.roles << role
      sign_in(user)
      expect {
        delete board_task_path(board, task)
      }.to change(Task, :count).by(-1)
    end
  end
end
