# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160207213622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chromatograph_readings", force: :cascade do |t|
    t.integer  "chromatograph_id"
    t.datetime "target_datetime"
    t.float    "un_norm_total",              default: 0.001
    t.float    "higher_heating_value",       default: 0.001
    t.float    "lower_heating_value",        default: 0.001
    t.float    "specific_gravity",           default: 0.001
    t.float    "compressibility",            default: 0.001
    t.float    "propane",                    default: 0.001
    t.float    "isobutane",                  default: 0.001
    t.float    "normal_butane",              default: 0.0
    t.float    "neopentane",                 default: 0.001
    t.float    "isopentane",                 default: 0.0
    t.float    "normal_pentane",             default: 0.0
    t.float    "hexane_and_more",            default: 0.0
    t.float    "nitrogen",                   default: 0.001
    t.float    "methane",                    default: 0.001
    t.float    "carbon_dioxide",             default: 0.001
    t.float    "ethane",                     default: 0.001
    t.float    "grouped_pentane"
    t.float    "grouped_butane"
    t.float    "corrected_methane"
    t.float    "corrected_butane"
    t.float    "methane_number",             default: 0.0
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "chromatograph_readings", ["chromatograph_id"], name: "index_chromatograph_readings_on_chromatograph_id", using: :btree
  add_index "chromatograph_readings", ["match_key_customer_monthly"], name: "index_chromatograph_readings_on_match_key_customer_monthly", using: :btree
  add_index "chromatograph_readings", ["match_key_standard_daily"], name: "index_chromatograph_readings_on_match_key_standard_daily", using: :btree
  add_index "chromatograph_readings", ["match_key_standard_monthly"], name: "index_chromatograph_readings_on_match_key_standard_monthly", using: :btree
  add_index "chromatograph_readings", ["match_key_standard_quarter"], name: "index_chromatograph_readings_on_match_key_standard_quarter", using: :btree
  add_index "chromatograph_readings", ["match_key_standard_weekly"], name: "index_chromatograph_readings_on_match_key_standard_weekly", using: :btree
  add_index "chromatograph_readings", ["match_key_standard_yearly"], name: "index_chromatograph_readings_on_match_key_standard_yearly", using: :btree

  create_table "chromatographs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "engine_cooling_water_dispensing_events", force: :cascade do |t|
    t.integer  "engine_id"
    t.datetime "target_datetime"
    t.integer  "quantity_in_liters",         default: 0
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "engine_cooling_water_dispensing_events", ["engine_id"], name: "index_engine_cooling_water_dispensing_events_on_engine_id", using: :btree
  add_index "engine_cooling_water_dispensing_events", ["match_key_customer_monthly"], name: "index_engine_water_disp_event_mk_customer_monthly", using: :btree
  add_index "engine_cooling_water_dispensing_events", ["match_key_standard_daily"], name: "index_engine_water_disp_event_mk_standard_daily", using: :btree
  add_index "engine_cooling_water_dispensing_events", ["match_key_standard_monthly"], name: "index_engine_water_disp_event_mk_standard_monthly", using: :btree
  add_index "engine_cooling_water_dispensing_events", ["match_key_standard_quarter"], name: "index_engine_water_disp_event_mk_standard_quarter", using: :btree
  add_index "engine_cooling_water_dispensing_events", ["match_key_standard_weekly"], name: "index_engine_water_disp_event_mk_standard_weekly", using: :btree
  add_index "engine_cooling_water_dispensing_events", ["match_key_standard_yearly"], name: "index_engine_water_disp_event_mk_standard_yearly", using: :btree

  create_table "engine_emission_readings", force: :cascade do |t|
    t.integer  "engine_id"
    t.datetime "target_datetime"
    t.float    "nitrogen_oxides_in_gas_mode",                 default: 0.0
    t.integer  "nitrogen_oxides_in_gas_mode_code",            default: 0
    t.float    "nitrogen_oxides_in_light_fuel_oil_mode",      default: 0.0
    t.integer  "nitrogen_oxides_in_light_fuel_oil_mode_code", default: 0
    t.float    "dioxygen",                                    default: 0.0
    t.integer  "dioxygen_code",                               default: 0
    t.integer  "status",                                      default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  add_index "engine_emission_readings", ["engine_id"], name: "index_engine_emission_readings_on_engine_id", using: :btree
  add_index "engine_emission_readings", ["match_key_customer_monthly"], name: "index_engine_emission_readings_on_match_key_customer_monthly", using: :btree
  add_index "engine_emission_readings", ["match_key_standard_daily"], name: "index_engine_emission_readings_on_match_key_standard_daily", using: :btree
  add_index "engine_emission_readings", ["match_key_standard_monthly"], name: "index_engine_emission_readings_on_match_key_standard_monthly", using: :btree
  add_index "engine_emission_readings", ["match_key_standard_quarter"], name: "index_engine_emission_readings_on_match_key_standard_quarter", using: :btree
  add_index "engine_emission_readings", ["match_key_standard_weekly"], name: "index_engine_emission_readings_on_match_key_standard_weekly", using: :btree
  add_index "engine_emission_readings", ["match_key_standard_yearly"], name: "index_engine_emission_readings_on_match_key_standard_yearly", using: :btree

  create_table "engine_energy_readings", force: :cascade do |t|
    t.integer  "engine_id"
    t.datetime "target_datetime"
    t.float    "counter_value",              default: 0.0
    t.float    "real_value",                 default: 0.0
    t.float    "counter_offset",             default: 0.0
    t.float    "energy_volume",              default: 0.0
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "engine_energy_readings", ["counter_offset"], name: "index_engine_energy_readings_counter_offset", using: :btree
  add_index "engine_energy_readings", ["counter_value"], name: "index_engine_energy_readings_counter_value", using: :btree
  add_index "engine_energy_readings", ["energy_volume"], name: "index_engine_energy_readings_on_energy_volume", using: :btree
  add_index "engine_energy_readings", ["engine_id"], name: "index_engine_energy_readings_on_engine_id", using: :btree
  add_index "engine_energy_readings", ["match_key_customer_monthly"], name: "index_engine_energy_readings_on_match_key_customer_monthly", using: :btree
  add_index "engine_energy_readings", ["match_key_standard_daily"], name: "index_engine_energy_readings_on_match_key_standard_daily", using: :btree
  add_index "engine_energy_readings", ["match_key_standard_monthly"], name: "index_engine_energy_readings_on_match_key_standard_monthly", using: :btree
  add_index "engine_energy_readings", ["match_key_standard_quarter"], name: "index_engine_energy_readings_on_match_key_standard_quarter", using: :btree
  add_index "engine_energy_readings", ["match_key_standard_weekly"], name: "index_engine_energy_readings_on_match_key_standard_weekly", using: :btree
  add_index "engine_energy_readings", ["match_key_standard_yearly"], name: "index_engine_energy_readings_on_match_key_standard_yearly", using: :btree
  add_index "engine_energy_readings", ["real_value"], name: "index_engine_energy_readings_real_value", using: :btree

  create_table "engine_gas_readings", force: :cascade do |t|
    t.integer  "engine_id"
    t.datetime "target_datetime"
    t.float    "counter_value",              default: 0.0
    t.float    "real_value",                 default: 0.0
    t.float    "counter_offset",             default: 0.0
    t.integer  "gas_volume"
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "engine_gas_readings", ["counter_offset"], name: "index_engine_gas_readings_counter_offset", using: :btree
  add_index "engine_gas_readings", ["counter_value"], name: "index_engine_gas_readings_counter_value", using: :btree
  add_index "engine_gas_readings", ["engine_id"], name: "index_engine_gas_readings_on_engine_id", using: :btree
  add_index "engine_gas_readings", ["match_key_customer_monthly"], name: "index_engine_gas_readings_on_match_key_customer_monthly", using: :btree
  add_index "engine_gas_readings", ["match_key_standard_daily"], name: "index_engine_gas_readings_on_match_key_standard_daily", using: :btree
  add_index "engine_gas_readings", ["match_key_standard_monthly"], name: "index_engine_gas_readings_on_match_key_standard_monthly", using: :btree
  add_index "engine_gas_readings", ["match_key_standard_quarter"], name: "index_engine_gas_readings_on_match_key_standard_quarter", using: :btree
  add_index "engine_gas_readings", ["match_key_standard_weekly"], name: "index_engine_gas_readings_on_match_key_standard_weekly", using: :btree
  add_index "engine_gas_readings", ["match_key_standard_yearly"], name: "index_engine_gas_readings_on_match_key_standard_yearly", using: :btree
  add_index "engine_gas_readings", ["real_value"], name: "index_engine_gas_readings_real_value", using: :btree

  create_table "engine_light_fuel_oil_readings", force: :cascade do |t|
    t.integer  "engine_id"
    t.datetime "target_datetime"
    t.float    "inlet_counter_value",        default: 0.0
    t.float    "inlet_real_value",           default: 0.0
    t.float    "inlet_counter_offset",       default: 0.0
    t.float    "inlet_volume"
    t.float    "outlet_counter_value",       default: 0.0
    t.float    "outlet_real_value",          default: 0.0
    t.float    "outlet_counter_offset",      default: 0.0
    t.float    "outlet_volume"
    t.float    "consumption"
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "engine_light_fuel_oil_readings", ["engine_id"], name: "index_engine_light_fuel_oil_readings_on_engine_id", using: :btree
  add_index "engine_light_fuel_oil_readings", ["inlet_counter_offset"], name: "index_engine_light_fuel_oil_readings_inlet_counter_offset", using: :btree
  add_index "engine_light_fuel_oil_readings", ["inlet_counter_value"], name: "index_engine_light_fuel_oil_readings_inlet_counter_value", using: :btree
  add_index "engine_light_fuel_oil_readings", ["inlet_real_value"], name: "index_engine_light_fuel_oil_readings_inlet_real_value", using: :btree
  add_index "engine_light_fuel_oil_readings", ["match_key_customer_monthly"], name: "index_engine_lfo_reading_match_key_customer_monthly", using: :btree
  add_index "engine_light_fuel_oil_readings", ["match_key_standard_daily"], name: "index_engine_lfo_reading_match_key_standard_daily", using: :btree
  add_index "engine_light_fuel_oil_readings", ["match_key_standard_monthly"], name: "index_engine_lfo_reading_match_key_standard_monthly", using: :btree
  add_index "engine_light_fuel_oil_readings", ["match_key_standard_quarter"], name: "index_engine_lfo_reading_match_key_standard_quarter", using: :btree
  add_index "engine_light_fuel_oil_readings", ["match_key_standard_weekly"], name: "index_engine_lfo_reading_match_key_standard_weekly", using: :btree
  add_index "engine_light_fuel_oil_readings", ["match_key_standard_yearly"], name: "index_engine_lfo_reading_match_key_standard_yearly", using: :btree
  add_index "engine_light_fuel_oil_readings", ["outlet_counter_offset"], name: "index_engine_light_fuel_oil_readings_outlet_counter_offset", using: :btree
  add_index "engine_light_fuel_oil_readings", ["outlet_counter_value"], name: "index_engine_light_fuel_oil_readings_outlet_counter_value", using: :btree
  add_index "engine_light_fuel_oil_readings", ["outlet_real_value"], name: "index_engine_light_fuel_oil_readings_outlet_real_value", using: :btree

  create_table "engine_running_time_readings", force: :cascade do |t|
    t.integer  "engine_id"
    t.datetime "target_datetime"
    t.float    "counter_value",              default: 0.0
    t.float    "real_value",                 default: 0.0
    t.float    "counter_offset",             default: 0.0
    t.integer  "elapsed_hours"
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "engine_running_time_readings", ["counter_offset"], name: "index_engine_running_time_readings_counter_offset", using: :btree
  add_index "engine_running_time_readings", ["counter_value"], name: "index_engine_running_time_readings_counter_value", using: :btree
  add_index "engine_running_time_readings", ["engine_id"], name: "index_engine_running_time_readings_on_engine_id", using: :btree
  add_index "engine_running_time_readings", ["match_key_customer_monthly"], name: "index_engine_running_time_readings_mk_customer_monthly", using: :btree
  add_index "engine_running_time_readings", ["match_key_standard_daily"], name: "index_engine_running_time_readings_mk_standard_daily", using: :btree
  add_index "engine_running_time_readings", ["match_key_standard_monthly"], name: "index_engine_running_time_readings_mk_standard_monthly", using: :btree
  add_index "engine_running_time_readings", ["match_key_standard_quarter"], name: "index_engine_running_time_readings_mk_standard_quarter", using: :btree
  add_index "engine_running_time_readings", ["match_key_standard_weekly"], name: "index_engine_running_time_readings_mk_standard_weekly", using: :btree
  add_index "engine_running_time_readings", ["match_key_standard_yearly"], name: "index_engine_running_time_readings_mk_standard_yearly", using: :btree
  add_index "engine_running_time_readings", ["real_value"], name: "index_engine_running_time_readings_real_value", using: :btree

  create_table "engine_start_events", force: :cascade do |t|
    t.integer  "engine_id"
    t.datetime "target_datetime"
    t.integer  "bank"
    t.integer  "result"
    t.integer  "equipment"
    t.integer  "cylinder"
    t.integer  "alarm"
    t.text     "observations"
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "engine_start_events", ["engine_id"], name: "index_engine_start_events_on_engine_id", using: :btree
  add_index "engine_start_events", ["match_key_customer_monthly"], name: "index_engine_start_events_on_match_key_customer_monthly", using: :btree
  add_index "engine_start_events", ["match_key_standard_daily"], name: "index_engine_start_events_on_match_key_standard_daily", using: :btree
  add_index "engine_start_events", ["match_key_standard_monthly"], name: "index_engine_start_events_on_match_key_standard_monthly", using: :btree
  add_index "engine_start_events", ["match_key_standard_quarter"], name: "index_engine_start_events_on_match_key_standard_quarter", using: :btree
  add_index "engine_start_events", ["match_key_standard_weekly"], name: "index_engine_start_events_on_match_key_standard_weekly", using: :btree
  add_index "engine_start_events", ["match_key_standard_yearly"], name: "index_engine_start_events_on_match_key_standard_yearly", using: :btree

  create_table "engine_status_change_events", force: :cascade do |t|
    t.integer  "engine_id"
    t.datetime "target_datetime"
    t.float    "duration_in_hours"
    t.integer  "type",                       default: 0
    t.integer  "engine_mode",                default: 0
    t.integer  "derating_mode",              default: 0
    t.float    "load_limitation",            default: 0.0
    t.integer  "resolution_department",      default: 0
    t.text     "outage_description"
    t.text     "other_description"
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "engine_status_change_events", ["engine_id"], name: "index_engine_status_change_events_on_engine_id", using: :btree
  add_index "engine_status_change_events", ["match_key_customer_monthly"], name: "index_engine_status_change_events_on_match_key_customer_monthly", using: :btree
  add_index "engine_status_change_events", ["match_key_standard_daily"], name: "index_engine_status_change_events_on_match_key_standard_daily", using: :btree
  add_index "engine_status_change_events", ["match_key_standard_monthly"], name: "index_engine_status_change_events_on_match_key_standard_monthly", using: :btree
  add_index "engine_status_change_events", ["match_key_standard_quarter"], name: "index_engine_status_change_events_on_match_key_standard_quarter", using: :btree
  add_index "engine_status_change_events", ["match_key_standard_weekly"], name: "index_engine_status_change_events_on_match_key_standard_weekly", using: :btree
  add_index "engine_status_change_events", ["match_key_standard_yearly"], name: "index_engine_status_change_events_on_match_key_standard_yearly", using: :btree

  create_table "engine_status_change_export_events", force: :cascade do |t|
    t.integer  "engine_id"
    t.datetime "target_datetime"
    t.float    "duration_in_hours"
    t.integer  "type",                       default: 0
    t.integer  "engine_mode",                default: 0
    t.integer  "derating_mode",              default: 0
    t.float    "load_limitation",            default: 0.0
    t.integer  "resolution_department",      default: 0
    t.text     "outage_description"
    t.text     "other_description"
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "engine_status_change_export_events", ["engine_id"], name: "index_engine_status_change_export_events_on_engine_id", using: :btree
  add_index "engine_status_change_export_events", ["match_key_customer_monthly"], name: "index_engine_stat_chng_evnt_mk_customer_monthly", using: :btree
  add_index "engine_status_change_export_events", ["match_key_standard_daily"], name: "index_engine_stat_chng_evnt_mk_standard_daily", using: :btree
  add_index "engine_status_change_export_events", ["match_key_standard_monthly"], name: "index_engine_stat_chng_evnt_mk_standard_monthly", using: :btree
  add_index "engine_status_change_export_events", ["match_key_standard_quarter"], name: "index_engine_stat_chng_evnt_mk_standard_quarter", using: :btree
  add_index "engine_status_change_export_events", ["match_key_standard_weekly"], name: "index_engine_stat_chng_evnt_mk_standard_weekly", using: :btree
  add_index "engine_status_change_export_events", ["match_key_standard_yearly"], name: "index_engine_stat_chng_evnt_mk_standard_yearly", using: :btree

  create_table "engine_trip_events", force: :cascade do |t|
    t.integer  "engine_id"
    t.integer  "equipment"
    t.integer  "bank"
    t.integer  "cylinder"
    t.integer  "alarm"
    t.integer  "type"
    t.integer  "context"
    t.integer  "owner"
    t.integer  "light_fuel_oil_consumption_type"
    t.float    "power_generated_during_light_fuel_oil_consumption"
    t.float    "mean_load",                                         default: 0.0
    t.text     "observations"
    t.datetime "target_datetime"
    t.datetime "target_ending_datetime"
    t.float    "duration_in_hours"
    t.integer  "status",                                            default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  add_index "engine_trip_events", ["engine_id"], name: "index_engine_trip_events_on_engine_id", using: :btree
  add_index "engine_trip_events", ["match_key_customer_monthly"], name: "index_engine_trip_events_on_match_key_customer_monthly", using: :btree
  add_index "engine_trip_events", ["match_key_standard_daily"], name: "index_engine_trip_events_on_match_key_standard_daily", using: :btree
  add_index "engine_trip_events", ["match_key_standard_monthly"], name: "index_engine_trip_events_on_match_key_standard_monthly", using: :btree
  add_index "engine_trip_events", ["match_key_standard_quarter"], name: "index_engine_trip_events_on_match_key_standard_quarter", using: :btree
  add_index "engine_trip_events", ["match_key_standard_weekly"], name: "index_engine_trip_events_on_match_key_standard_weekly", using: :btree
  add_index "engine_trip_events", ["match_key_standard_yearly"], name: "index_engine_trip_events_on_match_key_standard_yearly", using: :btree

  create_table "engine_trip_export_events", force: :cascade do |t|
    t.integer  "engine_id"
    t.integer  "equipment"
    t.integer  "bank"
    t.integer  "cylinder"
    t.integer  "alarm"
    t.integer  "type"
    t.integer  "context"
    t.integer  "owner"
    t.integer  "light_fuel_oil_consumption_type"
    t.float    "power_generated_during_light_fuel_oil_consumption"
    t.float    "mean_load",                                         default: 0.0
    t.text     "observations"
    t.datetime "target_datetime"
    t.datetime "target_ending_datetime"
    t.float    "duration_in_hours"
    t.integer  "status",                                            default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  add_index "engine_trip_export_events", ["engine_id"], name: "index_engine_trip_export_events_on_engine_id", using: :btree
  add_index "engine_trip_export_events", ["match_key_customer_monthly"], name: "index_engine_trip_export_events_on_match_key_customer_monthly", using: :btree
  add_index "engine_trip_export_events", ["match_key_standard_daily"], name: "index_engine_trip_export_events_on_match_key_standard_daily", using: :btree
  add_index "engine_trip_export_events", ["match_key_standard_monthly"], name: "index_engine_trip_export_events_on_match_key_standard_monthly", using: :btree
  add_index "engine_trip_export_events", ["match_key_standard_quarter"], name: "index_engine_trip_export_events_on_match_key_standard_quarter", using: :btree
  add_index "engine_trip_export_events", ["match_key_standard_weekly"], name: "index_engine_trip_export_events_on_match_key_standard_weekly", using: :btree
  add_index "engine_trip_export_events", ["match_key_standard_yearly"], name: "index_engine_trip_export_events_on_match_key_standard_yearly", using: :btree

  create_table "engines", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feeder_readings", force: :cascade do |t|
    t.integer  "feeder_id"
    t.datetime "target_datetime"
    t.float    "transmitting_counter_value",  default: 0.0
    t.float    "transmitting_real_value",     default: 0.0
    t.float    "transmitting_counter_offset", default: 0.0
    t.float    "receiving_counter_value",     default: 0.0
    t.float    "receiving_real_value",        default: 0.0
    t.float    "receiving_counter_offset",    default: 0.0
    t.float    "transmitting_energy_volume"
    t.float    "receiving_energy_volume"
    t.integer  "status",                      default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "feeder_readings", ["feeder_id"], name: "index_feeder_readings_on_feeder_id", using: :btree
  add_index "feeder_readings", ["match_key_customer_monthly"], name: "index_feeder_readings_on_match_key_customer_monthly", using: :btree
  add_index "feeder_readings", ["match_key_standard_daily"], name: "index_feeder_readings_on_match_key_standard_daily", using: :btree
  add_index "feeder_readings", ["match_key_standard_monthly"], name: "index_feeder_readings_on_match_key_standard_monthly", using: :btree
  add_index "feeder_readings", ["match_key_standard_quarter"], name: "index_feeder_readings_on_match_key_standard_quarter", using: :btree
  add_index "feeder_readings", ["match_key_standard_weekly"], name: "index_feeder_readings_on_match_key_standard_weekly", using: :btree
  add_index "feeder_readings", ["match_key_standard_yearly"], name: "index_feeder_readings_on_match_key_standard_yearly", using: :btree
  add_index "feeder_readings", ["receiving_counter_offset"], name: "index_feeder_readings_receiving_counter_offset", using: :btree
  add_index "feeder_readings", ["receiving_counter_value"], name: "index_feeder_readings_receiving_counter_value", using: :btree
  add_index "feeder_readings", ["receiving_real_value"], name: "index_feeder_readings_receiving_real_value", using: :btree
  add_index "feeder_readings", ["transmitting_counter_offset"], name: "index_feeder_readings_transmitting_counter_offset", using: :btree
  add_index "feeder_readings", ["transmitting_counter_value"], name: "index_feeder_readings_transmitting_counter_value", using: :btree
  add_index "feeder_readings", ["transmitting_real_value"], name: "index_feeder_readings_transmitting_real_value", using: :btree

  create_table "feeders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gas_nomination_readings", force: :cascade do |t|
    t.integer  "gas_pressure_reducing_station_id"
    t.datetime "target_datetime"
    t.float    "nomination",                       default: 0.0
    t.float    "delivery",                         default: 0.0
    t.float    "high_heating_value",               default: 0.0
    t.integer  "quality"
    t.integer  "status",                           default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "gas_nomination_readings", ["gas_pressure_reducing_station_id"], name: "index_gprs_gas_nomination_readings", using: :btree
  add_index "gas_nomination_readings", ["match_key_customer_monthly"], name: "index_gas_nomination_readings_on_match_key_customer_monthly", using: :btree
  add_index "gas_nomination_readings", ["match_key_standard_daily"], name: "index_gas_nomination_readings_on_match_key_standard_daily", using: :btree
  add_index "gas_nomination_readings", ["match_key_standard_monthly"], name: "index_gas_nomination_readings_on_match_key_standard_monthly", using: :btree
  add_index "gas_nomination_readings", ["match_key_standard_quarter"], name: "index_gas_nomination_readings_on_match_key_standard_quarter", using: :btree
  add_index "gas_nomination_readings", ["match_key_standard_weekly"], name: "index_gas_nomination_readings_on_match_key_standard_weekly", using: :btree
  add_index "gas_nomination_readings", ["match_key_standard_yearly"], name: "index_gas_nomination_readings_on_match_key_standard_yearly", using: :btree

  create_table "gas_pressure_reducing_station_readings", force: :cascade do |t|
    t.integer  "gas_pressure_reducing_station_id"
    t.datetime "target_datetime"
    t.float    "counter_value",                    default: 0.0
    t.float    "real_value",                       default: 0.0
    t.float    "counter_offset",                   default: 0.0
    t.integer  "gas_volume"
    t.integer  "status",                           default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "gas_pressure_reducing_station_readings", ["counter_offset"], name: "index_gas_pressure_reducing_station_rea_counter_offset", using: :btree
  add_index "gas_pressure_reducing_station_readings", ["counter_value"], name: "index_gas_pressure_reducing_station_rea_counter_value", using: :btree
  add_index "gas_pressure_reducing_station_readings", ["gas_pressure_reducing_station_id"], name: "index_gprs_readings", using: :btree
  add_index "gas_pressure_reducing_station_readings", ["match_key_customer_monthly"], name: "index_gprs_match_key_customer_monthly", using: :btree
  add_index "gas_pressure_reducing_station_readings", ["match_key_standard_daily"], name: "index_gprs_match_key_standard_daily", using: :btree
  add_index "gas_pressure_reducing_station_readings", ["match_key_standard_monthly"], name: "index_gprs_match_key_standard_monthly", using: :btree
  add_index "gas_pressure_reducing_station_readings", ["match_key_standard_quarter"], name: "index_gprs_match_key_standard_quarter", using: :btree
  add_index "gas_pressure_reducing_station_readings", ["match_key_standard_weekly"], name: "index_gprs_match_key_standard_weekly", using: :btree
  add_index "gas_pressure_reducing_station_readings", ["match_key_standard_yearly"], name: "index_gprs_match_key_standard_yearly", using: :btree
  add_index "gas_pressure_reducing_station_readings", ["real_value"], name: "index_gas_pressure_reducing_station_rea_real_value", using: :btree

  create_table "gas_pressure_reducing_stations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "new_oil_tank_dispensing_events", force: :cascade do |t|
    t.integer  "new_oil_tank_id"
    t.integer  "engine_id"
    t.datetime "target_datetime"
    t.float    "counter_value",              default: 0.0
    t.float    "real_value",                 default: 0.0
    t.float    "counter_offset",             default: 0.0
    t.integer  "quantity_in_liters"
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "new_oil_tank_dispensing_events", ["counter_offset"], name: "index_new_oil_tank_dispensing_events_counter_offset", using: :btree
  add_index "new_oil_tank_dispensing_events", ["counter_value"], name: "index_new_oil_tank_dispensing_events_counter_value", using: :btree
  add_index "new_oil_tank_dispensing_events", ["engine_id"], name: "index_new_oil_tank_dispensing_events_on_engine_id", using: :btree
  add_index "new_oil_tank_dispensing_events", ["match_key_customer_monthly"], name: "index_new_oil_tank_disp_event_mk_customer_monthly", using: :btree
  add_index "new_oil_tank_dispensing_events", ["match_key_standard_daily"], name: "index_new_oil_tank_disp_event_mk_standard_daily", using: :btree
  add_index "new_oil_tank_dispensing_events", ["match_key_standard_monthly"], name: "index_new_oil_tank_disp_event_mk_standard_monthly", using: :btree
  add_index "new_oil_tank_dispensing_events", ["match_key_standard_quarter"], name: "index_new_oil_tank_disp_event_mk_standard_quarter", using: :btree
  add_index "new_oil_tank_dispensing_events", ["match_key_standard_weekly"], name: "index_new_oil_tank_disp_event_mk_standard_weekly", using: :btree
  add_index "new_oil_tank_dispensing_events", ["match_key_standard_yearly"], name: "index_new_oil_tank_disp_event_mk_standard_yearly", using: :btree
  add_index "new_oil_tank_dispensing_events", ["new_oil_tank_id"], name: "index_new_oil_tank_dispensing_events_on_new_oil_tank_id", using: :btree
  add_index "new_oil_tank_dispensing_events", ["real_value"], name: "index_new_oil_tank_dispensing_events_real_value", using: :btree

  create_table "new_oil_tank_receiving_events", force: :cascade do |t|
    t.integer  "new_oil_tank_id"
    t.datetime "target_datetime"
    t.float    "counter_value",              default: 0.0
    t.float    "real_value",                 default: 0.0
    t.float    "counter_offset",             default: 0.0
    t.integer  "quantity_in_liters"
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "new_oil_tank_receiving_events", ["counter_offset"], name: "index_new_oil_tank_receiving_events_counter_offset", using: :btree
  add_index "new_oil_tank_receiving_events", ["counter_value"], name: "index_new_oil_tank_receiving_events_counter_value", using: :btree
  add_index "new_oil_tank_receiving_events", ["match_key_customer_monthly"], name: "index_new_oil_tank_rece_event_mk_customer_monthly", using: :btree
  add_index "new_oil_tank_receiving_events", ["match_key_standard_daily"], name: "index_new_oil_tank_rece_event_mk_standard_daily", using: :btree
  add_index "new_oil_tank_receiving_events", ["match_key_standard_monthly"], name: "index_new_oil_tank_rece_event_mk_standard_monthly", using: :btree
  add_index "new_oil_tank_receiving_events", ["match_key_standard_quarter"], name: "index_new_oil_tank_rece_event_mk_standard_quarter", using: :btree
  add_index "new_oil_tank_receiving_events", ["match_key_standard_weekly"], name: "index_new_oil_tank_rece_event_mk_standard_weekly", using: :btree
  add_index "new_oil_tank_receiving_events", ["match_key_standard_yearly"], name: "index_new_oil_tank_rece_event_mk_standard_yearly", using: :btree
  add_index "new_oil_tank_receiving_events", ["new_oil_tank_id"], name: "index_new_oil_tank_receiving_events_on_new_oil_tank_id", using: :btree
  add_index "new_oil_tank_receiving_events", ["real_value"], name: "index_new_oil_tank_receiving_events_real_value", using: :btree

  create_table "new_oil_tanks", force: :cascade do |t|
    t.string   "name"
    t.integer  "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "role"
    t.string   "token"
    t.text     "biography"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "people", ["email"], name: "index_people_on_email", using: :btree
  add_index "people", ["first_name"], name: "index_people_on_first_name", using: :btree
  add_index "people", ["last_name"], name: "index_people_on_last_name", using: :btree
  add_index "people", ["password_digest"], name: "index_people_on_password_digest", using: :btree
  add_index "people", ["role"], name: "index_people_on_role", using: :btree
  add_index "people", ["token"], name: "index_people_on_token", using: :btree

  create_table "plant_declared_capacity_readings", force: :cascade do |t|
    t.integer  "plant_id"
    t.datetime "target_datetime"
    t.float    "capacity_at_actual_site_conditions",    default: 0.0
    t.float    "capacity_at_reference_site_conditions", default: 0.0
    t.float    "grid_demand",                           default: 0.0
    t.float    "equivalent_scheduled_outage_factor",    default: 0.0
    t.float    "equivalent_forced_outage_factor",       default: 0.0
    t.integer  "status",                                default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "plant_declared_capacity_readings", ["match_key_customer_monthly"], name: "index_plant_declared_capacity_mk_customer_monthly", using: :btree
  add_index "plant_declared_capacity_readings", ["match_key_standard_daily"], name: "index_plant_declared_capacity_mk_standard_daily", using: :btree
  add_index "plant_declared_capacity_readings", ["match_key_standard_monthly"], name: "index_plant_declared_capacity_mk_standard_monthly", using: :btree
  add_index "plant_declared_capacity_readings", ["match_key_standard_quarter"], name: "index_plant_declared_capacity_mk_standard_quarter", using: :btree
  add_index "plant_declared_capacity_readings", ["match_key_standard_weekly"], name: "index_plant_declared_capacity_mk_standard_weekly", using: :btree
  add_index "plant_declared_capacity_readings", ["match_key_standard_yearly"], name: "index_plant_declared_capacity_mk_standard_yearly", using: :btree
  add_index "plant_declared_capacity_readings", ["plant_id"], name: "index_plant_declared_capacity_readings_on_plant_id", using: :btree

  create_table "plant_gross_capacity_readings", force: :cascade do |t|
    t.integer  "plant_id"
    t.datetime "target_datetime"
    t.float    "output_capacity",            default: 0.0
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "plant_gross_capacity_readings", ["match_key_customer_monthly"], name: "index_plant_gross_capacity_mk_customer_monthly", using: :btree
  add_index "plant_gross_capacity_readings", ["match_key_standard_daily"], name: "index_plant_gross_capacity_mk_standard_daily", using: :btree
  add_index "plant_gross_capacity_readings", ["match_key_standard_monthly"], name: "index_plant_gross_capacity_mk_standard_monthly", using: :btree
  add_index "plant_gross_capacity_readings", ["match_key_standard_quarter"], name: "index_plant_gross_capacity_mk_standard_quarter", using: :btree
  add_index "plant_gross_capacity_readings", ["match_key_standard_weekly"], name: "index_plant_gross_capacity_mk_standard_weekly", using: :btree
  add_index "plant_gross_capacity_readings", ["match_key_standard_yearly"], name: "index_plant_gross_capacity_mk_standard_yearly", using: :btree
  add_index "plant_gross_capacity_readings", ["plant_id"], name: "index_plant_gross_capacity_readings_on_plant_id", using: :btree

  create_table "plant_light_fuel_oil_readings", force: :cascade do |t|
    t.integer  "plant_id"
    t.datetime "target_datetime"
    t.float    "inlet_hall_a_counter_value",  default: 0.0
    t.float    "inlet_hall_a_real_value",     default: 0.0
    t.float    "inlet_hall_a_counter_offset", default: 0.0
    t.float    "inlet_hall_a_liters"
    t.float    "inlet_hall_b_counter_value",  default: 0.0
    t.float    "inlet_hall_b_real_value",     default: 0.0
    t.float    "inlet_hall_b_counter_offset", default: 0.0
    t.float    "inlet_hall_b_liters"
    t.float    "outlet_counter_value",        default: 0.0
    t.float    "outlet_real_value",           default: 0.0
    t.float    "outlet_counter_offset",       default: 0.0
    t.float    "outlet_cubic_meters"
    t.float    "consumption_liters"
    t.integer  "status",                      default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "plant_light_fuel_oil_readings", ["inlet_hall_a_counter_offset"], name: "index_plant_light_fuel_oil_readings_inlet_hall_a_counter_offset", using: :btree
  add_index "plant_light_fuel_oil_readings", ["inlet_hall_a_counter_value"], name: "index_plant_light_fuel_oil_readings_inlet_hall_a_counter_value", using: :btree
  add_index "plant_light_fuel_oil_readings", ["inlet_hall_a_real_value"], name: "index_plant_light_fuel_oil_readings_inlet_hall_a_real_value", using: :btree
  add_index "plant_light_fuel_oil_readings", ["inlet_hall_b_counter_offset"], name: "index_plant_light_fuel_oil_readings_inlet_hall_b_counter_offset", using: :btree
  add_index "plant_light_fuel_oil_readings", ["inlet_hall_b_counter_value"], name: "index_plant_light_fuel_oil_readings_inlet_hall_b_counter_value", using: :btree
  add_index "plant_light_fuel_oil_readings", ["inlet_hall_b_real_value"], name: "index_plant_light_fuel_oil_readings_inlet_hall_b_real_value", using: :btree
  add_index "plant_light_fuel_oil_readings", ["match_key_customer_monthly"], name: "index_plant_lfo_reading_match_key_customer_monthly", using: :btree
  add_index "plant_light_fuel_oil_readings", ["match_key_standard_daily"], name: "index_plant_lfo_reading_match_key_standard_daily", using: :btree
  add_index "plant_light_fuel_oil_readings", ["match_key_standard_monthly"], name: "index_plant_lfo_reading_match_key_standard_monthly", using: :btree
  add_index "plant_light_fuel_oil_readings", ["match_key_standard_quarter"], name: "index_plant_lfo_reading_match_key_standard_quarter", using: :btree
  add_index "plant_light_fuel_oil_readings", ["match_key_standard_weekly"], name: "index_plant_lfo_reading_match_key_standard_weekly", using: :btree
  add_index "plant_light_fuel_oil_readings", ["match_key_standard_yearly"], name: "index_plant_lfo_reading_match_key_standard_yearly", using: :btree
  add_index "plant_light_fuel_oil_readings", ["outlet_counter_offset"], name: "index_plant_light_fuel_oil_readings_outlet_counter_offset", using: :btree
  add_index "plant_light_fuel_oil_readings", ["outlet_counter_value"], name: "index_plant_light_fuel_oil_readings_outlet_counter_value", using: :btree
  add_index "plant_light_fuel_oil_readings", ["outlet_real_value"], name: "index_plant_light_fuel_oil_readings_outlet_real_value", using: :btree
  add_index "plant_light_fuel_oil_readings", ["plant_id"], name: "index_plant_light_fuel_oil_readings_on_plant_id", using: :btree

  create_table "plant_reference_condition_readings", force: :cascade do |t|
    t.integer  "plant_id"
    t.datetime "target_datetime"
    t.float    "methane_number_at_actual_site_condition", default: 60.0
    t.integer  "status",                                  default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  add_index "plant_reference_condition_readings", ["match_key_customer_monthly"], name: "index_plant_reference_condition_mk_customer_monthly", using: :btree
  add_index "plant_reference_condition_readings", ["match_key_standard_daily"], name: "index_plant_reference_condition_mk_standard_daily", using: :btree
  add_index "plant_reference_condition_readings", ["match_key_standard_monthly"], name: "index_plant_reference_condition_mk_standard_monthly", using: :btree
  add_index "plant_reference_condition_readings", ["match_key_standard_quarter"], name: "index_plant_reference_condition_mk_standard_quarter", using: :btree
  add_index "plant_reference_condition_readings", ["match_key_standard_weekly"], name: "index_plant_reference_condition_mk_standard_weekly", using: :btree
  add_index "plant_reference_condition_readings", ["match_key_standard_yearly"], name: "index_plant_reference_condition_mk_standard_yearly", using: :btree
  add_index "plant_reference_condition_readings", ["plant_id"], name: "index_plant_reference_condition_readings_on_plant_id", using: :btree

  create_table "plants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_oil_tank_dispensing_events", force: :cascade do |t|
    t.integer  "service_oil_tank_id"
    t.integer  "engine_id"
    t.datetime "target_datetime"
    t.integer  "quantity_in_liters"
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "service_oil_tank_dispensing_events", ["engine_id"], name: "index_service_oil_tank_dispensing_events_on_engine_id", using: :btree
  add_index "service_oil_tank_dispensing_events", ["match_key_customer_monthly"], name: "index_service_oil_tank_disp_event_mk_customer_monthly", using: :btree
  add_index "service_oil_tank_dispensing_events", ["match_key_standard_daily"], name: "index_service_oil_tank_disp_event_mk_standard_daily", using: :btree
  add_index "service_oil_tank_dispensing_events", ["match_key_standard_monthly"], name: "index_service_oil_tank_disp_event_mk_standard_monthly", using: :btree
  add_index "service_oil_tank_dispensing_events", ["match_key_standard_quarter"], name: "index_service_oil_tank_disp_event_mk_standard_quarter", using: :btree
  add_index "service_oil_tank_dispensing_events", ["match_key_standard_weekly"], name: "index_service_oil_tank_disp_event_mk_standard_weekly", using: :btree
  add_index "service_oil_tank_dispensing_events", ["match_key_standard_yearly"], name: "index_service_oil_tank_disp_event_mk_standard_yearly", using: :btree
  add_index "service_oil_tank_dispensing_events", ["service_oil_tank_id"], name: "index_service_oil_tank_dispensing_events_on_service_oil_tank_id", using: :btree

  create_table "service_oil_tank_receiving_events", force: :cascade do |t|
    t.integer  "service_oil_tank_id"
    t.datetime "target_datetime"
    t.integer  "quantity_in_liters"
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "service_oil_tank_receiving_events", ["match_key_customer_monthly"], name: "index_service_oil_tank_rece_event_mk_customer_monthly", using: :btree
  add_index "service_oil_tank_receiving_events", ["match_key_standard_daily"], name: "index_service_oil_tank_rece_event_mk_standard_daily", using: :btree
  add_index "service_oil_tank_receiving_events", ["match_key_standard_monthly"], name: "index_service_oil_tank_rece_event_mk_standard_monthly", using: :btree
  add_index "service_oil_tank_receiving_events", ["match_key_standard_quarter"], name: "index_service_oil_tank_rece_event_mk_standard_quarter", using: :btree
  add_index "service_oil_tank_receiving_events", ["match_key_standard_weekly"], name: "index_service_oil_tank_rece_event_mk_standard_weekly", using: :btree
  add_index "service_oil_tank_receiving_events", ["match_key_standard_yearly"], name: "index_service_oil_tank_rece_event_mk_standard_yearly", using: :btree
  add_index "service_oil_tank_receiving_events", ["service_oil_tank_id"], name: "index_service_oil_tank_receiving_events_on_service_oil_tank_id", using: :btree

  create_table "service_oil_tanks", force: :cascade do |t|
    t.string   "name"
    t.integer  "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "substation_readings", force: :cascade do |t|
    t.integer  "substation_id"
    t.datetime "target_datetime"
    t.float    "counter_value",              default: 0.0
    t.float    "real_value",                 default: 0.0
    t.float    "counter_offset",             default: 0.0
    t.float    "energy_volume"
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "substation_readings", ["counter_offset"], name: "index_substation_readings_counter_offset", using: :btree
  add_index "substation_readings", ["counter_value"], name: "index_substation_readings_counter_value", using: :btree
  add_index "substation_readings", ["match_key_customer_monthly"], name: "index_substation_readings_on_match_key_customer_monthly", using: :btree
  add_index "substation_readings", ["match_key_standard_daily"], name: "index_substation_readings_on_match_key_standard_daily", using: :btree
  add_index "substation_readings", ["match_key_standard_monthly"], name: "index_substation_readings_on_match_key_standard_monthly", using: :btree
  add_index "substation_readings", ["match_key_standard_quarter"], name: "index_substation_readings_on_match_key_standard_quarter", using: :btree
  add_index "substation_readings", ["match_key_standard_weekly"], name: "index_substation_readings_on_match_key_standard_weekly", using: :btree
  add_index "substation_readings", ["match_key_standard_yearly"], name: "index_substation_readings_on_match_key_standard_yearly", using: :btree
  add_index "substation_readings", ["real_value"], name: "index_substation_readings_real_value", using: :btree
  add_index "substation_readings", ["substation_id"], name: "index_substation_readings_on_substation_id", using: :btree

  create_table "substations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transformer_readings", force: :cascade do |t|
    t.integer  "transformer_id"
    t.datetime "target_datetime"
    t.float    "transmitting_counter_value",  default: 0.0
    t.float    "transmitting_real_value",     default: 0.0
    t.float    "transmitting_counter_offset", default: 0.0
    t.float    "receiving_counter_value",     default: 0.0
    t.float    "receiving_real_value",        default: 0.0
    t.float    "receiving_counter_offset",    default: 0.0
    t.float    "transmitting_energy_volume"
    t.float    "receiving_energy_volume"
    t.integer  "status",                      default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "transformer_readings", ["match_key_customer_monthly"], name: "index_transformer_readings_on_match_key_customer_monthly", using: :btree
  add_index "transformer_readings", ["match_key_standard_daily"], name: "index_transformer_readings_on_match_key_standard_daily", using: :btree
  add_index "transformer_readings", ["match_key_standard_monthly"], name: "index_transformer_readings_on_match_key_standard_monthly", using: :btree
  add_index "transformer_readings", ["match_key_standard_quarter"], name: "index_transformer_readings_on_match_key_standard_quarter", using: :btree
  add_index "transformer_readings", ["match_key_standard_weekly"], name: "index_transformer_readings_on_match_key_standard_weekly", using: :btree
  add_index "transformer_readings", ["match_key_standard_yearly"], name: "index_transformer_readings_on_match_key_standard_yearly", using: :btree
  add_index "transformer_readings", ["receiving_counter_offset"], name: "index_transformer_readings_receiving_counter_offset", using: :btree
  add_index "transformer_readings", ["receiving_counter_value"], name: "index_transformer_readings_receiving_counter_value", using: :btree
  add_index "transformer_readings", ["receiving_real_value"], name: "index_transformer_readings_receiving_real_value", using: :btree
  add_index "transformer_readings", ["transformer_id"], name: "index_transformer_readings_on_transformer_id", using: :btree
  add_index "transformer_readings", ["transmitting_counter_offset"], name: "index_transformer_readings_transmitting_counter_offset", using: :btree
  add_index "transformer_readings", ["transmitting_counter_value"], name: "index_transformer_readings_transmitting_counter_value", using: :btree
  add_index "transformer_readings", ["transmitting_real_value"], name: "index_transformer_readings_transmitting_real_value", using: :btree

  create_table "transformers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weather_readings", force: :cascade do |t|
    t.integer  "weather_station_id"
    t.datetime "target_datetime"
    t.float    "ambient_temperature",        default: 0.0
    t.float    "absolute_humidity",          default: 0.0
    t.float    "relative_humidity",          default: 0.0
    t.integer  "status",                     default: 0
    t.string   "match_key_standard_daily"
    t.string   "match_key_standard_weekly"
    t.string   "match_key_standard_monthly"
    t.string   "match_key_standard_quarter"
    t.string   "match_key_standard_yearly"
    t.string   "match_key_customer_monthly"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "weather_readings", ["match_key_customer_monthly"], name: "index_weather_readings_on_match_key_customer_monthly", using: :btree
  add_index "weather_readings", ["match_key_standard_daily"], name: "index_weather_readings_on_match_key_standard_daily", using: :btree
  add_index "weather_readings", ["match_key_standard_monthly"], name: "index_weather_readings_on_match_key_standard_monthly", using: :btree
  add_index "weather_readings", ["match_key_standard_quarter"], name: "index_weather_readings_on_match_key_standard_quarter", using: :btree
  add_index "weather_readings", ["match_key_standard_weekly"], name: "index_weather_readings_on_match_key_standard_weekly", using: :btree
  add_index "weather_readings", ["match_key_standard_yearly"], name: "index_weather_readings_on_match_key_standard_yearly", using: :btree
  add_index "weather_readings", ["weather_station_id"], name: "index_weather_readings_on_weather_station_id", using: :btree

  create_table "weather_stations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "chromatograph_readings", "chromatographs"
  add_foreign_key "engine_cooling_water_dispensing_events", "engines"
  add_foreign_key "engine_emission_readings", "engines"
  add_foreign_key "engine_energy_readings", "engines"
  add_foreign_key "engine_gas_readings", "engines"
  add_foreign_key "engine_light_fuel_oil_readings", "engines"
  add_foreign_key "engine_running_time_readings", "engines"
  add_foreign_key "engine_start_events", "engines"
  add_foreign_key "engine_status_change_events", "engines"
  add_foreign_key "engine_status_change_export_events", "engines"
  add_foreign_key "engine_trip_events", "engines"
  add_foreign_key "engine_trip_export_events", "engines"
  add_foreign_key "feeder_readings", "feeders"
  add_foreign_key "gas_nomination_readings", "gas_pressure_reducing_stations"
  add_foreign_key "gas_pressure_reducing_station_readings", "gas_pressure_reducing_stations"
  add_foreign_key "new_oil_tank_dispensing_events", "engines"
  add_foreign_key "new_oil_tank_dispensing_events", "new_oil_tanks"
  add_foreign_key "new_oil_tank_receiving_events", "new_oil_tanks"
  add_foreign_key "plant_declared_capacity_readings", "plants"
  add_foreign_key "plant_gross_capacity_readings", "plants"
  add_foreign_key "plant_light_fuel_oil_readings", "plants"
  add_foreign_key "plant_reference_condition_readings", "plants"
  add_foreign_key "service_oil_tank_dispensing_events", "engines"
  add_foreign_key "service_oil_tank_dispensing_events", "service_oil_tanks"
  add_foreign_key "service_oil_tank_receiving_events", "service_oil_tanks"
  add_foreign_key "substation_readings", "substations"
  add_foreign_key "transformer_readings", "transformers"
  add_foreign_key "weather_readings", "weather_stations"
end
