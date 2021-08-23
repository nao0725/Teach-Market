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
     end
   end  
end