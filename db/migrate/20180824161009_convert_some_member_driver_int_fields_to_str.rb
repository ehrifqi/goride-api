class ConvertSomeMemberDriverIntFieldsToStr < ActiveRecord::Migration[5.2]
  def change
    # Change members column (int -> str)
    # - phone_number
    change_column :members, :phone_number, :string

    # Change drivers column (int -> str)
    # - phone_number
    # - license_number
    # - ktp_number
    change_column :drivers, :phone_number, :string
    change_column :drivers, :license_number, :string
    change_column :drivers, :ktp_number, :string
  end
end
