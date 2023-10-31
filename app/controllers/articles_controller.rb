class ArticlesController < ApplicationController
  #before_action :authenticate_user!

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if params[:article][:image].present?
      uploaded_file = params[:article][:image]
      cloudinary_upload = Cloudinary::Uploader.upload(uploaded_file.tempfile)
      @article.image = cloudinary_upload['secure_url']
    end

    if @article.save
      redirect_to article_path(@article), notice: 'Article created successfully'

    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :roles)
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :Upload_Img, :status)
  end
end
