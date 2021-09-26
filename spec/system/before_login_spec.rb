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
  end

  describe "ユーザー新規登録のテスト" do
      before do
        visit new_user_registration_path
      end

      context "表示の確認" do
        it "URLが正しい" do
          expect(current_path).to eq "/users/sign_up"
        end
        it "TeachMarketへようこそ！ と表示される" do
          expect(page).to have_content "TeachMarketへようこそ！"
        end
        it "お名前フォームが表示される" do
          expect(page).to have_field "user[name]"
        end
        it "メールアドレスフォームが表示される" do
          expect(page).to have_field "user[email]"
        end
        it "パスワードフォームが表示される" do
          expect(page).to have_field "user[password]"
        end
        it "パスワード(確認用)が表示される" do
          expect(page).to have_field "user[password_confirmation]"
        end
        it "「登録する」が表示される" do
          expect(page).to have_button "登録する"
        end
      end

      context "新規登録成功のテスト" do
        before do
          fill_in "user[name]", with: Faker::Lorem.characters(number: 10)
          fill_in "user[email]", with: Faker::Internet.email
          fill_in "user[nickname]", with: Faker::Lorem.characters(number: 10)
          fill_in "user[password]", with: "password"
          fill_in "user[password_confirmation]", with: "password"
        end

        it " 新規登録が正しく実行される" do
          expect do
            click_button "登録する"
          end.to change(User, :count).by(1)
        end
        
        it "新規登録後、HOMEに遷移する" do 
          click_button "登録する"
          expect(current_path).to eq "/home.1"
        end
      end
    end
    
    describe "ユーザーログイン" do
       let(:user) { create(:user) }
       
       before do
         visit new_user_session_path
       end
       
       context "表示内容の確認" do
         it "URLが正しい" do
            expect(current_path).to eq "/users/sign_in"
         end
         it "「TeachMarketへログイン」と表示される" do
            expect(page).to have_content "TeachMarketへログイン"
         end
         it "nicknameフォームが表示される" do
            expect(page).to have_field "user[nickname]"
         end
         it "passwordフォームが表示される" do
            expect(page).to have_field "user[password]"
         end
        it "「TeachMarketにログイン」ボタンが表示される" do
            expect(page).to have_button "TeachMarketにログイン"
        end
       end
       context "ログイン成功のテスト" do
         before do
          fill_in "user[nickname]", with: user.nickname
          fill_in "user[password]", with: user.password
          click_button "TeachMarketにログイン"
         end
         
         it "ログイン後のリダイレクト先が、HOMEになっている" do
           expect(current_path).to eq "/home.1"
         end
       end
       
       describe "ログイン失敗のテスト"
       
    end
  
