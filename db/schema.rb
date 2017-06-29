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

ActiveRecord::Schema.define(version: 20170612222612) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administradors", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_administradors_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_administradors_on_reset_password_token", unique: true, using: :btree
  end

  create_table "carteirinhas", force: :cascade do |t|
    t.integer  "via"
    t.string   "status"
    t.string   "categoria"
    t.date     "data_emissao"
    t.date     "data_vencimento"
    t.integer  "cid_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["cid_id"], name: "index_carteirinhas_on_cid_id", using: :btree
  end

  create_table "cids", force: :cascade do |t|
    t.string   "cod_doenca"
    t.string   "nome_doenca"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "documentos", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "cpf_file_name"
    t.string   "cpf_content_type"
    t.integer  "cpf_file_size"
    t.datetime "cpf_updated_at"
    t.string   "rg_file_name"
    t.string   "rg_content_type"
    t.integer  "rg_file_size"
    t.datetime "rg_updated_at"
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
    t.string   "cid_file_name"
    t.string   "cid_content_type"
    t.integer  "cid_file_size"
    t.datetime "cid_updated_at"
    t.string   "comp_residencia_file_name"
    t.string   "comp_residencia_content_type"
    t.integer  "comp_residencia_file_size"
    t.datetime "comp_residencia_updated_at"
  end

  create_table "enderecos", force: :cascade do |t|
    t.string   "cep"
    t.string   "cidade"
    t.string   "bairro"
    t.string   "logradouro"
    t.integer  "numero"
    t.string   "complemento"
    t.integer  "pessoa_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["pessoa_id"], name: "index_enderecos_on_pessoa_id", using: :btree
  end

  create_table "pessoas", force: :cascade do |t|
    t.string   "nome"
    t.string   "sexo"
    t.string   "rg"
    t.date     "data_nascimento"
    t.string   "telefone"
    t.string   "celular"
    t.integer  "usuario_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["usuario_id"], name: "index_pessoas_on_usuario_id", using: :btree
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "cpf",                                 null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["cpf"], name: "index_usuarios_on_cpf", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "carteirinhas", "cids"
  add_foreign_key "enderecos", "pessoas"
  add_foreign_key "pessoas", "usuarios"
end
