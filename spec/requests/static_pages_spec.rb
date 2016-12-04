require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "Home pages" do
    it "should have the content 'B Map'" do
      visit 'static_pages/home'
      expect(page).to have_content('B MAP')
    end

    it "should have title 'Home | Business Management App'" do
      visit 'static_pages/home'
      expect(page).to have_title('Home | Business Management App')
    end

    it "should have 'sign up now!' button" do
      visit 'static_pages/home'
      expect(page).to have_css(".btn-lg")
    end

    it "should have a full background image" do
      visit 'static_pages/home'
      expect(page).to have_css('#full-img-background')
    end

    it "should have a navigation fixed on top" do
      visit 'static_pages/home'
      expect(page).to have_css('.navbar-fixed-top')
    end
  end
end
