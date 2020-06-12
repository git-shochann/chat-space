class CreateGroupUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :group_users do |t|
      t.references :group, foreign_key: true          # references型のgroup_idカラムを作成し、nullを制限し、ここのカラムは外部キーであると宣言してる。
      t.references :user, foreign_key: true           # 上記と同様。
      t.timestamps
    end
  end
end


### MEMO ###

# 外部キー制約(異なるテーブルのレコードと関係性を持つカラムが外部キー)ではreferences型が使用できる

#   => メリット1, 例えばuser_idとしたいところを、userとしてもuser_idとして作成してくれる！
#   => メリット2, インデックスを自動で貼ってくれる！


# t.references :group, null: false, foreign_key: true
# t.references :user, null: false, foreign_key: true