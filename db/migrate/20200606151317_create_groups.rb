class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :name, null:false     # string型のtitleカラムでnullを禁止する。
      t.index :name, unique: true    # インデックスの書き方Ver.2に一意性制約(テーブル内で重複するデータを禁止する)を使うときにはindexを一緒に貼らなければいけないのでこの書き方。
      t.timestamps
    end
  end
end



#  t.カラムの型 :カラム名, 制約等