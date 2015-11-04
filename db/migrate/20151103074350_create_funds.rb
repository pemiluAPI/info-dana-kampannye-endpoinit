class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
			t.string :id_participant
			t.string :name
			t.string :revenue
			t.string :operating_expenses
			t.string :capital_expenditures
			t.string :other_expenses
			t.string :balance
			t.string :cash_special_account
			t.string :cash_treasurer
			t.string :goods
      t.timestamps
    end
  end
end
