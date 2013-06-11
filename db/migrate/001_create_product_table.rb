class CreateProductTable < ActiveRecord::Migration
  def change
	  create_table(:product) do |t|
		  t.string :name
			t.string :description
			
			t.timestamps
		end
	end
end
