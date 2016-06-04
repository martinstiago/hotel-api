class AddAccomodationTypesReferenceOnHotels < ActiveRecord::Migration[5.0]
  def change
    add_reference :hotels, :accomodation_type, index: true, foreign_key: true
  end
end
