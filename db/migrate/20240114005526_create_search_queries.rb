class CreateSearchQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :search_queries do |t|
      t.string :query
      t.string :user_identifier
      t.timestamps
    end
    add_index :search_queries, :query
    add_index :search_queries, :user_identifier
  end
end
