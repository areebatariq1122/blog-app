module Api
    module V1
        class ArticlesController < ApplicationController
            def index
                @articles = Article.all
                render json: @articles
            end

            def show
                @article = Article.find(params[:id])
                render json: @article
            end
        
            def new
                @article = Article.new
                render json: @article 
            end


            def create
                @article = Article.new(article_params)
    
                if params[:article][:image].present?
                    uploaded_file = params[:article][:image]
                    cloudinary_upload = Cloudinary::Uploader.upload(uploaded_file.tempfile)
                    @article.image = cloudinary_upload['secure_url']
                end
    
                if @article.save
                    render json: @article, status: :created
                else
                    render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
                end
            end
            
            def update
                @article = Article.find(params[:id])
        
                if @article.update(article_params)
                  render json: @article
                else
                  render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
                end
            end

            def destroy
                @article = Article.find(params[:id])
        
                if @article.destroy
                  render json: { message: 'Article deleted successfully' }, status: :no_content
                else
                  render json: { errors: 'Unable to delete the article' }, status: :unprocessable_entity
                end
            end

            private
            
            def article_params
                params.require(:article).permit(:title, :body, :Upload_Img, :status)
            end

        end
    end
end

