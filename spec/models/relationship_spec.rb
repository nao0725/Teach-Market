require 'rails_helper'

RSpec.describe Relationship, type: :model do
   let!(:relationship) { FactoryBot.create(:relationship) }

  describe "モデルのテスト" do
    it "有効なRelationshipの場合は保存されるか" do
      expect(build(:relationship)).to be_valid
    end
  end
end