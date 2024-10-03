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

  context "scopes" do
    it "should get all tasks archived more that n days ago" do
      Boards::Creator.new.create_default_columns(b)

      column_delivered_id = b.columns.find_by_name('delivered').id
      column_icebox_id = b.columns.find_by_name('icebox').id

      task1 = b.tasks.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test", column_id: column_delivered_id)
      task2 = b.tasks.create(title: "Feature_RSPEC", type: "Task::Feature", description: "test", column_id: column_icebox_id)
      task3 = b.tasks.create(title: "Support_RSPEC", type: "Task::Support", description: "test", column_id: column_delivered_id)

      task1.update(status: 2, archived_at: 5.days.ago)
      task2.update(status: 2, archived_at: 1.days.ago)
      expect(Task.archived_days_ago(3)).to eq([task1])
    end
    it "should get all active tasks from delivered column" do
      Boards::Creator.new.create_default_columns(b)
  
      column_delivered_id = b.columns.find_by_name('delivered').id
      column_icebox_id = b.columns.find_by_name('icebox').id
  
  
      task1 = b.tasks.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test", column_id: column_delivered_id, status: 0)
      task2 = b.tasks.create(title: "Feature_RSPEC", type: "Task::Feature", description: "test", column_id: column_icebox_id, status: 0)
      task3 = b.tasks.create(title: "Support_RSPEC", type: "Task::Support", description: "test", column_id: column_delivered_id, status: 0)
  
      task1.update(status: 2, archived_at: 5.days.ago)
      task2.update(status: 2, archived_at: 1.days.ago)
      expect(Task.active_delivered).to eq([task3])
    end
   
  end




end
