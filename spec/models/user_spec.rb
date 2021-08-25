require 'rails_helper'

Rspec.describe User, type: :model do
   describe "モデルのテスト" do
     it "有効なuserの場合は保存されるか" do
       except(build(:user)).to be_valid
     end
    
     content "バリデーションチェック" do
       it "nameが空白の場合エラーメッセージが返ってくるか" do
         user = build(:user, name: nill)
         user.valid?
         except(user.errors[:name]).to include("を入力してください")
       end
       
       it "nicknameが空白の場合エラーメッセージが返ってくるか" do
          nickname = build(:user, nickname: nill)
          user.valid?
          except(user.errors[:nickname]).to include("入力してください")
       end
       
       it "emailが空白の場合にエラーメッセージが返ってくるか" do
          user = build(:user, email: nill)
          user.valid?
          except(user.errors[:email]).to.include("入力してください")
       end
       
       it "passwordが空白の場合エラーメッセージが返ってくるか" do 
          user = build(:user, password: nill)
          user.valid?
          except(user.errors[:password]).to.include("入力してください")
       end
     end
     
     it "nameの文字数が1文字以下でエラーメッセージが返ってくるか"
   end  
end