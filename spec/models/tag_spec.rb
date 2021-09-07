require 'rails_helper'

RSpec.describe Tag , type: :model do
  let(:tag) { FactoryBot.create(:tag) }

  describe "バリデーションのテスト" do
    context "tag_nameカラムのテスト" do
      it "空白の場合エラーメッセージが返ってくるか" do
        tag.tag_name = ""
        tag.valid?
        expect(tag.errors[:tag_name]).to include("を入力してください")
      end
    end
  end
end
