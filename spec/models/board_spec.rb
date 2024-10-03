require 'rails_helper'

RSpec.describe Board, type: :model do
  it "should be valid with name" do
    board = Board.create(name: "any")
    expect(board).to be_valid
    expect(board).to be_persisted
  end

  it "should not be valid without name" do
    board = Board.create()
    expect(board).not_to be_valid
    expect(board).not_to be_persisted
  end
end
