require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before { @transaction = Transaction.new}
  subject { @transaction}

  it { should respond_to(:date)}
  it { should respond_to(:amount)}
  it { should respond_to(:cash_type)}

  describe "when date in not present" do
    before { @transaction.date = nil}
    it { should_not be_valid}
  end

  describe "when amount is not present" do
    before { @transaction.amount = nil}
    it { should_not be_valid}
  end

  describe "when cash_type is not present" do
    before { @transaction.cash_type = nil}
    it { should_not be_valid}
  end
end
