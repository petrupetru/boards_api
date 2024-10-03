require 'rails_helper'
require 'sidekiq/testing'
RSpec.describe Task, type: :model do
  let(:board) {
    Board.create(name: "board_test")
  }
  let(:board2) {
    Board.create(name: "test2")
  }
  let(:column) {
    board.columns.create(name: "column_test")
  }

  let(:users) {
    [User.create(email: "q@q", password: "qqq1234"), User.create(email: "w@w", password: "www1234")]
  }

  it "should be valid with args" do
      task = board.tasks.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test", column_id: column.id)
      expect(task).to be_valid
      expect(task).to be_persisted
  end

  it "should fail without title" do 
    task = board.tasks.create(type: "Task::Bug", description: "test", column_id: column.id)
    expect(task).not_to be_valid
    expect(task).not_to be_persisted
  end

  it "should fail without type" do 
    task = board.tasks.create(title: "BUG_RSPEC", description: "test", column_id: column.id)
    expect(task).not_to be_valid
    expect(task).not_to be_persisted
  end

  it "should fail without board" do 
    task = Task.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test", column_id: column.id)
    expect(task).not_to be_valid
    expect(task).not_to be_persisted
  end

  it "should fail without column" do 
    task = board.tasks.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test")
    expect(task).not_to be_valid
    expect(task).not_to be_persisted
  end

  it "should be able to have users assigned" do 
    task = board.tasks.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test", column_id: column.id)
    task.users = users
    expect(task.users.count).to eq(2)
    expect(users[0].tasks.count).to eq(1)
    expect(users[1].tasks.count).to eq(1)
  end

  context "scopes" do
    it "should get all tasks archived more that n days ago" do
      seed_tasks(board)
      expect(Task.archived_days_ago(3)).to eq([Task.find(1)])
    end
    it "should get all active tasks from delivered column" do
      seed_tasks(board)
      expect(Task.active_delivered).to eq([Task.find(3)])
    end
   
  end

  context "services" do
    it "should create a job for each board with old tasks" do
      Sidekiq::Testing.fake!
      seed_tasks(board)
      #seed_tasks(board2)
      travel_to 2.days.from_now
      TaskArchiver.new.call
      expect(ArchiveTaskJob.jobs.size).to eq(1)
    end

    it "should filter tasks older than 1 days, not archived, no %test% in title" do 
      seed_tasks(board)
      #none are created more than 1 day ago
      expect(OldTaskFinder.new.call(board)).to eq([])
      travel_to 2.days.from_now
      # task 1 and 2 are archived
      expect(OldTaskFinder.new.call(board)).to eq(board.tasks.where(id: 3))
      board.tasks.where(id: 3).update(title: "ignore because is Test")
      # test 3 has test in title
      expect(OldTaskFinder.new.call(board)).to eq([])
    end
  end

  context "sidekiq" do
    it "should archive the thasks that are not already archived" do
      seed_tasks(board)
      archive_job = ArchiveTaskJob.new
      task_ids = board.tasks.map {|task| task.id}
      archive_job.perform(task_ids)
      expect(board.tasks.where(status: :archived)).to eq(board.tasks)
    end
  end



  def seed_tasks(board) 
    Boards::Creator.new.create_default_columns(board)
    column_delivered_id = board.columns.find_by_name('delivered').id
    column_icebox_id = board.columns.find_by_name('icebox').id
    task1 = board.tasks.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test", column_id: column_delivered_id, status: 0)
    task2 = board.tasks.create(title: "Feature_RSPEC", type: "Task::Feature", description: "test", column_id: column_icebox_id, status: 0)
    task3 = board.tasks.create(title: "Support_RSPEC", type: "Task::Support", description: "test", column_id: column_delivered_id, status: 0)
    task1.update(status: 2, archived_at: 5.days.ago)
    task2.update(status: 2, archived_at: 1.days.ago)

  
  end

end
