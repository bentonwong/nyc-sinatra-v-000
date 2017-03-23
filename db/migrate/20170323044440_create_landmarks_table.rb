class CreateLandmarksTable < ActiveRecord::Migration
  def change
    create_table :landmarks do |t|
     t.string :name
     t.integer :figure_id
     t.year_completed :integer
    end
  end
end
