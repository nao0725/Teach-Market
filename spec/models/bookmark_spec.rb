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
end