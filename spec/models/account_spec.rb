require 'rails_helper'

RSpec.describe Account, type: :model do
  before { @account = Account.new}
  subject { @account }

  it { should respond_to(:post)}
  it { should respond_to(:salary)}
  it { should respond_to(:joining_date)}
  it { should respond_to(:working_plan)}
end
