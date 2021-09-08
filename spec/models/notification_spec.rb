require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject { notification.valid? }

  describe "モデルのテスト" do
    it "有効なNotificationの場合は保存されるか" do
      expect(build(:notification)).to be_valid
    end
  end
  
  describe "アソシエーションのテスト" do
    context "Commentモデルとの関係" do
      it "N:1となっている" do
        expect(Notification.reflect_on_association(:comment).macro).to eq :belongs_to
      end
    end
    
    context "Articleモデルとの関係" do
      it "1:Nとなっている" do
        expect(Notification.reflect_on_association(:article).macro).to eq :belongs_to
      end
    end
    
  end
end