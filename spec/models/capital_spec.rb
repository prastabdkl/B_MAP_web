require 'rails_helper'

RSpec.describe Capital, type: :model do
  before { @capital = Capital.new(name: "Example User", total_amount: 50) }
  subject { @capital }

  it { should respond_to(:name)}
  it { should respond_to(:description)}
  it { should respond_to(:phone_no)}
  it { should respond_to(:address)}
  it { should respond_to(:total_amount)}
  it { should respond_to(:capital_type)}

  describe "when name is not present" do
    before {@capital.name = nil}
    it { should_not be_valid}
  end
  
  describe "when total_amount is not present" do
    before { @capital.total_amount = nil}
    it { should_not be_valid}
  end

  describe "when name is too long" do
    before { @capital.name = "a" * 51}
    it { should_not be_valid}
  end
end
