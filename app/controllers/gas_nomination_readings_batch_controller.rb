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
        attribute: :delivery,
        type: :numeric,
        class: 'form-control',
        custom_name: 'Delivery (MSCF)'
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
      },
      {
        builder: :text_field,
        attribute: :quality,
        type: :numeric,
        class: 'form-control',
        editable: false
      }
    ]
  end
end
