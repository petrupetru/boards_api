require 'rails_helper'

RSpec.describe Board, type: :model do
  it "should be valid with name" do
    b = Board.create(name: "any")
    expect(b).to be_valid
    expect(b).to be_persisted
  end

  it "should not be valid without name" do
    b = Board.create()
    expect(b).not_to be_valid
    expect(b).not_to be_persisted
  end
end
