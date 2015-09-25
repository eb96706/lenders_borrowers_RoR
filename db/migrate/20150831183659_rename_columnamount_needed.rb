class RenameColumnamountNeeded < ActiveRecord::Migration

  def change
  	## rails g migration RenameColumnamountNeeded
  	rename_column :borrowers, :amountNeeded, :amount_needed
  	## rake db:migrate
  end

end
