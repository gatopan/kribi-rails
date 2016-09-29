class ChromatographReading < AbstractIntervalModel
  PARENT_MODEL = Chromatograph
  CUSTOM_NAME = nil
  COUNTER_VALUES_COLUMNS = [
    {
      name: :un_norm_total,
      type: :absolute,
    },
    {
      name: :higher_heating_value,
      type: :absolute,
    },
    {
      name: :lower_heating_value,
      type: :absolute,
    },
    {
      name: :specific_gravity,
      type: :absolute,
    },
    {
      name: :compressibility,
      type: :absolute,
    },
    {
      name: :propane,
      type: :absolute,
    },
    {
      name: :isobutane,
      type: :absolute,
    },
    {
      name: :normal_butane,
      type: :absolute,
    },
    {
      name: :neopentane,
      type: :absolute,
    },
    {
      name: :isopentane,
      type: :absolute,
    },
    {
      name: :normal_pentane,
      type: :absolute,
    },
    {
      name: :hexane_and_more,
      type: :absolute,
    },
    {
      name: :nitrogen,
      type: :absolute,
    },
    {
      name: :methane,
      type: :absolute,
    },
    {
      name: :carbon_dioxide,
      type: :absolute,
    },
    {
      name: :ethane,
      type: :absolute,
    },
    {
      name: :grouped_pentane,
      type: :absolute,
    },
    {
      name: :grouped_butane,
      type: :absolute,
    },
    {
      name: :corrected_methane,
      type: :absolute,
    },
    {
     name: :corrected_butane,
     type: :absolute,
    },
    {
     name: :methane_number,
     type: :absolute,
    }
  ]
  INTERVAL_IN_MINUTES = 60
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
      {
        query: {
          type: :aggregate,
          fragment: 'avg(methane_number) as methane_number_avg,'\
                    'avg(higher_heating_value) as higher_heating_value_avg,'\
                    'avg(lower_heating_value) as lower_heating_value_avg,'\
                    'avg(specific_gravity) as specific_gravity_avg'
        },
        destination: {
          type: :excel,
          template: false,
          filename_prefix: 'kpp_kpi_report',
          worksheet_name: self.table_name
        }
      },
      {
        query: {
          type: :dump,
        },
        destination: {
          type: :excel,
          template: false,
          filename_prefix: "#{self.table_name}_dump",
          worksheet_name: self.table_name
        }
      }
    ]
  }

  abstract_bootloader()

  before_validation do
    self.grouped_pentane = calculated_grouped_pentane
    self.grouped_butane = calculated_grouped_butane
    self.corrected_methane = calculated_corrected_methane
    self.corrected_butane = calculated_corrected_methane
  end

  # FORMAT
  validates :un_norm_total, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :higher_heating_value, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :lower_heating_value, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :specific_gravity, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :compressibility, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :propane, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :isobutane, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :normal_butane, {
    presence: true,
  #   format: {
  #     with: /\A[0-9]+\.[0-9]{1,3}\Z/,
  #     message: 'must contain up to three decimal places'
  #   }
  }
  validates :neopentane, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :isopentane, {
    presence: true,
  #   format: {
  #     with: /\A[0-9]+\.[0-9]{1,3}\Z/,
  #     message: 'must contain up to three decimal places'
  #   }
  }
  validates :normal_pentane, {
    presence: true,
  #   format: {
  #     with: /\A[0-9]+\.[0-9]{1,3}\Z/,
  #     message: 'must contain up to three decimal places'
  #   }
  }
  validates :hexane_and_more, {
    presence: true,
  #   format: {
  #     with: /\A[0-9]+\.[0-9]{1,3}\Z/,
  #     message: 'must contain up to three decimal places'
  #   }
  }
  validates :nitrogen, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :methane, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :carbon_dioxide, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :ethane, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :grouped_pentane, {
    presence: :true
  #   format: {
  #     with: /\A[0-9]+\.[0-9]{1,3}\Z/,
  #     message: 'must contain up to three decimal places'
  #   }
  }
  validates :grouped_butane, {
    presence: :true
  #   format: {
  #     with: /\A[0-9]+\.[0-9]{1,3}\Z/,
  #     message: 'must contain up to three decimal places'
  #   }
  }
  validates :corrected_methane, {
    presence: true,
  #   format: {
  #     with: /\A[0-9]+\.[0-9]{1,3}\Z/,
  #     message: 'must contain up to three decimal places'
  #   }
  }
  validates :corrected_butane, {
    presence: true,
  #   format: {
  #     with: /\A[0-9]+\.[0-9]{1,3}\Z/,
  #     message: 'must contain up to three decimal places'
  #   }
  }
  validates :methane_number, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }

  # RANGES
  validates :un_norm_total, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :higher_heating_value, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :lower_heating_value, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :specific_gravity, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :compressibility, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :propane, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :isobutane, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :normal_butane, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :neopentane, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :isopentane, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :normal_pentane, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :hexane_and_more, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :nitrogen, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :methane, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :carbon_dioxide, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :ethane, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :corrected_methane, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :corrected_butane, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    on: :congruence
  }
  validates :methane_number, {
    numericality: {
      greater_than_or_equal_to: 60,
      less_than_or_equal_to: 80
    },
    on: :congruence
  }

  private

  def calculated_grouped_pentane
    return unless neopentane
    return unless isopentane
    return unless normal_pentane
    neopentane + isopentane + normal_pentane
  end

  def calculated_grouped_butane
    return unless isobutane
    return unless normal_butane
    isobutane + normal_butane
  end

  def calculated_corrected_methane
    return unless methane
    return unless calculated_grouped_pentane
    return unless hexane_and_more
    methane - 0.3 * calculated_grouped_pentane - 0.9 * hexane_and_more
  end

  def calculated_corrected_butane
    return unless calculated_grouped_butane
    return unless calculated_grouped_pentane
    return unless hexane_and_more
    calculated_grouped_butane + 1.3 * calculated_grouped_pentane + 1.9 * hexane_and_more
  end
end

