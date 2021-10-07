require 'rails_helper'

describe "ユーザーログイン後のテスト" do
  let(:user){ create(:user) }
  let!(:other_user){ create(:user) }
  let!(:article){ create(:article, user: user) }
  let!(:other_article){ create(:article, user:other_user)}
  
  before do
    visit new_user_session_path
    fill_in "user[nickname]", with: user.nickname
    fill_in "user[password]", with: user.password
    click_button "TeachMarketにログイン"
  end
  
  describe "ヘッダーのテスト:ログインしている場合" do
    context "リンクの内容確認" do
      subject { current_path }
      
      it "タイトルをクリックするとHOME画面に戻る" do
        click_link "TeachMarket"
        is_expected.to eq "/home"
      end
      
      it "マイページを押すとユーザー詳細画面に遷移する" do
        click_on "マイページ", match: :first
        is_expected.to eq "/users/2"
      end
      
      it "アウトプットを押すと投稿画面に遷移する" do
        click_link "アウトプット"
        is_expected.to eq "/articles/new"
      end
    end
  end
end