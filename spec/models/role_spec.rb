require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:us) {
    [User.create(email: "q@q", password: "qqq1234"), User.create(email: "w@w", password: "www1234")]
  }

  it "should be valid with name" do
    r = Role.create(name: "any")
    expect(r).to be_valid
    expect(r).to be_persisted
  end

  it "should not be valid without name" do
    r = Role.create()
    expect(r).not_to be_valid
    expect(r).not_to be_persisted
  end

  it "should be able to have users" do
    r = Role.create(name: "any")
    r.users = us
    expect(r.users.count).to eq(2) 
    expect(us[0].roles.count).to eq(1)
    expect(us[1].roles.count).to eq(1)
  end


  
end
