require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  before do
    FactoryBot.create(:task, user: user)
    FactoryBot.create(:second_task, user: user)
    FactoryBot.create(:third_task, user: user)

    visit new_session_path
    fill_in 'Email', with: 'monalisa@sugoi.jp'
    fill_in 'Password', with: 'leonardo'
    sleep 0.5
    click_on 'Log in'
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in :task_task_name, with: 'task_name'
        fill_in :task_content, with: 'task'
        select '2021', from: :task_deadline_1i
        select '着手中', from: 'task_status'
        select '高', from: 'task_priority'
        click_on "Post task"
        expect(page).to have_content 'task'
        expect(page).to have_content '2021'
        expect(page).to have_content '着手中'
        expect(page).to have_content '高'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'sample'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'Eat lunch'
      end
    end
    context '終了期日でソートした場合' do
      it 'タスクが終了期日の降順に並んでいること' do
        visit tasks_path
        click_on '終了期限でソートをかける'
        task_list = all('.task_row_deadline')
        save_and_open_page
        expect(task_list[1]).to have_content '2020/08/29'
      end
    end
    context '優先順位でソートした場合' do
      it 'タスクが優先順位の降順に並んでいること' do
        visit tasks_path
        click_on '優先順位でソートをかける'
        task_list_p = all('.task_row_priority')
        sleep 0.5
        save_and_open_page
        expect(task_list_p[1]).to have_content '高'
        expect(task_list_p[3]).to have_content '低'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:second_task, user: user)
         visit task_path(task.id)
         expect(page).to have_content 'take a work'
       end
     end
  end

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in :task_name, with: 'in the'
        click_on '検索'
        expect(page).to have_content 'in the morning'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '完了', from: 'status'
        click_on '検索'
        expect(page).to have_content '完了'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in :task_name, with: 'at noon'
        select '未着手', from: 'status'
        click_on '検索'
        expect(page).to have_content 'at noon'
        expect(page).to have_content '完了'
      end
    end
  end
end
