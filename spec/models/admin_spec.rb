require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:user) { create(:user) }

  describe "モデルのテスト" do
    it "有効なadminの場合は保存されるか" do
      expect(build(:admin)).to be_valid
    end
  end
end
