namespace :score do
  desc "Score New Articles"
  task articles: :environment do
    articles = Article.where("created_at < ? AND created_at > ?", DateTime.now, 1.day.ago)
    articles.each do |article|
      article.analyze!
    end
  end
end