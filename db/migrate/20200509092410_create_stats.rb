class CreateStats < ActiveRecord::Migration[6.0]
  def change
    create_table :stats do |t|
    	t.integer :link_id
    	t.string :country
	  	t.string :state
	  	
      t.timestamps
    end
  end
end
