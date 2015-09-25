class Changemoney < ActiveRecord::Migration
  def change
  	## rails generate migration changemoney
  	rename_column :lenders, :money, :money_amount
  	## rake db:migrate
  end
end
