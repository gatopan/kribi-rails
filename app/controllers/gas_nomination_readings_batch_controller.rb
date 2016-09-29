class GasNominationReadingsBatchController < AbstractBatchController
  def parent_model
    GasPressureReducingStation
  end

  def children_model
    GasNominationReading
  end

  def children_attributes
    [
      {
        builder: :text_field,
        attribute: :nomination,
        type: :numeric,
        class: 'form-control',
        custom_name: 'Nomination (MSCF)'
      },
      {
        builder: :text_field,
        attribute: :delivery_on_specification,
        type: :numeric,
        class: 'form-control',
        custom_name: 'Delivery on-spec (MSCF)'
      },
      {
        builder: :text_field,
        attribute: :delivery_off_specification,
        type: :numeric,
        class: 'form-control',
        custom_name: 'Delivery off-spec (MSCF)'
      },
      {
        builder: :text_field,
        attribute: :high_heating_value,
        type: :numeric,
        class: 'form-control',
        custom_name: 'HHV (BTU/SCF)'
      },
      {
        builder: :text_field,
        attribute: :contractual_methane_number,
        type: :numeric,
        class: 'form-control',
        custom_name: nil
      }
    ]
  end
end
