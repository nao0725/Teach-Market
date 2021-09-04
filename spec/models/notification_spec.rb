require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject { notification.valid? }

  describe "モデルのテスト" do
    it "有効なNotificationの場合は保存されるか" do
      expect(build(:notification)).to be_valid
    end
  end
end