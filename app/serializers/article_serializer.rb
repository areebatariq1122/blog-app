class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at, :status, :image
end
