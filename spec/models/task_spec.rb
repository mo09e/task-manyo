require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'タスクモデル機能', type: :model do

    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do
          task = Task.new(task_name: '', content: '失敗テスト')
          expect(task).not_to be_valid
        end
      end
      context 'タスクの詳細が空の場合' do
        it 'バリデーションにひっかかる' do
          task = Task.new(task_name: '失敗テスト', content: '')
          expect(task).not_to be_valid
        end
      end
      context 'タスクのタイトルと詳細に内容が記載されている場合' do
        it 'バリデーションが通る' do
          user =  FactoryBot.create(:user)
          @task1 = FactoryBot.create(:task, user: user)
          expect(@task1).to be_valid
        end
      end
    end

    describe '検索機能' do
      before do
        user =  FactoryBot.create(:user)
        @task1 = FactoryBot.create(:task, user: user)
        @task2 = FactoryBot.create(:second_task, user: user)
        @task3 = FactoryBot.create(:third_task, user: user)
      end
        context 'scopeメソッドでタイトルのあいまい検索をした場合' do
          it "検索キーワードを含むタスクが絞り込まれる" do
            expect(Task.task_name_search('sample_name')).to include(@task1)
            expect(Task.task_name_search('sample_name')).not_to include(@task2)
            expect(Task.task_name_search('sample_name').count).to eq 1
          end
        end
        context 'scopeメソッドでステータス検索をした場合' do
          it "ステータスに完全一致するタスクが絞り込まれる" do
            expect(Task.status_search('完了').count).to eq 1
          end
        end
        context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
          it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
            expect(Task.task_name_search('at noon').status_search('未着手').count).to eq 1
          end
        end
      end

  end
end
