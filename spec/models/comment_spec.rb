require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  
  describe "バリデーションのテスト" do
    context "投稿できない場合" do
      
      it "コメントと評価が空では投稿できない" do
        @comment.comment_content = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Rateは数値で入力してください")
      end
      
      it "ユーザーが紐付いていなければコメントできない" do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Userを入力してください")
      end
      
      it "記事が紐付いていなければコメントできない" do
        @comment.article = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Articleを入力してください")
      end
    end
  end
  
  describe "アソシエーションのテスト" do
    context "Articleモデルとの関係" do
      it "N:1となっている" do
        expect(Comment.reflect_on_association(:article).macro).to eq :belongs_to
      end
    end
    
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    
    context "Notificationモデルとの関係" do
      it "1:となっている" do
        expect(Comment.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end
