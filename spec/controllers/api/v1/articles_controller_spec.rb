require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do
    include Devise::Test::ControllerHelpers

    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token}
    before do
        request.headers.merge!(auth_headers)
        
    end

    let(:invalid_attributes) do
        { title: '', body: '', Upload_Img: '', status: '' }
    end

    describe "GET index" do
        let (:articles) { create_list(:article, 4) }

        it 'returns a success response' do
            get :index
            expect(response).to have_http_status(:ok)
        end
    
        it "returns JSON data for the list of articles" do 
            get :index 
            expect(response.content_type).to eq("application/json; charset=utf-8")
        end
    end
    
    describe "GET show" do
         
        let!(:article) {create(:article)}

        it 'returns the JSON data' do
            get :show, params: { id: article.id }
            expect(response.content_type).to eq("application/json; charset=utf-8")
            json_response = JSON.parse(response.body)
            expect(json_response['title']).to eq(article.title)
            expect(json_response['body']).to eq(article.body)
        end

        it 'returns a success response' do
            get :show, params: { id: article.id }
            expect(response).to have_http_status(:ok)
        end
    end
    
    describe "GET new" do
        let! (:article) {create(:article)}

        it 'returns a success response' do
            get :new
            expect(response).to have_http_status(:ok)
        end

        it 'returns the JSON data' do
            get :new
            expect(response.content_type).to eq("application/json; charset=utf-8")
        end

    end

    describe "POST create" do
        let! (:file) { fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'abc.jpg'), 'image/jpeg') }
    
        it 'creates a new Article' do
            expect do
                post :create, params: { article: FactoryBot.attributes_for(:article, image: file)  }
            end.to change(Article, :count).by(1)
        end

        it 'renders a JSON response with the new article' do
            post :create, params: { article: FactoryBot.attributes_for(:article, image: file) }
            expect(response).to have_http_status(:created)
            expect(response.content_type).to eq("application/json; charset=utf-8")
        end

        it 'saves the article' do
            post :create, params: { article: FactoryBot.attributes_for(:article, image: file) }
            expect(response).to have_http_status(:created)
        end
        
    end

    describe "PATCH update" do
        let! (:article) { create(:article) }

        new_attributes = { title: 'Updated Title', body: 'Updated Body' }
      
        it 'updates the requested article' do
            patch :update, params: { id: article.id, article: new_attributes }
            article.reload
            expect(article.title).to eq('Updated Title')
            expect(article.body).to eq('Updated Body')
            expect(response.content_type).to eq("application/json; charset=utf-8")
        end

        it 'renders a JSON response with the article' do
            patch :update, params: { id: article.id, article: new_attributes }
            expect(response).to have_http_status(:ok)
            expect(response.content_type).to eq("application/json; charset=utf-8")
        end
    
    end

    describe "DELETE destroy" do
        let! (:article) { create(:article) }

        it 'destroys the requested article' do
            expect do
                delete :destroy, params: { id: article.id }
            end.to change(Article, :count).by(-1)
        end

        it 'renders a JSON response with a success message' do
            delete :destroy, params: { id: article.id }
            expect(response).to have_http_status(:no_content)
        end
    end

end
