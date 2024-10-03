require 'rails_helper'

RSpec.describe ActionItem, type: :model do
  let(:board) {
    Board.create(name: "board_test")
  }
  let(:column) {
    board.columns.create(name: "column_test")
  }

  let(:task) {
    board.tasks.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test", column_id: column.id)
  }
  let(:photo) {
    Photo.create(content: "c", photo_source: "s/p")
  }
  it "shold be valid with valid attributes" do
    action_item = task.action_items.create(
      name: "Test1",
      status: 0,
      itemable: photo)
    expect(action_item).to be_valid
    expect(action_item).to be_persisted
    expect(action_item.id).to be_instance_of(Integer)
    expect(action_item.task.id).to be_instance_of(Integer)
    expect(action_item.itemable).to be_instance_of(Photo)
  end

  it "should fail without itemable" do 
    action_item = task.action_items.create(
      name: "Test1",
      status: 0,)
    expect(action_item).not_to be_valid
    expect(action_item).not_to be_persisted
  end

  it "should raise ArgumentError with status not in enum" do
    expect { task.action_items.create(
        name: "Test1",
        status: 6,
        itemable: photo) }.to raise_error(ArgumentError)
  end
end
