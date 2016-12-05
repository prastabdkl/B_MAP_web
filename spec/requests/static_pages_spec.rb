require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
subject {page}

  describe "Home pages" do
    before { visit root_path }

    it { should have_content('B MAP')}
    it { should have_title('Home | Business Management App')}
    it {should have_css('.btn-lg')}
    it {should have_css('#full-img-background')}
    it {should have_css('.navbar-fixed-top')}
    it {should have_link('home'.capitalize)}
    it {should have_link('help'.capitalize)}
    it {should have_link('log in'.capitalize)}
    it {should have_link('sign up'.capitalize)}
  end
end
