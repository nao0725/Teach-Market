require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  
  before do
    @bookmark = FactoryBot.build(:bookmark)
  end
  
  describe 'モデルのテスト' do
    it "有効なuserの場合は保存されるか" do
      expect(build(:bookmark)).to be_valid
    end
  end
  
  describe 'バリデーションのテスト' do
    it "二度連続でブックマークできないかどうか" do
      @bookmark.save
      other_bookmark = FactoryBot.build(:bookmark)
      other_bookmark = @bookmark
      other_bookmark.valid?
    end
  end
  
  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(Bookmark.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    
    context "Articleモデルとの関係" do
      it "N:1となっている" do
        expect(Bookmark.reflect_on_association(:article).macro).to eq :belongs_to
      end
    end
  end
end