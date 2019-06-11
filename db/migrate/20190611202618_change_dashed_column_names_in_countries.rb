class ChangeDashedColumnNamesInCountries < ActiveRecord::Migration
  def change
    remove_column :countries, :'itu-t_telephone_code', :string
    add_column :countries, :itu_t_telephone_code, :string
    remove_column :countries, :'iso_3166-1_2_letter_code', :string
    add_column :countries, :iso_3166_1_2_letter_code, :string
    remove_column :countries, :'iso_3166-1_3_letter_code', :string
    add_column :countries, :iso_3166_1_3_letter_code, :string
    remove_column :countries, :'iso_3166-1_number', :string
    add_column :countries, :iso_3166_1_number, :string
  end
end
