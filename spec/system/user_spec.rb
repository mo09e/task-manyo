require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do

  describe '新規作成機能' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーが表示される' do
        visit tasks_path
        click_link 'Sign up'
        sleep 0.5
        fill_in 'user[name]', with: '桃太郎'
        fill_in 'user[email]', with: 'test_user@test.com'
        fill_in 'user[password]', with: 'frompeach'
        fill_in 'user[password_confirmation]', with: 'frompeach'
        click_on "Create account"
        expect(page).to have_content '桃太郎'
        expect(page).to have_content 'test_user@test.com'
      end
      it 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移する' do
        visit tasks_path
        expect(page). to have_content 'ログインが必要です'
      end
    end
  end

  describe "セッション機能テスト" do
    before do
      FactoryBot.create(:user)
    end
    context "ユーザーデータは有るがまだログインしていない場合" do
      it "ログインができること" do
        visit new_session_path
        fill_in 'Email', with: 'monalisa@sugoi.jp'
        fill_in 'Password', with: 'leonardo'
        sleep 0.5
        click_on 'Log in'
        expect(page).to have_content 'monalisa@sugoi.jp'
      end
    end
    context "ログイン済みで有る場合" do
      before do
        visit new_session_path
        fill_in 'Email', with: 'monalisa@sugoi.jp'
        fill_in 'Password', with: 'leonardo'
        sleep 0.5
        click_on 'Log in'
      end
      it "詳細画面に飛べること" do
        click_on 'Profile'
        expect(page).to have_content 'daVinchi'
      end
      it "他人の詳細画面に飛ぶとタスク一覧画面に遷移する" do
        @second_user = FactoryBot.create(:second_user)
        visit user_path(id: @second_user.id)
        expect(page).to have_content "他のユーザーページへはアクセスできません"
      end
      it "ログアウトができること" do
        click_link 'Logout'
        expect(page).to have_content "ログアウトしました"
      end
    end
  end

  describe '管理画面機能' do
    before do
      FactoryBot.create(:user)
      FactoryBot.create(:second_user)
    end
    context '管理ユーザーがログインしている時' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'monalisa@sugoi.jp'
        fill_in 'Password', with: 'leonardo'
        sleep 0.5
        click_on 'Log in'
      end
      it '管理ユーザーは管理画面にアクセスできる' do
        click_link 'Admin Page'
        expect(page). to have_content 'タスク数'
      end
      it '管理ユーザーはユーザーの新規作成ができる' do
        visit new_admin_user_path
        fill_in 'user[name]', with: 'test_user'
        fill_in 'user[email]', with: 'test_user@test.jp'
        fill_in 'user[password]', with: 'sampleda'
        fill_in 'user[password_confirmation]', with: 'sampleda'
        choose 'user_admin_true'
        click_on 'Create'
        expect(page).to have_content 'test_user'
      end
      it '管理ユーザーはユーザーの詳細画面にアクセスできる' do
        visit admin_users_path
        first('tbody tr').click_link 'show'
        expect(page).to have_content "User's Task List"
      end
      it '管理ユーザーはユーザーを編集できる' do
         visit admin_users_path
         first('tbody tr').click_link 'edit'
         fill_in 'user[name]', with: 'test_user1edit'
         fill_in 'user[email]', with: 'test_user_edit@test.jp'
         choose 'user_admin_false'
         click_on 'Create'
         expect(page).to have_content 'test_user1edit'
         expect(page).to have_content 'test_user_edit@test.jp'
       end
       it '管理ユーザーはユーザーを削除できる' do
        visit admin_users_path
        sleep 0.5
        page.accept_confirm do
          first('tbody tr').click_link 'delete'
        end
        expect(page).not_to have_content 'Michelangelo'
       end
    end
    context '一般ユーザーがログインしている時' do
      it '管理画面にアクセスできない' do
        visit new_session_path
        fill_in 'Email', with: 'pieta@sugoi.jp'
        fill_in 'Password', with: 'virginmary'
        sleep 0.5
        click_on 'Log in'
        visit admin_users_path
        expect(current_path).to eq tasks_path
      end
    end
  end
end
