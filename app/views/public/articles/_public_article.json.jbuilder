json.extract! public_article, :id, :title, :body, :created_at, :updated_at
json.url public_article_url(public_article, format: :json)
