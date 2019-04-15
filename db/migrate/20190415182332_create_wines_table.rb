class CreateWinesTable < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :wine_name
      t.string :type
      t.string :varietal
      t.string :region
      t.string :year 
      t.string :price 
      t.string :tasting_notes
    end 
  end
end
