require 'rails_helper'

RSpec.describe Column, type: :model do
  let(:board) {
    Board.create(name: "board_test")
  }

  it "should be valid with name" do
    column = board.columns.create(name: "any")
    expect(column).to be_valid
    expect(column).to be_persisted
  end

  it "should not be valid without name" do
    column = board.columns.create()
    expect(column).not_to be_valid
    expect(column).not_to be_persisted
  end

  it "should belong to a board" do
    expect { Column.create("any") }.to raise_error(ArgumentError)
  end
end
