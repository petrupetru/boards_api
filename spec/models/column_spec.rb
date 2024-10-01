require 'rails_helper'

RSpec.describe Column, type: :model do
  let(:b) {
    Board.create(name: "board_test")
  }

  it "should be valid with name" do
    c = b.columns.create(name: "any")
    expect(c).to be_valid
    expect(c).to be_persisted
  end

  it "should not be valid without name" do
    c = b.columns.create()
    expect(c).not_to be_valid
    expect(c).not_to be_persisted
  end

  it "should belong to a board" do
    expect { Column.create("any") }.to raise_error(ArgumentError)
  end
end
