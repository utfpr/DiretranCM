require 'rails_helper'

RSpec.describe "cids/new", type: :view do
  before(:each) do
    assign(:cid, Cid.new(
      :codigo => "MyString",
      :nome_doenca => "MyString"
    ))
  end

  it "renders new cid form" do
    render

    assert_select "form[action=?][method=?]", cids_path, "post" do

      assert_select "input#cid_codigo[name=?]", "cid[codigo]"

      assert_select "input#cid_nome_doenca[name=?]", "cid[nome_doenca]"
    end
  end
end
