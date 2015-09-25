class AddColumnToBorrowers < ActiveRecord::Migration

  def change
  	## rails g migration AddColumnToBorrowers
  	add_column :borrowers, :amount_raised, :integer
  	## rake db:migrate
  end

end
