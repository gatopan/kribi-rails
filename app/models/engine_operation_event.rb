class EngineOperationEvent < AbstractEventModel
  self.inheritance_column = nil
  PARENT_MODEL = Engine
  CUSTOM_NAME = nil
  EXPORTER_CONFIG = {
    match_key_types_fragments: [
      :type,
      :context
    ],
    mappings: [
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
    'energy_in_mwh',
    'light_fuel_oil_without_generation_in_kg',
    'light_fuel_oil_with_generation_in_kg',
    'failed_start_due_to_pilot_trip_ocurrence'
  ]

  before_validation do
    CALCULATED_FIELD_NAMES.each do |calculated_field_name|
      result = self.send("calculated_#{calculated_field_name}")
      self.send("#{calculated_field_name}=", result)
    end
  end

  abstract_bootloader()

  enum type: {
    TYPE_NONE: 0,
    DM_RUNNING_IN_DIESEL_MODE: 10,
    GT_GAS_TRIP: 20,
    PT_PILOT_TRIP: 30,
    FS_FAILED_START: 40,
    SD_SHUT_DOWN: 50,
    SS_SUCCESSFUL_START: 60
  }

  enum subtype: {
    SUBTYPE_NONE: 0,
    GT_Gen_prot_reserve_power: 1010,
    GT_Generator_breaker_status_NO: 1020,
    GT_High_exhaust_gas_temp_cylinder: 1030,
    GT_High_FO_temp_engine_inlet: 1040,
    GT_High_inlet_gas_pressure: 1050,
    GT_High_knock_in_cylinders: 1060,
    GT_high_main_gas_press_buildup_time_elapsed: 1070,
    GT_High_main_gas_press_dev_from_ref: 1080,
    GT_High_PF_temp_inlet: 1090,
    GT_Idle_max_time_reached: 1100,
    GT_Idle_max_time_reached_turbine_washing: 1110,
    GT_LEGTD_at_low_load: 1120,
    GT_LEGTD_CCM: 1130,
    GT_LEGTD_electrical_connection: 1140,
    GT_LEGTD_exhaust_gas_temp_sensor: 1150,
    GT_LEGTD_gas_valve: 1160,
    GT_LEGTD_injection_valve: 1170,
    GT_LEGTD_injection_pump: 1180,
    GT_LEGTD_knocking_sensor: 1190,
    GT_LEGTD_turbine_washing: 1200,
    GT_LEGTD_others: 1210,
    GT_Load_swing: 1220,
    GT_Low_FO_pressure_engine_inlet: 1230,
    GT_Low_instrument_air_pressure: 1240,
    GT_Low_MFI_in_cylinders: 1250,
    GT_SF_exhaust_gas_temp_in_cylinders: 1260,
    GT_SF_knock_in_Cylinder: 1270,
    GT_SF_engine_load_feedback: 1280,
    GT_without_alarm: 1290,
    GT_Other: 1999,
    PT_Low_drive_Supply_Voltage: 2010,
    PT_LEGT_in_cyl: 2020,
    PT_Low_PF_pressure_pump_outlet: 2030,
    PT_Low_PF_pressure__inlet: 2040,
    PT_No_combustion_in_some_cylinders: 2050,
    PT_PF_filter_diff_press_high: 2060,
    PT_PF_pressure_swing: 2070,
    PT_PF_press_ref_dev: 2080,
    PT_Safety_wire_loop: 2090,
    PT_SF_PF_pressure_pump_outlet: 2100,
    PT_Without_alarm: 2110,
    PT_Other: 2999,
    FS_Breaker_trip: 3010,
    FS_Boost_unsuccessful: 3020,
    FS_E_EMG_SF_speed_signal_missing: 3030,
    FS_Emergency_stop: 3040,
    FS_PT_High_PF_pressure_pump_outlet: 3050,
    FS_PT_LEGTD_in_cylinders: 3060,
    FS_PT_Low_PF_pressure_pump_outlet: 3070,
    FS_PT_Low_PF_pressure__inlet: 3080,
    FS_PT_PF_press_ref_dev: 3090,
    FS_PT_PF_pressure_swing: 3100,
    FS_PT_Safety_wire_loop: 3110,
    FS_PT_without_alarm: 3120,
    FS_SF_engine_speed: 3130,
    FS_SF_PF_pressure_pump_outlet: 3140,
    FS_SD_Low_PF_pressure__inlet: 3150,
    FS_SD_engine_speed_dev_from_ref: 3160,
    FS_SD_external_shutdown_status: 3170,
    FS_SD_LO_pressure_status__engine_inlet: 3180,
    FS_SD_nominal_speed_not_reached: 3190,
    FS_SD_Oil_mist_Detector_Shutdown: 3200,
    FS_SD_Overspeed: 3210,
    FS_SD_Torsional_vibration_level: 3220,
    FS_SD_without_alarm: 3230,
    FS_Speed_signal_missing: 3240,
    FS_Voltage_limited_to_2_2kV: 3250,
    FS_Other: 3999,
    SD_CA_press__engine_inlet: 4010,
    SD_CA_temp__engine_inlet: 4020,
    SD_Distributed_I_O_comm_fault_pipe_module: 4030,
    SD_E_EMG_Mechanical_overspeed_shutdown: 4040,
    SD_Engine_speed_dev_from_ref: 4050,
    SD_Fuse_trip: 4060,
    SD_FO_press_pump_inlet: 4070,
    SD_High_crankcase_press: 4080,
    SD_High_exhaust_gas_temp_in_cylinders: 4090,
    SD_Exhaust_gas_temp_Turbo_Charger_inlet: 4100,
    SD_Exhaust_gas_temp_Turbo_Charger_outlet: 4110,
    SD_High_knock_in_cylinder: 4120,
    SD_High_liner_temp_in_cyl: 4130,
    SD_High_main_bearing_temp: 4140,
    SD_HT_water_temp_shutdown_status: 4150,
    SD_Low_PF_pressure_inlet: 4160,
    SD_Mechanical_overspeed_released: 4170,
    SD_Oil_mist_Detector_Shutdown: 4180,
    SD_Overfrequency: 4190,
    SD_Overvoltage: 4200,
    SD_Overspeed: 4210,
    SD_Stop_level_in_stop_position: 4220,
    SD_Torsional_vibration_level: 4230,
    SD_underfrequency: 4240,
    SD_WECS_HW_shutdown_signal_for_the_PLC: 4250,
    SD_without_alarm: 4260,
    SD_other: 4999,
    SS_Sucessful_start: 5000,
    DM_Start_in_diesel_mode: 6010,
    DM_Switch_manually_in_diesel_mode: 6020,
    DM_Stoppage_in_diesel_mode: 6030,
    DM_Other: 6999
  }

  enum bank: {
    BANK_N_A: 0,
    BANK_A: 10,
    BANK_B: 20
  }

  enum cylinder: {
    'CYLINDER_N_A' => 0,
    '1' => 1,
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9
  }

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
    INJECTiION_VALVE: 110,
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
    TURBO_CHARGER: 220,
    WASTE_GATE: 230
  }

  enum context: {
    CONTEXT_NONE: 0,
    STARTING_PHASE: 10,
    STOPPING_PHASE: 20,
    RAMPING_UP: 30,
    NORMAL_OPERATION: 40,
    TURBINE_WASHING: 50,
    COMPRESSOR_WASHING: 60,
    NETWORK_DISTURBANCES: 70,
    SNH_FAILURE: 80
  }

  enum owner: {
    OWNER_NONE: 0,
    OPERATION: 10,
    MAINTENANCE: 20,
    GRID_DEMAND_OR_FAILURE: 30,
    OWNER_SNH_FAILURE: 40
  }

  validates :type, presence: true
  validates :subtype, presence: true
  validates :bank, presence: true
  validates :cylinder, presence: true
  validates :equipment, presence: true
  validates :context, presence: true
  validates :ocurrence, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 10
    }
  }
  validates :owner, presence: true

  validate :end_time_of_trip_congruence

  def end_time_of_trip_congruence
    return unless target_datetime
    return unless end_time_of_trip

    target_datetime_minutes = (target_datetime.hour * 60) + target_datetime.min
    end_time_of_trip_minutes = (end_time_of_trip.hour * 60) + end_time_of_trip.min

    unless end_time_of_trip_minutes >= target_datetime_minutes
      errors.add :end_time_of_trip, 'must be greater of equal to target datetime'
    end
  end

  validate :end_time_without_generation_congruence

  def end_time_without_generation_congruence
    return unless target_datetime
    return unless end_time_of_trip
    return unless end_time_without_generation

    target_datetime_minutes = (target_datetime.hour * 60) + target_datetime.min
    end_time_of_trip_minutes = (end_time_of_trip.hour * 60) + end_time_of_trip.min
    end_time_without_generation_minutes = (end_time_without_generation.hour * 60) + end_time_without_generation.min

    if end_time_without_generation_minutes <= target_datetime_minutes
      errors.add :end_time_without_generation, 'must be greater or equal to target datetime'
    end

    if end_time_without_generation_minutes >= end_time_of_trip_minutes
      errors.add :end_time_without_generation, 'must be less or equal to end time of trip'
    end
  end

  validates :mean_load, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 16.621
    }
  }

  validate :type_and_subtype_congruence

  def type_and_subtype_congruence
    return unless type
    return unless subtype

    type_prefix     = (self.type == 'TYPE_NONE') ? 'NONE' : self.type.split('_').first
    subtype_prefix  = (self.subtype == 'SUBTYPE_NONE') ? 'NONE' : self.subtype.split('_').first

    unless (type_prefix == subtype_prefix)
      errors.add :base, 'Type and Subtype prefix must match'
    end
  end

  #TODO: formula
  def calculated_duration_in_hours
    1
  end

  #TODO: formula
  def calculated_energy_in_mwh
    1
  end

  #TODO: confirm formula as changed from rough estimato to _without_
  def calculated_light_fuel_oil_without_generation_in_kg
    1
  end

  #TODO: confirm formula as changed from rough estimato to _with_
  def calculated_light_fuel_oil_with_generation_in_kg
    1
  end

  #TODO: formula
  def calculated_failed_start_due_to_pilot_trip_ocurrence
    1
  end
end
