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

  describe "HOME画面のテスト" do
    before do
      visit home_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/home"
      end
      it "投稿したユーザー名のリンク先が正しい" do
        expect(page).to have_link "", href: user_path(article.user)
        expect(page).to have_link "", href: user_path(other_article.user)
      end
      it "自分の投稿と他人の投稿の投稿日が表示される" do
        expect(page).to have_content article.created_at.strftime("%Y年%m月%d日")
        expect(page).to have_content other_article.created_at.strftime("%Y年%m月%d日")
      end
      it "自分の投稿と他人の投稿のタイトルのリンク先が正しい" do
        expect(page).to have_link "", href: article_path(article)
        expect(page).to have_link "", href: article_path(other_article)
      end
      it "投稿のサブタイトルが表示される" do
        expect(page).to have_content article.sub_title
        expect(page).to have_content other_article.sub_title
      end
    end

    context "サイドバーの確認" do
      it "自分のニックネームと紹介文が表示される" do
        expect(page).to have_content user.nickname
        expect(page).to have_content user.introduction
      end
      it "自分の投稿数が表示される" do
        expect(page).to have_content user.articles.count
      end
      it "自分のフォロー数が表示される" do
        expect(page).to have_link user.followings.count
      end
      it "自分のフォロワー数が表示される" do
        expect(page).to have_link user.followers.count
      end
      it "マイページ画面へのリンクが表示される" do
        expect(page).to have_link "", href: user_path(user)
      end
      it "ランキングのタイトルが表示される" do
        expect(page).to have_content "本日のアウトプットランキング"
      end
      it "ランキングのユーザー名が表示される" do
        expect(page).to have_link user.nickname, href: user_path(user)
      end
    end
  end
end