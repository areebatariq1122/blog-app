require 'rails_helper'

RSpec.describe ArticlesController do
include Devise::Test::ControllerHelpers 

  before do
    @user = create(:user) 
    sign_in @user
  end

  describe "GET index" do
 
    let! (:articles) { create_list(:article, 10) }

    it "gives succesful response" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns list of articles" do 
        get :index 
        expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    let(:article) {create(:article)}

    it "gives succesful response" do
      get :show, params: { id: article.id }
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get :show, params: { id: article.id }
      expect(response).to render_template(:show)
    end

  end

  describe "GET new" do
    let(:article) {create(:article)}

    it "gives succesful response" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

  end

end
