require 'rails_helper'

RSpec.describe ArticleTag, type: :model do
  subject { article.valid? }

  describe "モデルのテスト" do
    it "有効なarticle_tagの場合は保存されるか" do
      expect(build(:article_tag)).to be_valid
    end
  end
end