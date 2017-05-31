require 'rails_helper'

RSpec.describe "documentos/edit", type: :view do
  before(:each) do
    @documento = assign(:documento, Documento.create!())
  end

  it "renders the edit documento form" do
    render

    assert_select "form[action=?][method=?]", documento_path(@documento), "post" do
    end
  end
end
