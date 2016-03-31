# NOTE: Middle class model, only used during export
class EngineTripExportEvent < AbstractEventModel
  self.inheritance_column = nil
  PARENT_MODEL = Engine
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
      {
        query: {
          type: :aggregate,
          fragment: 'sum(duration_in_hours) as duration_in_hours_sum'
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
  CALCULATED_FIELD_NAMES = [
    'duration_in_hours',
    'power_generated_during_light_fuel_oil_consumption'
  ]
  abstract_bootloader()

  enum equipment: {
    EQUIPMENT_NONE: 0,
    AVR: 5,
    BACK_FLUSH_FILTER: 10,
    CBU: 20,
    CCM_CARD: 30,
    CYLINDER_EXHAUST_GAS_BELLOW: 40,
    CYLINDER_EXHAUST_THERMOCOUPLE: 50,
    GAS_VALVE: 60,
    GRU: 70,
    HT_THREE_WAY_VALVE: 80,
    HT_WATER_LINE: 90,
    INJECTION_PUMP: 100,
    INJECTOR: 110,
    KFSD_CARD: 120,
    KNOCKING_SENSOR: 130,
    LFO_THREE_WAY_VALVE: 140,
    LO_FILTERS: 150,
    LO_THREE_WAY_VALVE: 160,
    LT_THREE_WAY_VALVE: 170,
    LT_WATER_LINE: 180,
    MCM_CARD: 190,
    PILOT_FILTER: 200,
    PILOT_LINE: 210,
    TURBO_CHARGER: 220
  }

  enum bank: {
    BANK_A: 10,
    BANK_B: 20
  }

  enum type: {
    TYPE_NONE: 0,
    PILOT_TRIP: 10,
    GAS_TRIP: 20,
    SHUT_DOWN: 30,
    NO_TRIP: 40,
    GRID_TRIP: 50,
    SNH_TRIP: 60,
    FAILED_START: 70
  }

  enum context: {
    CONTEXT_NONE: 0,
    STARTING_PHASE: 5,
    NORMAL_OPERATION: 10,
    TURBINE_WASHING: 20,
    COMPRESSOR_WASHING: 30,
    GRID_FAILURE: 40,
    GAS_DELIVERY_FAILURE: 50,
    STOPPING_PHASE: 60
  }

  enum owner: {
    OWNER_NONE: 0,
    MECHANICAL: 5,
    ELECTRICAL: 10,
    OPERATION: 20,
    CONTRACTOR: 30
  }

  enum alarm: {
    ALARM_NONE: 0,
    AVR_EXCITATION: 5,
    CA_PRESS_ENGINE_INLET: 10,
    CAN_FAILURE: 20,
    DISTRIBUTED_IO_COMM_FAULT_PIPE_MODULE: 30,
    E_EMG_MECHANICAL_OVERSPEED_SHUTDOWN: 40,
    E_EMG_SF_SPEED_SIGNAL_MISSING: 50,
    ENGINE_BREAKER_TRIP: 60,
    ENGINE_LOAD_SWING: 70,
    EXTERNAL_SHUTDOWN_STATUS_SD: 80,
    FEEDER_PUMP_UNITS_FUSE_FAILURE: 90,
    GEN_PROT_RESERVE_POWER: 100,
    GENERATOR_BREAKER_STATUS_NO: 110,
    HIGH_EXHAUST_GAS_TEMP_CYL: 120,
    HIGH_FO_TEMP_ENGINE_INLET: 130,
    HIGH_INLET_GAS_PRESSURE: 140,
    HIGH_KNOCK_IN_CYLINDERS_: 150,
    HIGH_MAIN_GAS_PRESS_BUILDUP_TIME_ELAPSED: 160,
    HIGH_MAIN_GAS_PRESS_DEV_FROM_REF: 170,
    HIGH_PF_TEMP_INLET: 180,
    HIGH_PILOT_FUEL_TEMP_INLET: 190,
    HING_CA_TEMP_INLET: 200,
    HT_WATER_TEMP_SHUTDOWN_STATUS: 210,
    IDLE_MAX_TIME_REACHED: 220,
    LO_PRESSURE_STATUS_ENGINE_INLET_SD: 230,
    LOSS_OF_VOLTAGE_EXCITATION: 240,
    LOW_DRIVE_SUPPLY_VOLTAGE: 250,
    LOW_EXHAUST_GAS_TEMP_DEV_CYL: 260,
    LOW_FO_PRESSURE_ENGINE_INLET: 270,
    LOW_INSTRUMENT_AIR_PRESSURE: 280,
    LOW_MFI_IN_CYL: 290,
    LOW_PILOT_FUEL_PRESSURE_PUMP_OUTLET: 300,
    LOW_PILOT_FUEL_PRESSURE_INLET: 310,
    OIL_MIST_DETECTOR_SHUTDOWN: 320,
    PF_FILTER_DIFF_PRESS_HIGH: 330,
    PF_PRESSURE_SWING: 340,
    PILOT_FUEL_PRESS_REF_DEV: 350,
    SAFETY_WIRE_LOOP: 360,
    SF_EXHAUST_GAS_TEMP_CYL: 370,
    SF_KNOCK_IN_CYL: 380,
    SF_PILOT_FUEL_PRESSURE_PUMP_OUTLET: 390,
    SF_ENGINE_LOAD_FEEDBACK: 400,
    SF_ENGINE_SPEED: 410,
    SPEED_LIMITATION: 420,
    TRIP_WITHOUT_ALARM: 430,
    VOLTAGE_LIMITED_TO2DOT2KV: 440,
    WECS_HW_SHUTDOWN_SIGNAL_FOR_THE_PLC: 450
  }

  enum light_fuel_oil_consumption_type: {
    LFO_CONSUMPTION_NONE: 0,
    PILOT_FUEL: 10,
    DURING_ENGINE_TRIP: 20,
    MAINTENANCE_PURPOSES_WITH_GENERATION: 30,
    MAINTENANCE_PURPOSES_WITHOUT_GENERATION: 40,
    GRID_DEMAND_OR_NETWORK_FAULT: 50,
    STARTING_DISTURBANCES_WITHOUT_GENERATION: 60,
    GAS_SUPPLY_FAILURE: 70
  }

  before_validation do
    CALCULATED_FIELD_NAMES.each do |calculated_field_name|
      result = self.send("calculated_#{calculated_field_name}")
      self.send("#{calculated_field_name}=", result)
    end
  end

  validates :target_ending_datetime, presence: true
  validates :equipment, presence: true
  validates :bank, presence: true
  validates :cylinder, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 9
    }
  }
  validates :alarm, presence: true
  validates :type, presence: true
  validates :context, presence: true
  validates :owner, presence: true
  validates :light_fuel_oil_consumption_type, presence: true
  validates :power_generated_during_light_fuel_oil_consumption, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 9999 # TODO: figure out this
    }
  }
  validates :mean_load, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 20
    }
  }

  private

  def calculated_duration_in_hours
    return unless target_datetime
    return unless target_ending_datetime
    (target_ending_datetime.to_datetime - target_datetime.to_datetime).to_f * 24
  end

  def calculated_power_generated_during_light_fuel_oil_consumption
    return unless duration_in_hours
    return unless mean_load
    duration_in_hours * mean_load
  end
end

