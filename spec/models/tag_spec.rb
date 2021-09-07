require 'rails_helper'

RSpec.describe Tag , type: :model do
  let(:tag) { FactoryBot.create(:tag) }

  describe "バリデーションのテスト" do
    context "tag_nameカラムのテスト" do
      it "空白の場合エラーメッセージが返ってくるか" do
        tag.tag_name = ""
        is_expected.to eq false
      end
    end
  end
end
