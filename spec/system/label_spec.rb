require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  before do
    FactoryBot.create(:label)
    FactoryBot.create(:second_label)

    visit new_session_path
    fill_in 'Email', with: 'monalisa@sugoi.jp'
    fill_in 'Password', with: 'leonardo'
    sleep 0.5
    click_on 'Log in'
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクにラベルを追加できる' do
        visit new_task_path
        fill_in :task_task_name, with: 'task_name'
        fill_in :task_content, with: 'task'
        select '2021', from: :task_deadline_1i
        select '着手中', from: 'task_status'
        select '高', from: 'task_priority'
        check 'work'
        click_on "Post task"
        expect(page).to have_content 'task'
        expect(page).to have_content '2021'
        expect(page).to have_content '着手中'
        expect(page).to have_content 'work'
        expect(page).to have_content '高'
      end
    end
  end

  describe '表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧と一緒にラベルが表示される' do
        visit new_task_path
        fill_in :task_task_name, with: 'second_name'
        fill_in :task_content, with: 'tast'
        select '2020', from: :task_deadline_1i
        select '完了', from: 'task_status'
        select '低', from: 'task_priority'
        check 'etc'
        click_on "Post task"
        expect(page).to have_content 'etc'
      end
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容とラベルが表示される' do
        visit new_task_path
        fill_in :task_task_name, with: 'task_name'
        fill_in :task_content, with: 'task'
        select '2021', from: :task_deadline_1i
        select '着手中', from: 'task_status'
        select '高', from: 'task_priority'
        check 'work'
        click_on "Post task"
        sleep 0.5
        tds = page.all('td')
        tds[6].click
        expect(page).to have_content 'work'
      end
    end
  end

  describe '検索機能' do
    let!(:user) { FactoryBot.create(:user) }
    before do
      visit new_task_path
      fill_in :task_task_name, with: 'task_name'
      fill_in :task_content, with: 'task'
      select '2021', from: :task_deadline_1i
      select '着手中', from: 'task_status'
      select '高', from: 'task_priority'
      check 'work'
      click_on "Post task"
      visit tasks_path
    end
   context 'ラベルのみで検索した場合' do
     it 'ラベルで検索した場合' do
       select 'work', from: 'label_id'
       click_on '検索'
       task = all('tbody tr')
       expect(task[0]).to have_content 'work'
      end
      it 'タイトル・ステータス・ラベルで検索した場合' do
        fill_in :task_name, with: 'task_name'
        select '着手中', from: 'status'
        select 'work', from: 'label_id'
        click_on '検索'
        task = all('tbody tr')
        expect(task[0]).to have_content 'task_name'
        expect(task[0]).to have_content '着手中'
        expect(task[0]).to have_content 'work'
       end
    end
  end

end
