require 'rails_helper'

RSpec.describe Tag , type: :model do
  let(:tag) { FactoryBot.create(:tag) }
  
  describe "モデルのテスト" do
    it "有効なTagの場合は保存されるか" do
      expect(build(:tag)).to be_valid
    end
  end

  describe "バリデーションのテスト" do
    context "tag_nameカラムのテスト" do
      it "空白の場合エラーメッセージが返ってくるか" do
        tag.tag_name = ""
        tag.valid?
        expect(tag.errors[:tag_name]).to include("を入力してください")
      end
    end
  end
  
  describe "アソシエーションのテスト" do
    context "ArticleTTagモデルとの関係" do
      it "1:Nとなっている" do
        expect(Tag.reflect_on_association(:article_tags).macro).to eq :has_many
      end
    end
    
    context "Articleモデルとの関係" do
      it "1:Nとなっている" do
        expect(Tag.reflect_on_association(:articles).macro).to eq :has_many
      end
    end
  end
end
