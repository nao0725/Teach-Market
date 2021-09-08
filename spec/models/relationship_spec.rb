require 'rails_helper'

RSpec.describe Relationship, type: :model do
   let!(:relationship) { FactoryBot.create(:relationship) }

  describe "モデルのテスト" do
    it "有効なRelationshipの場合は保存されるか" do
      expect(build(:relationship)).to be_valid
    end
  end
  
  describe "アソシエーションのテスト" do
    context "followedとの関係" do
      it "1:Nとなっている" do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
    
    context "followerとの関係" do
      it "1:Nとなっている" do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end
    end
  end
end