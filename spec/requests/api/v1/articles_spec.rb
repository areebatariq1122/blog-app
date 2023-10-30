require 'rails_helper'

RSpec.describe "Api::V1::Articles", type: :request do

  describe 'GET /api/v1/articles' do
    it 'returns a list of articles' do
      articles = FactoryBot.create_list(:article, 3)
      get '/api/v1/articles'
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(3)
    end
  end

  describe 'GET /api/v1/articles/:id' do
    it 'returns a single article' do
      article = FactoryBot.create(:article)

      get "/api/v1/articles/#{article.id}"

      expect(response).to have_http_status(200)

      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(article.id)
      expect(json_response['title']).to eq(article.title)
      expect(json_response['body']).to eq(article.body)
    end

    it 'returns a 404 status when the article does not exist' do
      get '/api/v1/articles/999' 

      expect(response).to have_http_status(404)
    end
  end

  describe 'POST /api/v1/articles' do
    it 'creates a new article' do
      article_params = { title: 'latest', body: 'Article body goes here' }

      post '/api/v1/articles', params: { article: article_params }

      expect(response).to have_http_status(201) 
      expect(Article.count).to eq(1)
    end

    it 'returns the created article as JSON' do
      article_params = { title: 'latest', body: 'Article body goes here' }

      post '/api/v1/articles', params: { article: article_params }

      expect(response).to have_http_status(201)

      json_response = JSON.parse(response.body)
      expect(json_response['title']).to eq('latest')
      expect(json_response['body']).to eq('Article body goes here')
    end

  end

  describe 'PATCH /api/v1/articles/:id' do
    it 'updates an existing article' do
      article = FactoryBot.create(:article) 
      updated_attributes = { title: 'Updated latest', body: 'Updated Article body goes here'}

      put "/api/v1/articles/#{article.id}", params: { article: updated_attributes }

      expect(response).to have_http_status(200) 
      article.reload 
      expect(article.title).to eq('Updated latest')
      expect(article.body).to eq('Updated Article body goes here')
    end

    it 'returns the updated article as JSON' do
      article = FactoryBot.create(:article)
      updated_attributes = { title: 'Updated latest', body: 'Updated Article body goes here' }

      put "/api/v1/articles/#{article.id}", params: { article: updated_attributes }

      expect(response).to have_http_status(200) 

      json_response = JSON.parse(response.body)
      expect(json_response['title']).to eq('Updated latest')
      expect(json_response['body']).to eq('Updated Article body goes here')
    end

    it 'returns a 404 status' do
      put '/api/v1/articles/999', params: { article: { title: 'Updated latest', body: 'Updated Article body goes here' } }
      expect(response).to have_http_status(404) 
    end
  end

end
