require 'rails_helper'

RSpec.describe ArticlesController do
  include Devise::Test::ControllerHelpers 

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
   # @user = create(:user) 
    #sign_in @user
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

  describe "POST create" do       
    
    let(:file) { fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'abc.jpg'), 'image/jpeg') }
    
    it 'creates a new article' do
        expect do
            post :create, params: { article: FactoryBot.attributes_for(:article, image: file) }
        end.to change(Article, :count).by(1)
    end

    it 'saves the article' do
        post :create, params: { article: FactoryBot.attributes_for(:article, image: file) }
        expect(response).to redirect_to (article_path(Article.last))
    end
  end

  describe "PATCH update" do       
    
    let(:article) {create(:article)}
    
    it 'updates the article' do
        new_attributes = { title: 'Updated Title', body: 'Updated Body' }
        patch :update, params: { id: article.id, article: new_attributes }
        article.reload


        expect(article.title).to eq('Updated Title')
        expect(article.body).to eq('Updated Body')
        expect(response).to redirect_to(article)
    end

  end

end
