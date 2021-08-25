require 'rails_helper'

Rspec.describe User, type: :model do
   describe "モデルのテスト" do
      
     it "有効なuserの場合は保存されるか" do
       except(build(:user)).to be_valid
     end
     
     let!(:other_user){ create(:user)}
     let(:user){build(:user)}
    
     content "nameカラムのテスト" do
       it "空白の場合エラーメッセージが返ってくるか" do
         user.name = ""
         is_expexted.to eq false
       end
       
       it "長さが1文字以下の場合エラーメッセージが返ってくるか" do
          user.name = Faker::Lorem.characters(number: 1)
          is_expexted.to eq false
       end
       
       it "長さが2文字以上ある場合成功するか" do 
          user.name = Faker::Lorem.characters(number: 2)
          is_expexted.to eq true
       end
       
       it "長さが11文字以上の場合エラーメッセージが返ってくるか" do
          user.name = Faker::Lorem.characters(number: 11)
          is_expexted.to eq false
       end
       
       it "長さが10文字以下である場合成功するか" do 
          user.name = Faker::Lorem.characters(number: 10)
          is_expexted.to eq true
       end
       
       it "一意性があるかどうか" do
          user.name = other_user.name
          is_expexted.to eq true
       end
     end
     
     content "nicknameのカラムのテスト" do
       it "nicknameが空白の場合エラーメッセージが返ってくるか" do
         user.nickname = ""
         is_expexted.to eq false
       end
       
       it "長さが1文字以下の場合エラーメッセージが返ってくるか" do
          user.nickname = Faker::Lorem.characters(number: 1)
          is_expexted.to eq false
       end
       
       it "長さが2文字以上ある場合成功するか" do 
          user.name = Faker::Lorem.characters(number: 2)
          is_expexted.to eq true
       end
       
       it "長さが11文字以上の場合エラーメッセージが返ってくるか" do
          user.name = Faker::Lorem.characters(number: 11)
          is_expexted.to eq false
       end
       
       it "長さが10文字以下である場合成功するか" do 
          user.name = Faker::Lorem.characters(number: 10)
          is_expexted.to eq true
       end
       
       it "一意性があるかどうか" do
          user.name = other_user.name
          is_expexted.to eq true
       end
     end
     
     content "emailのカラムのテスト" do
       it "emailが空白の場合にエラーメッセージが返ってくるか" do
          user = build(:user, email: nill)
          user.valid?
          except(user.errors[:email]).to.include("入力してください")
       end
     end
     
     content "introductionのカラムのテスト" do
       it "passwordが空白の場合エラーメッセージが返ってくるか" do 
          user = build(:user, password: nill)
          user.valid?
          except(user.errors[:password]).to.include("入力してください")
       end
     end
   end  
end