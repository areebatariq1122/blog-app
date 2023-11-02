class ArticlesPresenter < BasePresenter
  def initialize(articles)
    @articles = articles
  end

  def basic
    articles = {}
    articles[:id] = @articles.id
    articles[:created_at] = @articles.created_at
    articles[:updated_at] = @articles.updated_at
    articles
  end
end
