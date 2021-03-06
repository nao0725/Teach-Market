require 'rails_helper'

RSpec.describe Article, type: :model do
  subject { article.valid? }

  let(:user) { create(:user) }
  let!(:article) { build(:article, user_id: user.id) }

  describe "モデルのテスト" do
    it "有効なarticleの場合は保存されるか" do
      expect(build(:article)).to be_valid
    end
  end

  describe "バリデーションのテスト" do
    context "titleカラムのテスト" do
      it "空白の場合エラーメッセージが返ってくるか" do
        article.title = ""
        article.valid?
        expect(article.errors[:title]).to include("を入力してください")
      end

      it "長さが1文字以下の場合エラーメッセージが返ってくるか" do
        article.title = Faker::Lorem.characters(number: 1)
        article.valid?
        expect(article.errors[:title]).to include("は2文字以上で入力してください")
      end

      it "長さが2文字以上ある場合成功するか" do
        article.title = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end

      it "長さが21文字以上の場合エラーメッセージが返ってくるか" do
        article.title = Faker::Lorem.characters(number: 21)
        article.valid?
        expect(article.errors[:title]).to include("は20文字以内で入力してください")
      end

      it "長さが20文字以下である場合成功するか" do
        article.title = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
    end

    context "bodyのカラムのテスト" do
      it "空白の場合エラーメッセージが返ってくるか" do
        article.body = ""
        article.valid?
        expect(article.errors[:body]).to include("を入力してください")
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(Article.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    
    context "Bookmarkモデルとの関係" do
      it "1:Nとなっている" do
        expect(Article.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end
  end
end
