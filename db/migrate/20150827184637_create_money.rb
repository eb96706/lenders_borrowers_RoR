class CreateMoney < ActiveRecord::Migration
  def change
    create_table :money do |t|
      t.references :lender, index: true
      t.references :borrower, index: true
      t.integer :amount

      t.timestamps
    end
  end
end
