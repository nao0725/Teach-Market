require 'rails_helper'

describe "ユーザーログイン前のテスト" do
  describe "TOP画面のテスト" do
    before do
      visit root_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/'
      end

      it "「今すぐ始める」リンクが表示される" do
        expect(page).to have_link "今すぐ始める"
      end

      it "「既に会員の方はこちら」リンクが表示される" do
        expect(page).to have_link "既に会員の方はこちら"
      end

      it "「ゲストログイン」リンクが表示される" do
        expect(page).to have_link "ゲストログイン"
      end
    end
    
    context "リンク内容の確認" do
      subject {current_path}
      
      it "詳細はこちらをクリックのリンクを押すとヘルプのページに遷移する" do
        click_on "詳細はこちらをクリック"
        is_expected.to eq "/help"
      end
      it "新規会員登録のリンクを押すと新規登録画面に遷移する" do
        click_on "新規会員登録", match: :prefer_exact
        is_expected.to eq "/users/sign_up"
      end
      it "ログインのリンクを押すとログイン画面に遷移する" do
        click_on "ログイン", match: :prefer_exact
        is_expected.to eq "/users/sign_in"
      end
    end
  end
end

describe "ヘルプ画面のテスト" do
    before do
      visit "/help"
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/help'
      end
    end
  end

  describe "ヘッダーのテスト(ログイン前)" do
    before do
      visit root_path
    end
    
    context "表示の確認" do
      it "タイトルが表示される" do
        expect(page).to have_content "TeachMarket"
      end
      it "新規会員登録のリンクの表示" do
        expect(page).to have_link "新規会員登録"
      end
      it "ログインのリンクの表示" do
        expect(page).to have_link "ログイン"
      end
      it "ゲストログインのリンクの表示" do
        expect(page).to have_link "ゲストログイン"
      end
    end
    
    context "リンクの内容の確認" do
      subject {current_path}
      
      it "新規会員登録のリンクを押すと新規登録画面に遷移する" do
        click_on "新規会員登録", match: :first
        is_expected.to eq "/users/sign_up"
      end
      it "ログインのリンクを押すとログイン画面に遷移する" do
        click_on "ログイン", match: :first
        is_expected.to eq "/users/sign_in"
      end
      it "アプリの使い方のリンクを押すとヘルプのページに遷移する" do
        click_on "アプリの使い方"
        is_expected.to eq "/help"
      end
    end
    
    describe "ユーザー新規登録のテスト" do
      before do
        visit new_user_registration_path
      end
      
      context "表示の確認"
      it ""do
      end
    end
  end