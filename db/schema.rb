# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_29_152317) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "obituaries", force: :cascade do |t|
    t.string "name"
    t.datetime "dod"
    t.string "link"
    t.string "funeral_home"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "dod", "funeral_home"], name: "index_obituaries_on_name_and_dod_and_funeral_home", unique: true
  end

end
