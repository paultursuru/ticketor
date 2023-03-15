class AddTeacherToTicket < ActiveRecord::Migration[7.0]
  def change
    add_reference :tickets, :teacher, null: false, foreign_key: { to_table: :users }
  end
end
