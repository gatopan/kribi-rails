class ChromatographReadingsBatchController < AbstractBatchController
  def parent_model
    Chromatograph
  end

  def children_model
    ChromatographReading
  end

  def children_attributes
    [
      {
        builder: :text_field,
        attribute: :un_norm_total,
        type: :numeric,
        class: 'form-control',
      },
      {
        builder: :text_field,
        attribute: :higher_heating_value,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :lower_heating_value,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :specific_gravity,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :compressibility,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :propane,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :isobutane,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :normal_butane,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :neopentane,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :isopentane,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :normal_pentane,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :hexane_and_more,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :nitrogen,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :methane,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :carbon_dioxide,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :ethane,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :grouped_pentane,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :grouped_butane,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :corrected_methane,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :corrected_butane,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :methane_number,
        type: :numeric,
        class: 'form-control'
      }
    ]
  end
end
