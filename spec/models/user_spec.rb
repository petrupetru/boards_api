require 'rails_helper'

RSpec.describe User, type: :model do
  let(:rs) {
    [Role.create(name: "admin"), Role.create(name: "editor")]
  }



  let(:b) {
    Board.create(name: "board_test")
  }
  let(:c) {
    b.columns.create(name: "column_test")
  }
  let(:ts) {
    [b.tasks.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test", column_id: c.id),
     b.tasks.create(title: "FEATURE_RSPEC", type: "Task::Feature", description: "test", column_id: c.id)]
  }



  it "should be valid with arguments" do
    u = User.create(email: "any@any.com", password: "pass1234", password_confirmation: "pass1234")
    expect(u).to be_valid
    expect(u).to be_persisted
  end

  it "should not be valid without email" do
    u = User.create( password: "pass1234", password_confirmation: "pass1234")
    expect(u).not_to be_valid
    expect(u).not_to be_persisted
  end

  it "should not be valid without password" do
    u = User.create(email: "any@any.com", password_confirmation: "pass1234")
    expect(u).not_to be_valid
    expect(u).not_to be_persisted
  end

  it "should not be valid with password and password confirmation not matching" do
    u = User.create(email: "any@any.com", password: "pass1234", password_confirmation: "SOMETHING_ELSE")
    expect(u).not_to be_valid
    expect(u).not_to be_persisted
  end

  it "should be able to have roles" do
    u = User.create(email: "any@any.com", password: "pass1234", password_confirmation: "pass1234")
    u.roles = rs
    expect(u.roles.count).to eq(2) 
    expect(rs[0].users.count).to eq(1)
    expect(rs[1].users.count).to eq(1)
  end


  it "should be able to have tasks" do
    u = User.create(email: "any@any.com", password: "pass1234", password_confirmation: "pass1234")
    u.tasks = ts
    expect(u.tasks.count).to eq(2) 
    expect(ts[0].users.count).to eq(1)
    expect(ts[1].users.count).to eq(1)
  end
end
