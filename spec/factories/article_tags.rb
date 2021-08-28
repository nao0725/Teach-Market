FactoryBot.define do
  factory :article_tag do
    association :article
    tag { article.tag }
  end
end
