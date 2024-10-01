require 'rails_helper'

RSpec.describe ActionItem, type: :model do
  let(:b) {
    Board.create(name: "board_test")
  }
  let(:c) {
    b.columns.create(name: "column_test")
  }

  let(:t) {
    b.tasks.create(title: "BUG_RSPEC", type: "Task::Bug", description: "test", column_id: c.id)
  }
  let(:p) {
    Photo.create(content: "c", photo_source: "s/p")
  }
  it "shold be valid with valid attributes" do
    a = t.action_items.create(
      name: "Test1",
      status: 0,
      itemable: p)
    expect(a).to be_valid
    expect(a).to be_persisted
    expect(a.id).to be_instance_of(Integer)
    expect(a.task.id).to be_instance_of(Integer)
    expect(a.itemable).to be_instance_of(Photo)
  end

  it "should fail without itemable" do 
    a = t.action_items.create(
      name: "Test1",
      status: 0,)
    expect(a).not_to be_valid
    expect(a).not_to be_persisted
  end

  it "should fail with status not in enum" do
    expect { t.action_items.create(
        name: "Test1",
        status: 6,
        itemable: p) }.to raise_error(ArgumentError)
  end
end
