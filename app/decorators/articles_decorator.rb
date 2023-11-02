class ArticlesDecorator < Draper::Decorator
  delegate_all

  def initialize(article)
    @article = article
  end
  
  def comment_count
    @article.comment_count
  end
  
end