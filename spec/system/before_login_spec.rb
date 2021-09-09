require 'rails_helper'

describe "ユーザーログイン前のテスト" do
  describe "TOP画面のテスト" do
    before do
      visit root_path #Capybara が提供するメソッド
    end
    
    context "表示内容の確認" do 
      it "URLが正しい" do
        expect(current_path).to eq '/'
      end
    end
  end
end