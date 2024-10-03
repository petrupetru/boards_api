require 'rails_helper'

RSpec.describe User, type: :model do
  let(:roles) {
    [Role.create(name: "admin"), Role.create(name: "editor")]
  }



  let(:board) {
    Board.create(name: "board_test")
  }
  let(:column) {
    board.columns.create(name: "column_test")
  }
  let(:tasks) {
    [board.tasks.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test", column_id: column.id),
      board.tasks.create(title: "FEATURE_RSPEC", type: "Task::Feature", description: "test", column_id: column.id)]
  }



  it "should be valid with arguments" do
    user = User.create(email: "any@any.com", password: "pass1234", password_confirmation: "pass1234")
    expect(user).to be_valid
    expect(user).to be_persisted
  end

  it "should not be valid without email" do
    user = User.create( password: "pass1234", password_confirmation: "pass1234")
    expect(user).not_to be_valid
    expect(user).not_to be_persisted
  end

  it "should not be valid without password" do
    user = User.create(email: "any@any.com", password_confirmation: "pass1234")
    expect(user).not_to be_valid
    expect(user).not_to be_persisted
  end

  it "should not be valid with password and password confirmation not matching" do
    user = User.create(email: "any@any.com", password: "pass1234", password_confirmation: "SOMETHING_ELSE")
    expect(user).not_to be_valid
    expect(user).not_to be_persisted
  end

  it "should be able to have roles" do
    user = User.create(email: "any@any.com", password: "pass1234", password_confirmation: "pass1234")
    user.roles = roles
    expect(user.roles.count).to eq(2) 
    expect(roles[0].users.count).to eq(1)
    expect(roles[1].users.count).to eq(1)
  end


  it "should be able to have tasks" do
    user = User.create(email: "any@any.com", password: "pass1234", password_confirmation: "pass1234")
    user.tasks = tasks
    expect(user.tasks.count).to eq(2) 
    expect(tasks[0].users.count).to eq(1)
    expect(tasks[1].users.count).to eq(1)
  end
end
