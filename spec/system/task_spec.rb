require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in :task_task_name, with: 'task_name'
        fill_in :task_content, with: 'task'
        select '2021', from: :task_deadline_1i
        click_on "Post task"
        expect(page).to have_content 'task'
        expect(page).to have_content '2021'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, task_name: 'task', content: 'iroha', deadline: '2020-09-01 16:00:00')
        visit tasks_path
        current_path
        Task.count
        page.html
        expect(page).to have_content 'task'
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
        click_link '終了期限でソートをかける'
        task_list = all('.task_row_deadline')
        expect(task_list[1]).to have_content '2020/08/29'
        expect(task_list[2]).to have_content '2020/08/30'
        expect(task_list[3]).to have_content '2021/08/31'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:second_task)
         visit task_path(task.id)
         expect(page).to have_content 'take a work'
       end
     end
  end
end
