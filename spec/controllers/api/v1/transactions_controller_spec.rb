require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  describe "transaction with missing data" 
    context "when amount is missing" do
      transaction = FactoryGirl.create(:transaction, amount: nil)
      expect (response)
    end
  end
end
