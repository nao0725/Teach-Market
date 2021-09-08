require 'rails_helper'

RSpec.describe ArticleTag, type: :model do
  subject { article.valid? }

  describe "モデルのテスト" do
    it "有効なarticle_tagの場合は保存されるか" do
      expect(build(:article_tag)).to be_valid
    end
  end
  
   describe "アソシエーションのテスト" do
    context "Tagモデルとの関係" do
      it "N:1となっている" do
        expect(ArticleTag.reflect_on_association(:tag).macro).to eq :belongs_to
      end
    end
    
    context "Articleモデルとの関係" do
      it "N:1となっている" do
        expect(ArticleTag.reflect_on_association(:article).macro).to eq :belongs_to
      end
    end
  end
end