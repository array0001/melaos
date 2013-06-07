require 'spec_helper'

describe "RuteoAmigables" do
  it "should redirigir a la pagina que se pide antes de iniciar sesion" do
    user = FactoryGirl.create(:user)
    visit edit_user_path(user)
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button
    response.should render_template('users/edit')
  end
end
