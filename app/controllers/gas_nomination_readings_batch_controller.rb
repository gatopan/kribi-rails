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
      },
      {
        builder: :text_field,
        attribute: :delivery,
        type: :numeric,
        class: 'form-control',
      },
      {
        builder: :text_field,
        attribute: :high_heating_value,
        type: :numeric,
        class: 'form-control',
      }
    ]
  end
end
