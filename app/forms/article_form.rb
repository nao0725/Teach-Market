class ArticleForm
  include ActiveModel::Model
  attr_accessor :title, :body, :sub_title, :tag_name, :user_id, :tag_id, :article_id

  with_options presence: true do
    validates :title
    validates :body
    validates :sub_title
    validates :tag_name
  end

  delegate :persisted?, to: :article

  def initialize(attributes = nil, article: Article.new)
    @article = article
    attributes ||= default_attributes
    super(attributes)
  end

  ActiveRecord::Base.transaction do
    def save(tag_list)
      @article.update(title: title, body: body, sub_title: sub_title, user_id: user_id)

      current_tags = @article.tags.pluck(:tag_name) unless @article.tags.nil?
      # old_tags = current_tags - tag_list
      new_tags = tag_list - current_tags

      # old_tags.each do |old_name|
      #   @article.tags.delete Tag.find_by(tag_name: old_name)
      # end

      new_tags.each do |new_name|
        article_tag = Tag.find_or_create_by(tag_name: new_name)
        @article.tags << article_tag
        article_tag_relation = ArticleTag.where(article_id: @article.id, tag_id: article_tag.id).first_or_initialize
        article_tag_relation.update(article_id: @article.id, tag_id: article_tag.id)
      end

    end
  end

  def to_model
    article
  end

  def select_id
    
  end

  private

  attr_reader :article, :tag

  def default_attributes
    {
      title: article.title,
      body: article.body,
      sub_title: article.sub_title,
      tag_name: article.tags.pluck(:tag_name).join("/")
    }
  end
end