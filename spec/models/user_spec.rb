require 'rails_helper'

RSpec.describe User, type: :model do
  subject { user.valid? }

  let!(:other_user) { create(:user) }
  let(:user) { build(:user) }

  describe "バリデーションのテスト" do
    it "有効なuserの場合は保存されるか" do
      expect(build(:user)).to be_valid
    end
  end

  describe "バリデーションのテスト" do
    context "nameカラムのテスト" do
      it "空白の場合エラーメッセージが返ってくるか" do
        user.name = ""
        is_expected.to eq false
      end

      it "長さが1文字以下の場合エラーメッセージが返ってくるか" do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end

      it "長さが2文字以上ある場合成功するか" do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end

      it "長さが11文字以上の場合エラーメッセージが返ってくるか" do
        user.name = Faker::Lorem.characters(number: 11)
        is_expected.to eq false
      end

      it "長さが10文字以下である場合成功するか" do
        user.name = Faker::Lorem.characters(number: 10)
        is_expected.to eq true
      end

      it "一意性があるかどうか" do
        user.name = other_user.name
        is_expected.to eq false
      end
    end

    context "nicknameのカラムのテスト" do
      it "空白の場合エラーメッセージが返ってくるか" do
        user.nickname = ""
        is_expected.to eq false
      end

      it "長さが1文字以下の場合エラーメッセージが返ってくるか" do
        user.nickname = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end

      it "長さが2文字以上ある場合成功するか" do
        user.nickname = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end

      it "長さが11文字以上の場合エラーメッセージが返ってくるか" do
        user.nickname = Faker::Lorem.characters(number: 11)
        is_expected.to eq false
      end

      it "長さが10文字以下である場合成功するか" do
        user.nickname = Faker::Lorem.characters(number: 10)
        is_expected.to eq true
      end

      it "一意性があるかどうか" do
        user.nickname = other_user.name
        is_expected.to eq true
      end
    end

    context "introductionのカラムのテスト" do
      it "長さが50文字以下の場合は成功" do
        user.introduction = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end

      it "長さが51文字以上の場合はエラーメッセージが返ってくるか" do
        user.introduction = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

    context "emailのカラムのテスト" do
      it "空白の場合エラーメッセージが返ってくるか" do
        user.email = ""
        is_expected.to eq false
      end

      it "一意性があるかどうか" do
        user.email = other_user.name
        is_expected.to eq false
      end
    end

    context "passwordのカラムのテスト" do
      it "空白の場合エラーメッセージが返ってくるか" do
        user.password = ""
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Articleモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:articles).macro).to eq :has_many
      end
    end
  end
end
