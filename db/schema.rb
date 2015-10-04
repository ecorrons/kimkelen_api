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

ActiveRecord::Schema.define(version: 20150730152528) do

  create_table "absence_type", force: :cascade do |t|
    t.string  "name",        limit: 255,                                         null: false
    t.decimal "value",                     precision: 3, scale: 2, default: 0.0, null: false
    t.integer "method",      limit: 4,                             default: 0,   null: false
    t.integer "order",       limit: 4,                                           null: false
    t.text    "description", limit: 65535
  end

  add_index "absence_type", ["name"], name: "name", using: :btree

  create_table "address", force: :cascade do |t|
    t.integer "state_id", limit: 4
    t.integer "city_id",  limit: 4
    t.string  "street",   limit: 255
    t.string  "number",   limit: 255
    t.string  "floor",    limit: 255
    t.string  "flat",     limit: 255
  end

  add_index "address", ["city_id"], name: "address_FI_2", using: :btree
  add_index "address", ["state_id"], name: "address_FI_1", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.integer  "state_id",   limit: 4
    t.integer  "city_id",    limit: 4
    t.string   "street",     limit: 255
    t.string   "number",     limit: 255
    t.string   "floor",      limit: 255
    t.string   "flat",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "brotherhood", force: :cascade do |t|
    t.integer "student_id", limit: 4
    t.integer "brother_id", limit: 4
  end

  add_index "brotherhood", ["brother_id"], name: "brotherhood_FI_2", using: :btree
  add_index "brotherhood", ["student_id"], name: "brotherhood_FI_1", using: :btree

  create_table "career", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "file_number_sequence", limit: 8,   default: 1, null: false
    t.string   "plan_name",            limit: 255,             null: false
    t.integer  "quantity_years",       limit: 4,               null: false
    t.string   "career_name",          limit: 255,             null: false
  end

  create_table "career_school_year", force: :cascade do |t|
    t.integer "school_year_id",           limit: 4,             null: false
    t.integer "career_id",                limit: 4,             null: false
    t.integer "subject_configuration_id", limit: 4,             null: false
    t.integer "is_processed",             limit: 1, default: 0
  end

  add_index "career_school_year", ["career_id"], name: "career_school_year_FI_2", using: :btree
  add_index "career_school_year", ["school_year_id", "career_id"], name: "career_school_year", using: :btree
  add_index "career_school_year", ["school_year_id", "career_id"], name: "career_school_year_u", unique: true, using: :btree
  add_index "career_school_year", ["subject_configuration_id"], name: "career_school_year_FI_3", using: :btree

  create_table "career_school_year_period", force: :cascade do |t|
    t.string  "name",                         limit: 255,             null: false
    t.integer "career_school_year_id",        limit: 4,               null: false
    t.date    "start_at",                                             null: false
    t.date    "end_at",                                               null: false
    t.integer "is_closed",                    limit: 1,   default: 0
    t.integer "course_type",                  limit: 4
    t.integer "career_school_year_period_id", limit: 4
    t.string  "short_name",                   limit: 255,             null: false
    t.integer "max_absences",                 limit: 4
  end

  add_index "career_school_year_period", ["career_school_year_id"], name: "career_school_year_period_FI_1", using: :btree
  add_index "career_school_year_period", ["career_school_year_period_id"], name: "career_school_year_period_FI_2", using: :btree
  add_index "career_school_year_period", ["course_type", "career_school_year_id"], name: "career_school_year_course_type", using: :btree

  create_table "career_student", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "career_id",                       limit: 4,                 null: false
    t.integer  "student_id",                      limit: 4,                 null: false
    t.integer  "orientation_id",                  limit: 4
    t.integer  "sub_orientation_id",              limit: 4
    t.integer  "start_year",                      limit: 4,     default: 1
    t.string   "file_number",                     limit: 20,                null: false
    t.integer  "status",                          limit: 4,     default: 0
    t.text     "orientation_change_observations", limit: 65535
    t.integer  "graduation_school_year_id",       limit: 4
  end

  add_index "career_student", ["career_id", "student_id"], name: "career_student_unique", unique: true, using: :btree
  add_index "career_student", ["graduation_school_year_id"], name: "career_student_FI_5", using: :btree
  add_index "career_student", ["orientation_id"], name: "career_student_FI_3", using: :btree
  add_index "career_student", ["student_id", "career_id", "orientation_id", "sub_orientation_id"], name: "student_career_orientation_sub_orientation", using: :btree
  add_index "career_student", ["student_id", "career_id", "orientation_id"], name: "student_career_orientation", using: :btree
  add_index "career_student", ["student_id", "career_id"], name: "student_career", using: :btree
  add_index "career_student", ["sub_orientation_id"], name: "career_student_FI_4", using: :btree

  create_table "career_subject", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "career_id",                     limit: 4,             null: false
    t.integer  "subject_id",                    limit: 4,             null: false
    t.integer  "year",                          limit: 4,             null: false
    t.integer  "has_options",                   limit: 1, default: 0
    t.integer  "is_option",                     limit: 1, default: 0
    t.integer  "orientation_id",                limit: 4
    t.integer  "has_correlative_previous_year", limit: 1, default: 1
    t.integer  "sub_orientation_id",            limit: 4
  end

  add_index "career_subject", ["career_id", "subject_id", "year", "orientation_id", "sub_orientation_id"], name: "career_subject_year_unique", unique: true, using: :btree
  add_index "career_subject", ["orientation_id"], name: "career_subject_FI_3", using: :btree
  add_index "career_subject", ["sub_orientation_id"], name: "career_subject_FI_4", using: :btree
  add_index "career_subject", ["subject_id", "career_id", "orientation_id", "sub_orientation_id"], name: "career_subject_orientation_sub_orientation", using: :btree
  add_index "career_subject", ["subject_id", "career_id", "orientation_id"], name: "career_subject_orientation", using: :btree
  add_index "career_subject", ["subject_id", "career_id"], name: "career_subject", using: :btree

  create_table "career_subject_school_year", force: :cascade do |t|
    t.integer "career_school_year_id",    limit: 4,             null: false
    t.integer "career_subject_id",        limit: 4,             null: false
    t.integer "subject_configuration_id", limit: 4
    t.integer "index_sort",               limit: 4, default: 0
  end

  add_index "career_subject_school_year", ["career_school_year_id"], name: "career_subject_school_year_FI_1", using: :btree
  add_index "career_subject_school_year", ["career_subject_id", "career_school_year_id"], name: "career_subject_school_year", unique: true, using: :btree
  add_index "career_subject_school_year", ["subject_configuration_id"], name: "career_subject_school_year_FI_3", using: :btree

  create_table "career_subject_school_year_tag", id: false, force: :cascade do |t|
    t.integer "career_subject_school_year_id", limit: 4, null: false
    t.integer "tag_id",                        limit: 4, null: false
  end

  add_index "career_subject_school_year_tag", ["tag_id"], name: "career_subject_school_year_tag_FI_2", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "zip_code",   limit: 255
    t.string   "name",       limit: 255
    t.integer  "state_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "city", force: :cascade do |t|
    t.string  "zip_code", limit: 255, null: false
    t.string  "name",     limit: 255, null: false
    t.integer "state_id", limit: 4,   null: false
  end

  add_index "city", ["name"], name: "name", using: :btree
  add_index "city", ["state_id"], name: "state", using: :btree

  create_table "classroom", force: :cascade do |t|
    t.string  "name",        limit: 255, null: false
    t.integer "seat_number", limit: 4
  end

  add_index "classroom", ["name"], name: "classroom_U_1", unique: true, using: :btree

  create_table "classroom_resources", force: :cascade do |t|
    t.integer "resource_id",  limit: 4, null: false
    t.integer "classroom_id", limit: 4, null: false
  end

  add_index "classroom_resources", ["classroom_id"], name: "classroom_resources_FI_2", using: :btree
  add_index "classroom_resources", ["resource_id"], name: "classroom_resources_FI_1", using: :btree

  create_table "conduct", force: :cascade do |t|
    t.string "name",       limit: 255, null: false
    t.string "short_name", limit: 255, null: false
  end

  create_table "correlative", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "career_subject_id",             limit: 4, null: false
    t.integer  "correlative_career_subject_id", limit: 4, null: false
  end

  add_index "correlative", ["career_subject_id", "correlative_career_subject_id"], name: "career_subject_correlative_career_subject_unique", unique: true, using: :btree
  add_index "correlative", ["correlative_career_subject_id"], name: "correlative_FI_2", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "country", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "course", force: :cascade do |t|
    t.date    "starts_at"
    t.string  "name",                limit: 255,             null: false
    t.integer "quota",               limit: 4
    t.integer "school_year_id",      limit: 4,               null: false
    t.integer "division_id",         limit: 4
    t.integer "is_closed",           limit: 1,   default: 0
    t.integer "current_period",      limit: 4,   default: 1
    t.integer "related_division_id", limit: 4
  end

  add_index "course", ["division_id"], name: "course_FI_2", using: :btree
  add_index "course", ["related_division_id"], name: "course_FI_3", using: :btree
  add_index "course", ["school_year_id", "division_id"], name: "course_division", using: :btree

  create_table "course_preceptor", force: :cascade do |t|
    t.integer "preceptor_id", limit: 4, null: false
    t.integer "course_id",    limit: 4, null: false
  end

  add_index "course_preceptor", ["course_id"], name: "course_preceptor_FI_2", using: :btree
  add_index "course_preceptor", ["preceptor_id", "course_id"], name: "course_preceptor", using: :btree
  add_index "course_preceptor", ["preceptor_id", "course_id"], name: "unique_course_preceptor", unique: true, using: :btree

  create_table "course_subject", force: :cascade do |t|
    t.integer "course_id",                     limit: 4, null: false
    t.integer "career_subject_school_year_id", limit: 4, null: false
  end

  add_index "course_subject", ["career_subject_school_year_id"], name: "course_subject_FI_2", using: :btree
  add_index "course_subject", ["course_id", "career_subject_school_year_id"], name: "course_subject", using: :btree
  add_index "course_subject", ["course_id", "career_subject_school_year_id"], name: "course_subject_unique", unique: true, using: :btree

  create_table "course_subject_configuration", force: :cascade do |t|
    t.integer "course_subject_id",            limit: 4
    t.integer "division_id",                  limit: 4
    t.integer "career_school_year_period_id", limit: 4
    t.float   "max_absence",                  limit: 24
  end

  add_index "course_subject_configuration", ["career_school_year_period_id"], name: "course_subject_configuration_FI_3", using: :btree
  add_index "course_subject_configuration", ["course_subject_id", "division_id", "career_school_year_period_id"], name: "course_subject_configuration", using: :btree
  add_index "course_subject_configuration", ["division_id"], name: "course_subject_configuration_FI_2", using: :btree

  create_table "course_subject_day", force: :cascade do |t|
    t.integer "course_subject_id", limit: 4,             null: false
    t.integer "day",               limit: 4,             null: false
    t.time    "starts_at"
    t.time    "ends_at"
    t.integer "classroom_id",      limit: 4
    t.integer "block",             limit: 4, default: 1, null: false
  end

  add_index "course_subject_day", ["classroom_id"], name: "course_subject_day_FI_2", using: :btree
  add_index "course_subject_day", ["course_subject_id", "day"], name: "course_subject_day", using: :btree

  create_table "course_subject_student", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "course_subject_id",                  limit: 4,             null: false
    t.integer  "student_id",                         limit: 4,             null: false
    t.integer  "student_approved_course_subject_id", limit: 4
    t.integer  "is_not_averageable",                 limit: 1, default: 0
  end

  add_index "course_subject_student", ["course_subject_id", "student_id"], name: "course_subject_student", using: :btree
  add_index "course_subject_student", ["course_subject_id", "student_id"], name: "course_subject_student_unique", unique: true, using: :btree
  add_index "course_subject_student", ["student_approved_course_subject_id"], name: "course_subject_student_FI_3", using: :btree
  add_index "course_subject_student", ["student_id"], name: "course_subject_student_FI_2", using: :btree

  create_table "course_subject_student_examination", force: :cascade do |t|
    t.integer "course_subject_student_id", limit: 4,                                      null: false
    t.integer "examination_subject_id",    limit: 4
    t.decimal "mark",                                 precision: 5, scale: 2
    t.integer "is_absent",                 limit: 1,                          default: 0
    t.integer "examination_number",        limit: 4,                          default: 1, null: false
    t.integer "can_take_examination",      limit: 1,                          default: 1
    t.date    "date"
    t.string  "folio_number",              limit: 20
  end

  add_index "course_subject_student_examination", ["course_subject_student_id", "examination_number"], name: "course_subject_student_examination_number", using: :btree
  add_index "course_subject_student_examination", ["course_subject_student_id", "examination_subject_id", "examination_number"], name: "course_subject_student_subject_examination_number", using: :btree
  add_index "course_subject_student_examination", ["course_subject_student_id", "examination_subject_id", "examination_number"], name: "csse_unique", unique: true, using: :btree
  add_index "course_subject_student_examination", ["course_subject_student_id", "examination_subject_id"], name: "course_subject_student_id", using: :btree
  add_index "course_subject_student_examination", ["examination_subject_id"], name: "course_subject_student_examination_FI_2", using: :btree

  create_table "course_subject_student_mark", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "course_subject_student_id", limit: 4,                                     null: false
    t.integer  "mark_number",               limit: 4,                                     null: false
    t.decimal  "mark",                                precision: 5, scale: 2
    t.integer  "is_closed",                 limit: 1,                         default: 0
    t.integer  "is_free",                   limit: 1,                         default: 0
  end

  add_index "course_subject_student_mark", ["course_subject_student_id"], name: "course_subject_student", using: :btree

  create_table "course_subject_teacher", force: :cascade do |t|
    t.integer "teacher_id",        limit: 4, null: false
    t.integer "course_subject_id", limit: 4, null: false
  end

  add_index "course_subject_teacher", ["course_subject_id"], name: "course_subject_teacher_FI_2", using: :btree
  add_index "course_subject_teacher", ["teacher_id", "course_subject_id"], name: "teacher_course_subject", using: :btree
  add_index "course_subject_teacher", ["teacher_id", "course_subject_id"], name: "teacher_course_subject_unique", unique: true, using: :btree

  create_table "disciplinary_sanction_type", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "disciplinary_sanction_type", ["name"], name: "disciplinary_sanction_type_name", unique: true, using: :btree

  create_table "division", force: :cascade do |t|
    t.integer "division_title_id",     limit: 4, null: false
    t.integer "career_school_year_id", limit: 4, null: false
    t.integer "shift_id",              limit: 4, null: false
    t.integer "year",                  limit: 4, null: false
  end

  add_index "division", ["career_school_year_id"], name: "division_FI_2", using: :btree
  add_index "division", ["division_title_id", "career_school_year_id", "year"], name: "unique", unique: true, using: :btree
  add_index "division", ["shift_id"], name: "division_FI_3", using: :btree

  create_table "division_preceptor", force: :cascade do |t|
    t.integer "preceptor_id", limit: 4, null: false
    t.integer "division_id",  limit: 4, null: false
  end

  add_index "division_preceptor", ["division_id"], name: "division_preceptor_FI_2", using: :btree
  add_index "division_preceptor", ["preceptor_id", "division_id"], name: "division_preceptor", using: :btree
  add_index "division_preceptor", ["preceptor_id", "division_id"], name: "unique_preceptor", unique: true, using: :btree

  create_table "division_student", force: :cascade do |t|
    t.integer "student_id",  limit: 4, null: false
    t.integer "division_id", limit: 4, null: false
  end

  add_index "division_student", ["division_id", "student_id"], name: "division_student", using: :btree
  add_index "division_student", ["student_id", "division_id"], name: "unique_student_division", unique: true, using: :btree

  create_table "division_title", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "examination", force: :cascade do |t|
    t.string  "name",               limit: 255,             null: false
    t.date    "date_from",                                  null: false
    t.date    "date_to",                                    null: false
    t.integer "examination_number", limit: 4,   default: 1, null: false
    t.integer "school_year_id",     limit: 4,               null: false
  end

  add_index "examination", ["school_year_id"], name: "examination_FI_1", using: :btree

  create_table "examination_repproved", force: :cascade do |t|
    t.string  "name",               limit: 255,             null: false
    t.date    "date_from",                                  null: false
    t.date    "date_to",                                    null: false
    t.integer "examination_number", limit: 4,   default: 1, null: false
    t.integer "school_year_id",     limit: 4,               null: false
    t.integer "examination_type",   limit: 4,               null: false
  end

  add_index "examination_repproved", ["school_year_id"], name: "examination_repproved_FI_1", using: :btree

  create_table "examination_repproved_subject", force: :cascade do |t|
    t.integer "examination_repproved_id", limit: 4,             null: false
    t.integer "career_subject_id",        limit: 4,             null: false
    t.integer "is_closed",                limit: 1, default: 0
  end

  add_index "examination_repproved_subject", ["career_subject_id"], name: "examination_repproved_subject_FI_2", using: :btree
  add_index "examination_repproved_subject", ["examination_repproved_id"], name: "examination_repproved_subject_FI_1", using: :btree

  create_table "examination_repproved_subject_teacher", id: false, force: :cascade do |t|
    t.integer "id",                               limit: 4, null: false
    t.integer "examination_repproved_subject_id", limit: 4, null: false
    t.integer "teacher_id",                       limit: 4, null: false
  end

  add_index "examination_repproved_subject_teacher", ["examination_repproved_subject_id"], name: "examination_repproved_subject_teacher_FI_1", using: :btree
  add_index "examination_repproved_subject_teacher", ["teacher_id"], name: "examination_repproved_subject_teacher_FI_2", using: :btree

  create_table "examination_subject", force: :cascade do |t|
    t.integer "examination_id",                limit: 4,             null: false
    t.integer "career_subject_school_year_id", limit: 4,             null: false
    t.integer "is_closed",                     limit: 1, default: 0
  end

  add_index "examination_subject", ["career_subject_school_year_id", "examination_id"], name: "examination_career_subject_school_year", using: :btree
  add_index "examination_subject", ["examination_id", "career_subject_school_year_id"], name: "examination_subject_unique", unique: true, using: :btree

  create_table "examination_subject_teacher", id: false, force: :cascade do |t|
    t.integer "id",                     limit: 4, null: false
    t.integer "examination_subject_id", limit: 4, null: false
    t.integer "teacher_id",             limit: 4, null: false
  end

  add_index "examination_subject_teacher", ["examination_subject_id"], name: "examination_subject_teacher_FI_1", using: :btree
  add_index "examination_subject_teacher", ["teacher_id"], name: "examination_subject_teacher_FI_2", using: :btree

  create_table "head_personal_personal", force: :cascade do |t|
    t.integer "head_personal_id", limit: 4
    t.integer "personal_id",      limit: 4
  end

  add_index "head_personal_personal", ["head_personal_id", "personal_id"], name: "head_personal_personal", unique: true, using: :btree
  add_index "head_personal_personal", ["personal_id"], name: "head_personal_personal_FI_2", using: :btree

  create_table "health_coverage", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "holiday", force: :cascade do |t|
    t.date   "day",                    null: false
    t.string "description", limit: 50
  end

  create_table "justification_type", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "justification_type", ["name"], name: "justification_name", unique: true, using: :btree
  add_index "justification_type", ["name"], name: "name", using: :btree

  create_table "license", force: :cascade do |t|
    t.integer "person_id",       limit: 4
    t.integer "license_type_id", limit: 4
    t.date    "date_from",                                 null: false
    t.date    "date_to"
    t.text    "observation",     limit: 65535
    t.integer "is_active",       limit: 1,     default: 1
  end

  add_index "license", ["license_type_id"], name: "license_FI_2", using: :btree
  add_index "license", ["person_id"], name: "license_FI_1", using: :btree

  create_table "license_type", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "license_type", ["name"], name: "license_type", unique: true, using: :btree

  create_table "nc_change_log_entry", force: :cascade do |t|
    t.string   "class_name",     limit: 255,   null: false
    t.integer  "object_pk",      limit: 4,     null: false
    t.text     "changes_detail", limit: 65535, null: false
    t.string   "username",       limit: 255
    t.integer  "operation_type", limit: 4,     null: false
    t.datetime "created_at"
  end

  create_table "occupation", force: :cascade do |t|
    t.string "name", limit: 256, null: false
  end

  add_index "occupation", ["name"], name: "name", unique: true, length: {"name"=>20}, using: :btree

  create_table "occupation_category", force: :cascade do |t|
    t.string "name", limit: 256, null: false
  end

  add_index "occupation_category", ["name"], name: "name", unique: true, length: {"name"=>20}, using: :btree

  create_table "optional_career_subject", force: :cascade do |t|
    t.integer "career_subject_school_year_id",        limit: 4, null: false
    t.integer "choice_career_subject_school_year_id", limit: 4, null: false
  end

  add_index "optional_career_subject", ["career_subject_school_year_id", "choice_career_subject_school_year_id"], name: "career_subject_optional_career_subject_unique", unique: true, using: :btree
  add_index "optional_career_subject", ["choice_career_subject_school_year_id"], name: "optional_career_subject_FI_2", using: :btree

  create_table "orientation", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "last_name",           limit: 255
    t.string   "first_name",          limit: 255
    t.integer  "identification_type", limit: 4
    t.boolean  "is_active",           limit: 1
    t.string   "email",               limit: 255
    t.string   "phone",               limit: 255
    t.string   "observations",        limit: 255
    t.integer  "addres_id",           limit: 4
    t.integer  "user_id",             limit: 4
    t.integer  "sex",                 limit: 4
    t.string   "cuil",                limit: 255
    t.date     "birthdate"
    t.string   "birth_country",       limit: 255
    t.string   "birth_state",         limit: 255
    t.string   "birth_city",          limit: 255
    t.string   "photo",               limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "person", force: :cascade do |t|
    t.string  "lastname",              limit: 255,               null: false
    t.string  "firstname",             limit: 255,               null: false
    t.integer "identification_type",   limit: 4
    t.string  "identification_number", limit: 20
    t.integer "is_active",             limit: 1,     default: 1
    t.string  "email",                 limit: 255
    t.string  "phone",                 limit: 255
    t.text    "observations",          limit: 65535
    t.integer "address_id",            limit: 4
    t.integer "user_id",               limit: 4
    t.integer "sex",                   limit: 4,                 null: false
    t.string  "cuil",                  limit: 20
    t.date    "birthdate"
    t.string  "birth_country",         limit: 255
    t.string  "birth_state",           limit: 255
    t.string  "birth_city",            limit: 255
    t.string  "photo",                 limit: 255
  end

  add_index "person", ["address_id"], name: "person_FI_1", using: :btree
  add_index "person", ["user_id"], name: "person_FI_2", using: :btree

  create_table "personal", force: :cascade do |t|
    t.integer "person_id",         limit: 4
    t.float   "salary",            limit: 24
    t.date    "aging_institution"
    t.integer "file_number",       limit: 4
    t.integer "personal_type",     limit: 4,  default: 1
  end

  add_index "personal", ["person_id"], name: "personal_FI_1", using: :btree

  create_table "pm_configuration", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pm_module", force: :cascade do |t|
    t.string  "name",                limit: 256,             null: false
    t.integer "is_enabled",          limit: 1,   default: 0
    t.integer "pm_configuration_id", limit: 4,               null: false
  end

  add_index "pm_module", ["name"], name: "name", unique: true, length: {"name"=>20}, using: :btree
  add_index "pm_module", ["pm_configuration_id"], name: "pm_module_FI_1", using: :btree

  create_table "resources", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "resources", ["name"], name: "resources_U_1", unique: true, using: :btree

  create_table "sanction_type", force: :cascade do |t|
    t.string  "name",                      limit: 255,             null: false
    t.integer "considered_in_report_card", limit: 1,   default: 1
  end

  add_index "sanction_type", ["name"], name: "sanction_type_name", unique: true, using: :btree

  create_table "school_year", force: :cascade do |t|
    t.integer "year",      limit: 4
    t.integer "is_active", limit: 1
    t.integer "is_closed", limit: 1, default: 0
  end

  add_index "school_year", ["year"], name: "school_year_U_1", unique: true, using: :btree

  create_table "school_year_student", force: :cascade do |t|
    t.integer  "student_id",     limit: 4, null: false
    t.integer  "school_year_id", limit: 4, null: false
    t.integer  "shift_id",       limit: 4, null: false
    t.datetime "created_at"
  end

  add_index "school_year_student", ["school_year_id"], name: "school_year_student_FI_2", using: :btree
  add_index "school_year_student", ["shift_id"], name: "school_year_student_FI_3", using: :btree
  add_index "school_year_student", ["student_id", "school_year_id"], name: "student_school_year", using: :btree
  add_index "school_year_student", ["student_id", "school_year_id"], name: "unique", unique: true, using: :btree

  create_table "school_years", force: :cascade do |t|
    t.integer  "year",       limit: 4
    t.boolean  "is_active",  limit: 1
    t.boolean  "is_closed",  limit: 1
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "sf_guard_group", force: :cascade do |t|
    t.string "name",        limit: 255,   null: false
    t.text   "description", limit: 65535
  end

  add_index "sf_guard_group", ["name"], name: "sf_guard_group_U_1", unique: true, using: :btree

  create_table "sf_guard_group_permission", id: false, force: :cascade do |t|
    t.integer "group_id",      limit: 4, null: false
    t.integer "permission_id", limit: 4, null: false
  end

  add_index "sf_guard_group_permission", ["permission_id"], name: "sf_guard_group_permission_FI_2", using: :btree

  create_table "sf_guard_permission", force: :cascade do |t|
    t.string "name",        limit: 255,   null: false
    t.text   "description", limit: 65535
  end

  add_index "sf_guard_permission", ["name"], name: "sf_guard_permission_U_1", unique: true, using: :btree

  create_table "sf_guard_remember_key", id: false, force: :cascade do |t|
    t.integer  "user_id",      limit: 4,  null: false
    t.string   "remember_key", limit: 32
    t.string   "ip_address",   limit: 50, null: false
    t.datetime "created_at"
  end

  create_table "sf_guard_secure_login_failure", force: :cascade do |t|
    t.string   "username",   limit: 128, null: false
    t.string   "ip_address", limit: 50,  null: false
    t.string   "cookie_id",  limit: 255, null: false
    t.datetime "failed_at",              null: false
  end

  add_index "sf_guard_secure_login_failure", ["failed_at"], name: "failed_at_index", using: :btree
  add_index "sf_guard_secure_login_failure", ["ip_address"], name: "ip_index", using: :btree
  add_index "sf_guard_secure_login_failure", ["username"], name: "username_index", using: :btree

  create_table "sf_guard_secure_password_policy_history", force: :cascade do |t|
    t.string   "username",   limit: 128,                  null: false
    t.string   "algorithm",  limit: 128, default: "sha1", null: false
    t.string   "salt",       limit: 128,                  null: false
    t.string   "password",   limit: 128,                  null: false
    t.datetime "changed_at",                              null: false
  end

  add_index "sf_guard_secure_password_policy_history", ["algorithm"], name: "algorithm_index", using: :btree
  add_index "sf_guard_secure_password_policy_history", ["changed_at"], name: "changed_at_index", using: :btree
  add_index "sf_guard_secure_password_policy_history", ["salt"], name: "salt_index", using: :btree
  add_index "sf_guard_secure_password_policy_history", ["username"], name: "sf_guard_secure_password_policy_history_U_1", unique: true, using: :btree
  add_index "sf_guard_secure_password_policy_history", ["username"], name: "username_index", using: :btree

  create_table "sf_guard_user", force: :cascade do |t|
    t.string   "username",             limit: 128,                  null: false
    t.string   "algorithm",            limit: 128, default: "sha1", null: false
    t.string   "salt",                 limit: 128,                  null: false
    t.string   "password",             limit: 128,                  null: false
    t.datetime "created_at"
    t.datetime "last_login"
    t.integer  "is_active",            limit: 1,   default: 1,      null: false
    t.integer  "is_super_admin",       limit: 1,   default: 0,      null: false
    t.datetime "change_password_at"
    t.integer  "must_change_password", limit: 1,   default: 0,      null: false
  end

  add_index "sf_guard_user", ["username"], name: "sf_guard_user_U_1", unique: true, using: :btree

  create_table "sf_guard_user_group", id: false, force: :cascade do |t|
    t.integer "user_id",  limit: 4, null: false
    t.integer "group_id", limit: 4, null: false
  end

  add_index "sf_guard_user_group", ["group_id"], name: "sf_guard_user_group_FI_2", using: :btree

  create_table "sf_guard_user_permission", id: false, force: :cascade do |t|
    t.integer "user_id",       limit: 4, null: false
    t.integer "permission_id", limit: 4, null: false
  end

  add_index "sf_guard_user_permission", ["permission_id"], name: "sf_guard_user_permission_FI_2", using: :btree

  create_table "sf_guard_user_profile", force: :cascade do |t|
    t.integer "user_id",               limit: 4,     null: false
    t.string  "first_name",            limit: 255
    t.string  "last_name",             limit: 255
    t.integer "identification_type",   limit: 4,     null: false
    t.string  "identification_number", limit: 20,    null: false
    t.string  "email",                 limit: 255
    t.string  "phone",                 limit: 255
    t.text    "observations",          limit: 65535
  end

  add_index "sf_guard_user_profile", ["user_id"], name: "sf_guard_user_profile_FI_1", using: :btree

  create_table "shift", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "state", force: :cascade do |t|
    t.string  "name",       limit: 255, null: false
    t.integer "country_id", limit: 4,   null: false
  end

  add_index "state", ["country_id"], name: "country", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "country_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "student", force: :cascade do |t|
    t.string  "global_file_number",    limit: 20,    null: false
    t.integer "person_id",             limit: 4
    t.integer "occupation_id",         limit: 4
    t.time    "busy_starts_at"
    t.time    "busy_ends_at"
    t.string  "blood_group",           limit: 50
    t.string  "blood_factor",          limit: 50
    t.text    "emergency_information", limit: 65535
    t.integer "health_coverage_id",    limit: 4
    t.string  "order_of_merit",        limit: 20
    t.string  "folio_number",          limit: 20
  end

  add_index "student", ["health_coverage_id"], name: "student_FI_3", using: :btree
  add_index "student", ["occupation_id"], name: "student_FI_2", using: :btree
  add_index "student", ["person_id"], name: "student_FI_1", using: :btree

  create_table "student_advice", force: :cascade do |t|
    t.integer "student_id",                    limit: 4,                                null: false
    t.decimal "value",                                       precision: 10, default: 1, null: false
    t.integer "disciplinary_sanction_type_id", limit: 4,                                null: false
    t.text    "observation",                   limit: 65535
    t.string  "document",                      limit: 255
    t.integer "applicant_id",                  limit: 4
    t.integer "responsible_id",                limit: 4
    t.integer "school_year_id",                limit: 4,                                null: false
    t.string  "number",                        limit: 11
    t.string  "name",                          limit: 255
    t.integer "sanction_type_id",              limit: 4,                                null: false
    t.date    "request_date",                                                           null: false
    t.date    "resolution_date"
    t.string  "applicant_other",               limit: 255
  end

  add_index "student_advice", ["applicant_id"], name: "student_advice_FI_4", using: :btree
  add_index "student_advice", ["disciplinary_sanction_type_id"], name: "student_advice_FI_2", using: :btree
  add_index "student_advice", ["responsible_id"], name: "student_advice_FI_5", using: :btree
  add_index "student_advice", ["sanction_type_id"], name: "student_advice_FI_3", using: :btree
  add_index "student_advice", ["school_year_id"], name: "student_advice_FI_6", using: :btree
  add_index "student_advice", ["student_id", "school_year_id"], name: "student_school_year", using: :btree

  create_table "student_approved_career_subject", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "career_subject_id", limit: 4,                                     null: false
    t.integer  "student_id",        limit: 4,                                     null: false
    t.integer  "school_year_id",    limit: 4,                                     null: false
    t.decimal  "mark",                        precision: 4, scale: 2
    t.integer  "is_equivalence",    limit: 1,                         default: 0
  end

  add_index "student_approved_career_subject", ["career_subject_id", "student_id", "school_year_id"], name: "student_approval", using: :btree
  add_index "student_approved_career_subject", ["career_subject_id", "student_id", "school_year_id"], name: "unique_student_approval", unique: true, using: :btree
  add_index "student_approved_career_subject", ["career_subject_id", "student_id"], name: "student_career_subject_id", using: :btree
  add_index "student_approved_career_subject", ["career_subject_id"], name: "career_subject", using: :btree
  add_index "student_approved_career_subject", ["school_year_id"], name: "student_approved_career_subject_FI_3", using: :btree
  add_index "student_approved_career_subject", ["student_id"], name: "student_id", using: :btree

  create_table "student_approved_course_subject", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_subject_id",                  limit: 4,                         null: false
    t.integer  "student_id",                         limit: 4,                         null: false
    t.integer  "school_year_id",                     limit: 4,                         null: false
    t.integer  "student_approved_career_subject_id", limit: 4
    t.decimal  "mark",                                         precision: 4, scale: 2
  end

  add_index "student_approved_course_subject", ["course_subject_id", "student_id", "school_year_id"], name: "student_school_year_course_subject", using: :btree
  add_index "student_approved_course_subject", ["course_subject_id", "student_id", "school_year_id"], name: "unique_student_approval", unique: true, using: :btree
  add_index "student_approved_course_subject", ["course_subject_id"], name: "course_subject", using: :btree
  add_index "student_approved_course_subject", ["school_year_id"], name: "student_approved_course_subject_FI_3", using: :btree
  add_index "student_approved_course_subject", ["student_approved_career_subject_id"], name: "student_approved_course_subject_FI_4", using: :btree
  add_index "student_approved_course_subject", ["student_id", "course_subject_id"], name: "student_course_subject", using: :btree
  add_index "student_approved_course_subject", ["student_id", "school_year_id"], name: "student_school_year", using: :btree
  add_index "student_approved_course_subject", ["student_id"], name: "student", using: :btree

  create_table "student_attendance", force: :cascade do |t|
    t.integer "career_school_year_id",               limit: 4,                                       null: false
    t.integer "student_id",                          limit: 4,                                       null: false
    t.date    "day",                                                                                 null: false
    t.integer "absence_type_id",                     limit: 4
    t.decimal "value",                                         precision: 3, scale: 2, default: 0.0
    t.integer "course_subject_id",                   limit: 4
    t.integer "student_attendance_justification_id", limit: 4
  end

  add_index "student_attendance", ["absence_type_id"], name: "student_attendance_FI_3", using: :btree
  add_index "student_attendance", ["career_school_year_id"], name: "student_attendance_FI_1", using: :btree
  add_index "student_attendance", ["course_subject_id"], name: "student_attendance_FI_4", using: :btree
  add_index "student_attendance", ["student_attendance_justification_id"], name: "student_attendance_FI_5", using: :btree
  add_index "student_attendance", ["student_id", "career_school_year_id"], name: "student_career", using: :btree
  add_index "student_attendance", ["student_id", "course_subject_id"], name: "student_course", using: :btree
  add_index "student_attendance", ["student_id", "day", "course_subject_id"], name: "student_attendance_unique", unique: true, using: :btree

  create_table "student_attendance_justification", force: :cascade do |t|
    t.integer "justification_type_id", limit: 4,     null: false
    t.text    "observation",           limit: 65535
    t.string  "document",              limit: 255
  end

  add_index "student_attendance_justification", ["justification_type_id"], name: "student_attendance_justification_FI_1", using: :btree

  create_table "student_career_school_year", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "career_school_year_id", limit: 4,             null: false
    t.integer  "student_id",            limit: 4,             null: false
    t.integer  "year",                  limit: 4,             null: false
    t.integer  "status",                limit: 4, default: 0
    t.integer  "is_processed",          limit: 1, default: 0
  end

  add_index "student_career_school_year", ["career_school_year_id", "student_id", "year"], name: "student_career_school_year_unique", unique: true, using: :btree
  add_index "student_career_school_year", ["student_id", "career_school_year_id"], name: "student_career_school_year", using: :btree

  create_table "student_career_school_year_conduct", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "student_career_school_year_id", limit: 4, null: false
    t.integer  "conduct_id",                    limit: 4, null: false
    t.integer  "career_school_year_period_id",  limit: 4, null: false
  end

  add_index "student_career_school_year_conduct", ["career_school_year_period_id"], name: "student_career_school_year_conduct_FI_3", using: :btree
  add_index "student_career_school_year_conduct", ["conduct_id"], name: "student_career_school_year_conduct_FI_2", using: :btree
  add_index "student_career_school_year_conduct", ["student_career_school_year_id", "career_school_year_period_id"], name: "subject_unique", unique: true, using: :btree

  create_table "student_career_subject_allowed", id: false, force: :cascade do |t|
    t.integer "id",                limit: 4, null: false
    t.integer "career_subject_id", limit: 4, null: false
    t.integer "student_id",        limit: 4, null: false
  end

  add_index "student_career_subject_allowed", ["career_subject_id", "student_id"], name: "career_subject_student", unique: true, using: :btree
  add_index "student_career_subject_allowed", ["student_id", "career_subject_id"], name: "career_subject_student_index", using: :btree

  create_table "student_disapproved_course_subject", force: :cascade do |t|
    t.integer "course_subject_student_id",          limit: 4,             null: false
    t.integer "examination_number",                 limit: 4, default: 0
    t.integer "student_approved_career_subject_id", limit: 4
  end

  add_index "student_disapproved_course_subject", ["course_subject_student_id"], name: "course_subject", using: :btree
  add_index "student_disapproved_course_subject", ["student_approved_career_subject_id"], name: "student_approved_career_subject", using: :btree

  create_table "student_examination_repproved_subject", force: :cascade do |t|
    t.integer "student_repproved_course_subject_id", limit: 4,                                      null: false
    t.integer "examination_repproved_subject_id",    limit: 4
    t.decimal "mark",                                           precision: 5, scale: 2
    t.integer "is_absent",                           limit: 1,                          default: 0
    t.date    "date"
    t.string  "folio_number",                        limit: 20
  end

  add_index "student_examination_repproved_subject", ["examination_repproved_subject_id"], name: "student_examination_repproved_subject_FI_2", using: :btree
  add_index "student_examination_repproved_subject", ["student_repproved_course_subject_id"], name: "student_examination_repproved_subject_FI_1", using: :btree

  create_table "student_free", force: :cascade do |t|
    t.integer "student_id",                   limit: 4,             null: false
    t.integer "career_school_year_period_id", limit: 4
    t.integer "course_subject_id",            limit: 4
    t.integer "is_free",                      limit: 1, default: 1
    t.integer "career_school_year_id",        limit: 4
  end

  add_index "student_free", ["career_school_year_id"], name: "student_free_FI_3", using: :btree
  add_index "student_free", ["career_school_year_period_id"], name: "student_free_FI_2", using: :btree
  add_index "student_free", ["course_subject_id"], name: "student_free_FI_4", using: :btree
  add_index "student_free", ["student_id", "career_school_year_period_id"], name: "student_career_school_year_period_id", using: :btree
  add_index "student_free", ["student_id", "course_subject_id", "career_school_year_period_id"], name: "student_course_subject_career_school_year_period_id", using: :btree
  add_index "student_free", ["student_id", "course_subject_id"], name: "student_course_subject_id", using: :btree

  create_table "student_reincorporation", force: :cascade do |t|
    t.integer  "student_id",                   limit: 4,     null: false
    t.integer  "reincorporation_days",         limit: 4,     null: false
    t.integer  "course_subject_id",            limit: 4
    t.text     "observation",                  limit: 65535
    t.datetime "created_at"
    t.integer  "career_school_year_period_id", limit: 4,     null: false
  end

  add_index "student_reincorporation", ["career_school_year_period_id"], name: "student_reincorporation_FI_1", using: :btree
  add_index "student_reincorporation", ["course_subject_id"], name: "student_reincorporation_FI_3", using: :btree
  add_index "student_reincorporation", ["student_id", "career_school_year_period_id"], name: "student_career_school_year_period_id", using: :btree
  add_index "student_reincorporation", ["student_id", "course_subject_id", "career_school_year_period_id"], name: "student_course_subject_career_school_year_period_id", using: :btree
  add_index "student_reincorporation", ["student_id", "course_subject_id"], name: "student_course", using: :btree

  create_table "student_repproved_course_subject", force: :cascade do |t|
    t.integer  "course_subject_student_id",          limit: 4, null: false
    t.integer  "student_approved_career_subject_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "student_repproved_course_subject", ["course_subject_student_id", "student_approved_career_subject_id"], name: "course_subject_student_student_approved", using: :btree
  add_index "student_repproved_course_subject", ["student_approved_career_subject_id"], name: "student_repproved_course_subject_FI_2", using: :btree

  create_table "student_study", id: false, force: :cascade do |t|
    t.integer "id",         limit: 4, null: false
    t.integer "student_id", limit: 4, null: false
    t.integer "study_id",   limit: 4, null: false
  end

  add_index "student_study", ["student_id"], name: "student_study_FI_1", using: :btree
  add_index "student_study", ["study_id"], name: "student_study_FI_2", using: :btree

  create_table "student_tag", id: false, force: :cascade do |t|
    t.integer "student_id", limit: 4, null: false
    t.integer "tag_id",     limit: 4, null: false
  end

  add_index "student_tag", ["tag_id"], name: "student_tag_FI_2", using: :btree

  create_table "student_tutor", force: :cascade do |t|
    t.integer "tutor_id",   limit: 4
    t.integer "student_id", limit: 4
  end

  add_index "student_tutor", ["student_id"], name: "student_tutor_FI_2", using: :btree
  add_index "student_tutor", ["tutor_id"], name: "student_tutor_FI_1", using: :btree

  create_table "student_tutors", force: :cascade do |t|
    t.integer  "tutor_id",   limit: 4
    t.integer  "student_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "global_file_number", limit: 255
    t.integer  "person_id",          limit: 4
    t.integer  "occupation_id",      limit: 4
    t.datetime "busy_starts_at"
    t.datetime "busy_ends_at"
    t.string   "blood_group",        limit: 255
    t.string   "blood_factor",       limit: 255
    t.string   "emergency",          limit: 255
    t.integer  "health_coverage_id", limit: 4
    t.string   "older_of_merit",     limit: 255
    t.string   "folio_number",       limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "study", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "study", ["name"], name: "study_U_1", unique: true, using: :btree

  create_table "sub_orientation", force: :cascade do |t|
    t.string  "name",           limit: 255, null: false
    t.integer "orientation_id", limit: 4,   null: false
  end

  add_index "sub_orientation", ["orientation_id"], name: "sub_orientation_FI_1", using: :btree

  create_table "subject", force: :cascade do |t|
    t.datetime "created_at"
    t.string   "name",         limit: 255, null: false
    t.string   "fantasy_name", limit: 255, null: false
  end

  add_index "subject", ["name", "fantasy_name"], name: "subject_unique", unique: true, using: :btree
  add_index "subject", ["name"], name: "name", using: :btree

  create_table "subject_configuration", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "course_marks",                                               limit: 4, default: 3, null: false
    t.integer  "final_examination_required",                                 limit: 1, default: 0
    t.integer  "course_required",                                            limit: 1, default: 1
    t.integer  "course_minimun_mark",                                        limit: 4, default: 7
    t.integer  "course_examination_count",                                   limit: 4, default: 2, null: false
    t.integer  "max_previous",                                               limit: 4, default: 1, null: false
    t.integer  "evaluation_method",                                          limit: 4, default: 1
    t.integer  "course_type",                                                limit: 4, default: 1
    t.integer  "attendance_type",                                            limit: 4, default: 1, null: false
    t.integer  "max_disciplinary_sanctions",                                 limit: 4, default: 0
    t.integer  "when_disapprove_show_string",                                limit: 1, default: 0
    t.integer  "necessary_student_approved_career_subject_to_show_prom_def", limit: 1, default: 1
  end

  create_table "subject_year_configuration", force: :cascade do |t|
    t.integer "subject_configuration_id",  limit: 4,             null: false
    t.integer "course_type",               limit: 4
    t.integer "year",                      limit: 4,             null: false
    t.integer "has_max_absence_by_period", limit: 1, default: 1
    t.integer "max_absences",              limit: 4
  end

  add_index "subject_year_configuration", ["subject_configuration_id"], name: "subject_year_configuration_FI_1", using: :btree

  create_table "tag", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "tag", ["name"], name: "tag_U_1", unique: true, using: :btree

  create_table "teacher", force: :cascade do |t|
    t.integer "person_id",         limit: 4
    t.float   "salary",            limit: 24
    t.date    "aging_institution"
    t.integer "file_number",       limit: 4
  end

  add_index "teacher", ["person_id"], name: "teacher_FI_1", using: :btree

  create_table "teachers", force: :cascade do |t|
    t.integer  "person_id",         limit: 4
    t.float    "salary",            limit: 24
    t.date     "sging_institution"
    t.integer  "file_number",       limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "tutor", force: :cascade do |t|
    t.integer "person_id",              limit: 4
    t.integer "occupation_id",          limit: 4
    t.integer "tutor_type_id",          limit: 4
    t.integer "nationality",            limit: 4, default: 0
    t.integer "occupation_category_id", limit: 4
    t.integer "study_id",               limit: 4
    t.integer "is_alive",               limit: 1, default: 1
  end

  add_index "tutor", ["occupation_category_id"], name: "tutor_FI_4", using: :btree
  add_index "tutor", ["occupation_id"], name: "tutor_FI_2", using: :btree
  add_index "tutor", ["person_id"], name: "tutor_FI_1", using: :btree
  add_index "tutor", ["study_id"], name: "tutor_FI_5", using: :btree
  add_index "tutor", ["tutor_type_id"], name: "tutor_FI_3", using: :btree

  create_table "tutor_type", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "tutor_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tutors", force: :cascade do |t|
    t.integer  "person_id",              limit: 4
    t.integer  "occupation_id",          limit: 4
    t.integer  "tutor_type_id",          limit: 4
    t.integer  "nationality",            limit: 4
    t.integer  "occupation_category_id", limit: 4
    t.integer  "study_id",               limit: 4
    t.boolean  "is_alive",               limit: 1
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "api_key",    limit: 255
    t.string   "username",   limit: 255
    t.string   "password",   limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "auth_token", limit: 255, default: ""
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree

  add_foreign_key "address", "city", name: "address_FK_2"
  add_foreign_key "address", "state", name: "address_FK_1"
  add_foreign_key "brotherhood", "student", column: "brother_id", name: "brotherhood_FK_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "brotherhood", "student", name: "brotherhood_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "career_school_year", "career", name: "career_school_year_FK_2"
  add_foreign_key "career_school_year", "school_year", name: "career_school_year_FK_1"
  add_foreign_key "career_school_year", "subject_configuration", name: "career_school_year_FK_3"
  add_foreign_key "career_school_year_period", "career_school_year", name: "career_school_year_period_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "career_school_year_period", "career_school_year_period", name: "career_school_year_period_FK_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "career_student", "career", name: "career_student_FK_1", on_update: :cascade
  add_foreign_key "career_student", "orientation", name: "career_student_FK_3", on_update: :cascade
  add_foreign_key "career_student", "school_year", column: "graduation_school_year_id", name: "career_student_FK_5"
  add_foreign_key "career_student", "student", name: "career_student_FK_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "career_student", "sub_orientation", name: "career_student_FK_4", on_update: :cascade
  add_foreign_key "career_subject", "career", name: "career_subject_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "career_subject", "orientation", name: "career_subject_FK_3"
  add_foreign_key "career_subject", "sub_orientation", name: "career_subject_FK_4"
  add_foreign_key "career_subject", "subject", name: "career_subject_FK_2", on_update: :cascade
  add_foreign_key "career_subject_school_year", "career_school_year", name: "career_subject_school_year_FK_1", on_delete: :cascade
  add_foreign_key "career_subject_school_year", "career_subject", name: "career_subject_school_year_FK_2"
  add_foreign_key "career_subject_school_year", "subject_configuration", name: "career_subject_school_year_FK_3", on_delete: :nullify
  add_foreign_key "career_subject_school_year_tag", "career_subject_school_year", name: "career_subject_school_year_tag_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "career_subject_school_year_tag", "tag", name: "career_subject_school_year_tag_FK_2", on_update: :cascade
  add_foreign_key "city", "state", name: "city_FK_1"
  add_foreign_key "classroom_resources", "classroom", name: "classroom_resources_FK_2", on_delete: :cascade
  add_foreign_key "classroom_resources", "resources", name: "classroom_resources_FK_1", on_delete: :cascade
  add_foreign_key "correlative", "career_subject", column: "correlative_career_subject_id", name: "correlative_FK_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "correlative", "career_subject", name: "correlative_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "course", "division", column: "related_division_id", name: "course_FK_3", on_delete: :nullify
  add_foreign_key "course", "division", name: "course_FK_2", on_delete: :cascade
  add_foreign_key "course", "school_year", name: "course_FK_1"
  add_foreign_key "course_preceptor", "course", name: "course_preceptor_FK_2", on_delete: :cascade
  add_foreign_key "course_preceptor", "personal", column: "preceptor_id", name: "course_preceptor_FK_1"
  add_foreign_key "course_subject", "career_subject_school_year", name: "course_subject_FK_2", on_delete: :cascade
  add_foreign_key "course_subject", "course", name: "course_subject_FK_1", on_delete: :cascade
  add_foreign_key "course_subject_configuration", "career_school_year_period", name: "course_subject_configuration_FK_3", on_update: :cascade, on_delete: :cascade
  add_foreign_key "course_subject_configuration", "course_subject", name: "course_subject_configuration_FK_1", on_delete: :cascade
  add_foreign_key "course_subject_configuration", "division", name: "course_subject_configuration_FK_2", on_delete: :cascade
  add_foreign_key "course_subject_day", "classroom", name: "course_subject_day_FK_2", on_update: :cascade
  add_foreign_key "course_subject_day", "course_subject", name: "course_subject_day_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "course_subject_student", "course_subject", name: "course_subject_student_FK_1", on_update: :cascade
  add_foreign_key "course_subject_student", "student", name: "course_subject_student_FK_2", on_update: :cascade
  add_foreign_key "course_subject_student", "student_approved_course_subject", name: "course_subject_student_FK_3", on_update: :cascade, on_delete: :nullify
  add_foreign_key "course_subject_student_examination", "course_subject_student", name: "course_subject_student_examination_FK_1", on_update: :cascade
  add_foreign_key "course_subject_student_examination", "examination_subject", name: "course_subject_student_examination_FK_2", on_update: :cascade
  add_foreign_key "course_subject_student_mark", "course_subject_student", name: "course_subject_student_mark_ibfk_1", on_update: :cascade
  add_foreign_key "course_subject_student_mark", "course_subject_student", name: "course_subject_student_mark_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "course_subject_student_mark", "course_subject_student", name: "course_subject_student_mark_ibfk_3", on_update: :cascade, on_delete: :cascade
  add_foreign_key "course_subject_teacher", "course_subject", name: "course_subject_teacher_FK_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "course_subject_teacher", "teacher", name: "course_subject_teacher_FK_1", on_delete: :cascade
  add_foreign_key "division", "career_school_year", name: "division_FK_2", on_delete: :cascade
  add_foreign_key "division", "division_title", name: "division_FK_1"
  add_foreign_key "division", "shift", name: "division_FK_3", on_update: :cascade
  add_foreign_key "division_preceptor", "division", name: "division_preceptor_FK_2", on_delete: :cascade
  add_foreign_key "division_preceptor", "personal", column: "preceptor_id", name: "division_preceptor_FK_1"
  add_foreign_key "division_student", "division", name: "division_student_FK_2", on_delete: :cascade
  add_foreign_key "division_student", "student", name: "division_student_FK_1"
  add_foreign_key "examination", "school_year", name: "examination_FK_1", on_update: :cascade
  add_foreign_key "examination_repproved", "school_year", name: "examination_repproved_FK_1", on_update: :cascade
  add_foreign_key "examination_repproved_subject", "career_subject", name: "examination_repproved_subject_FK_2", on_update: :cascade
  add_foreign_key "examination_repproved_subject", "examination_repproved", name: "examination_repproved_subject_FK_1", on_update: :cascade
  add_foreign_key "examination_repproved_subject_teacher", "examination_repproved_subject", name: "examination_repproved_subject_teacher_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "examination_repproved_subject_teacher", "teacher", name: "examination_repproved_subject_teacher_FK_2", on_update: :cascade
  add_foreign_key "examination_subject", "career_subject_school_year", name: "examination_subject_FK_2", on_update: :cascade
  add_foreign_key "examination_subject", "examination", name: "examination_subject_FK_1", on_update: :cascade
  add_foreign_key "examination_subject_teacher", "examination_subject", name: "examination_subject_teacher_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "examination_subject_teacher", "teacher", name: "examination_subject_teacher_FK_2", on_update: :cascade
  add_foreign_key "head_personal_personal", "personal", column: "head_personal_id", name: "head_personal_personal_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "head_personal_personal", "personal", name: "head_personal_personal_FK_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "license", "license_type", name: "license_FK_2", on_update: :cascade
  add_foreign_key "license", "person", name: "license_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "optional_career_subject", "career_subject_school_year", column: "choice_career_subject_school_year_id", name: "optional_career_subject_FK_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "optional_career_subject", "career_subject_school_year", name: "optional_career_subject_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "person", "address", name: "person_FK_1", on_update: :cascade
  add_foreign_key "person", "sf_guard_user", column: "user_id", name: "person_FK_2", on_update: :cascade, on_delete: :nullify
  add_foreign_key "pm_module", "pm_configuration", name: "pm_module_FK_1", on_delete: :cascade
  add_foreign_key "school_year_student", "school_year", name: "school_year_student_FK_2"
  add_foreign_key "school_year_student", "shift", name: "school_year_student_FK_3", on_update: :cascade
  add_foreign_key "school_year_student", "student", name: "school_year_student_FK_1"
  add_foreign_key "sf_guard_group_permission", "sf_guard_group", column: "group_id", name: "sf_guard_group_permission_FK_1", on_delete: :cascade
  add_foreign_key "sf_guard_group_permission", "sf_guard_permission", column: "permission_id", name: "sf_guard_group_permission_FK_2", on_delete: :cascade
  add_foreign_key "sf_guard_remember_key", "sf_guard_user", column: "user_id", name: "sf_guard_remember_key_FK_1", on_delete: :cascade
  add_foreign_key "sf_guard_user_group", "sf_guard_group", column: "group_id", name: "sf_guard_user_group_FK_2", on_delete: :cascade
  add_foreign_key "sf_guard_user_group", "sf_guard_user", column: "user_id", name: "sf_guard_user_group_FK_1", on_delete: :cascade
  add_foreign_key "sf_guard_user_permission", "sf_guard_permission", column: "permission_id", name: "sf_guard_user_permission_FK_2", on_delete: :cascade
  add_foreign_key "sf_guard_user_permission", "sf_guard_user", column: "user_id", name: "sf_guard_user_permission_FK_1", on_delete: :cascade
  add_foreign_key "sf_guard_user_profile", "sf_guard_user", column: "user_id", name: "sf_guard_user_profile_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "state", "country", name: "state_FK_1"
  add_foreign_key "student", "health_coverage", name: "student_FK_3"
  add_foreign_key "student", "occupation", name: "student_FK_2"
  add_foreign_key "student", "person", name: "student_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "student_advice", "disciplinary_sanction_type", name: "student_advice_FK_2"
  add_foreign_key "student_advice", "person", column: "responsible_id", name: "student_advice_FK_4"
  add_foreign_key "student_advice", "person", column: "responsible_id", name: "student_advice_ibfk_1", on_delete: :nullify
  add_foreign_key "student_advice", "sanction_type", name: "student_advice_FK_3"
  add_foreign_key "student_advice", "school_year", name: "student_advice_FK_6"
  add_foreign_key "student_advice", "student", name: "student_advice_FK_1"
  add_foreign_key "student_approved_career_subject", "career_subject", name: "student_approved_career_subject_FK_1"
  add_foreign_key "student_approved_career_subject", "school_year", name: "student_approved_career_subject_FK_3"
  add_foreign_key "student_approved_career_subject", "student", name: "student_approved_career_subject_FK_2"
  add_foreign_key "student_approved_course_subject", "course_subject", name: "student_approved_course_subject_FK_1"
  add_foreign_key "student_approved_course_subject", "school_year", name: "student_approved_course_subject_FK_3"
  add_foreign_key "student_approved_course_subject", "student", name: "student_approved_course_subject_FK_2"
  add_foreign_key "student_approved_course_subject", "student_approved_career_subject", name: "student_approved_course_subject_FK_4", on_update: :cascade, on_delete: :cascade
  add_foreign_key "student_attendance", "absence_type", name: "student_attendance_FK_3"
  add_foreign_key "student_attendance", "career_school_year", name: "student_attendance_FK_1", on_update: :cascade
  add_foreign_key "student_attendance", "course_subject", name: "student_attendance_FK_4", on_update: :cascade, on_delete: :cascade
  add_foreign_key "student_attendance", "student", name: "student_attendance_FK_2", on_update: :cascade
  add_foreign_key "student_attendance", "student_attendance_justification", name: "student_attendance_FK_5", on_update: :cascade, on_delete: :nullify
  add_foreign_key "student_attendance_justification", "justification_type", name: "student_attendance_justification_FK_1", on_update: :cascade
  add_foreign_key "student_career_school_year", "career_school_year", name: "student_career_school_year_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "student_career_school_year", "student", name: "student_career_school_year_FK_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "student_career_school_year_conduct", "career_school_year_period", name: "student_career_school_year_conduct_FK_3", on_update: :cascade
  add_foreign_key "student_career_school_year_conduct", "conduct", name: "student_career_school_year_conduct_FK_2", on_update: :cascade
  add_foreign_key "student_career_school_year_conduct", "student_career_school_year", name: "student_career_school_year_conduct_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "student_career_subject_allowed", "career_subject", name: "student_career_subject_allowed_FK_1", on_update: :cascade
  add_foreign_key "student_career_subject_allowed", "student", name: "student_career_subject_allowed_FK_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "student_disapproved_course_subject", "course_subject_student", name: "student_disapproved_course_subject_FK_1"
  add_foreign_key "student_disapproved_course_subject", "student_approved_career_subject", name: "student_disapproved_course_subject_FK_2", on_update: :nullify, on_delete: :nullify
  add_foreign_key "student_examination_repproved_subject", "examination_repproved_subject", name: "student_examination_repproved_subject_FK_2", on_update: :cascade
  add_foreign_key "student_examination_repproved_subject", "student_repproved_course_subject", name: "student_examination_repproved_subject_FK_1", on_update: :cascade
  add_foreign_key "student_free", "career_school_year", name: "student_free_FK_3", on_update: :cascade
  add_foreign_key "student_free", "career_school_year_period", name: "student_free_FK_2", on_update: :cascade
  add_foreign_key "student_free", "course_subject", name: "student_free_FK_4", on_update: :cascade
  add_foreign_key "student_free", "student", name: "student_free_FK_1", on_update: :cascade
  add_foreign_key "student_reincorporation", "career_school_year_period", name: "student_reincorporation_FK_1", on_update: :cascade
  add_foreign_key "student_reincorporation", "course_subject", name: "student_reincorporation_FK_3", on_update: :cascade
  add_foreign_key "student_reincorporation", "student", name: "student_reincorporation_FK_2", on_update: :cascade
  add_foreign_key "student_repproved_course_subject", "course_subject_student", name: "student_repproved_course_subject_FK_1", on_update: :cascade
  add_foreign_key "student_repproved_course_subject", "student_approved_career_subject", name: "student_repproved_course_subject_FK_2", on_update: :cascade
  add_foreign_key "student_study", "student", name: "student_study_FK_1", on_delete: :cascade
  add_foreign_key "student_study", "study", name: "student_study_FK_2", on_delete: :cascade
  add_foreign_key "student_tag", "student", name: "student_tag_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "student_tag", "tag", name: "student_tag_FK_2", on_delete: :cascade
  add_foreign_key "student_tutor", "student", name: "student_tutor_FK_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "student_tutor", "tutor", name: "student_tutor_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sub_orientation", "orientation", name: "sub_orientation_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "subject_year_configuration", "subject_configuration", name: "subject_year_configuration_FK_1", on_delete: :cascade
  add_foreign_key "teacher", "person", name: "teacher_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "tutor", "occupation", name: "tutor_FK_2"
  add_foreign_key "tutor", "occupation_category", name: "tutor_FK_4"
  add_foreign_key "tutor", "person", name: "tutor_FK_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "tutor", "study", name: "tutor_FK_5"
  add_foreign_key "tutor", "tutor_type", name: "tutor_FK_3"
end
