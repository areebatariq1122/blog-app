task sample_task: :environment do
    Article.all.each do |article|
        puts article.title
    end
    
end