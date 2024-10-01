require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:b) {
    Board.create(name: "board_test")
  }
  let(:c) {
    b.columns.create(name: "column_test")
  }

  let(:us) {
    [User.create(email: "q@q", password: "qqq1234"), User.create(email: "w@w", password: "www1234")]
  }

  it "should be valid with args" do
      t = b.tasks.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test", column_id: c.id)
      expect(t).to be_valid
      expect(t).to be_persisted
  end

  it "should fail without title" do 
    t = b.tasks.create(type: "Task::Bug", description: "test", column_id: c.id)
    expect(t).not_to be_valid
    expect(t).not_to be_persisted
  end

  it "should fail without type" do 
    t = b.tasks.create(title: "BUG_RSPEC", description: "test", column_id: c.id)
    expect(t).not_to be_valid
    expect(t).not_to be_persisted
  end

  it "should fail without board" do 
    t = Task.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test", column_id: c.id)
    expect(t).not_to be_valid
    expect(t).not_to be_persisted
  end

  it "should fail without column" do 
    t = b.tasks.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test")
    expect(t).not_to be_valid
    expect(t).not_to be_persisted
  end

  it "should be able to have users assigned" do 
    t = b.tasks.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test", column_id: c.id)
    t.users = us
    expect(t.users.count).to eq(2)
    expect(us[0].tasks.count).to eq(1)
    expect(us[1].tasks.count).to eq(1)
  end




end
