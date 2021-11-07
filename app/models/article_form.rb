class ArticleForm
  include ActiveModel::Model
  attr_accessor :title, :body, :sub_title, :tag_name, :tags

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

  def save
    ActiveRecord::Base.transaction do
      tags = Tag.where(tag_name: tags).first_or_create
      article.update!(title: title, body: body, sub_title: sub_title, tag_name: tags)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def to_model
    article
  end

  private

  attr_reader :article

  def default_attributes
    {
      title: @article.title,
      body: @article.body,
      sub_title: @article.sub_title,
      tags: @article.tags.pluck(:tag_name).join("/")
    }
  end

  def set_tag_list
    tag_names.split("/")
  end

end