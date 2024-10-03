require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:users) {
    [User.create(email: "q@q", password: "qqq1234"), User.create(email: "w@w", password: "www1234")]
  }

  it "should be valid with name" do
    role = Role.create(name: "any")
    expect(role).to be_valid
    expect(role).to be_persisted
  end

  it "should not be valid without name" do
    role = Role.create()
    expect(role).not_to be_valid
    expect(role).not_to be_persisted
  end

  it "should be able to have users" do
    role = Role.create(name: "any")
    role.users = users
    expect(role.users.count).to eq(2) 
    expect(users[0].roles.count).to eq(1)
    expect(users[1].roles.count).to eq(1)
  end


  
end
