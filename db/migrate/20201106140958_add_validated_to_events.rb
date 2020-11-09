class AddValidatedToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :is_validated, :boolean, :default => nil
  end
end
