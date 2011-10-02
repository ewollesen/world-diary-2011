require 'spec_helper'

describe PeopleController do

  context "authorization" do

    let(:private_person) {Factory.create("private_person")}
    let(:campaign) {private_person.campaign}
    let(:dm) {campaign.dm}
    let(:user) {Factory.create("user")}

    before do
      session["campaign_id"] = campaign.id
    end

    describe "GET new" do
      it "allows authenticated users" do
        sign_in dm

        get :new

        response.should render_template("new")
      end

      it "redirects guests to log in" do
        sign_out(:user)

        get :new

        response.should redirect_to(new_user_session_path)
      end
    end

    describe "POST create" do
      it "redirects guests to log in" do
        post :create, person: {}

        response.should redirect_to(new_user_session_path)
      end

      it "allows authenticated users" do
        person_attr = Factory.attributes_for("person", name: "Tenner",
                                                       campaign: campaign)
        sign_in dm

        post :create, person: person_attr

        response.should redirect_to(assigns("person"))
      end
    end

    context "with a private person" do
      it "redirects guests to log in" do
        sign_out(:user)

        get :show, {id: private_person.id}, {}, {}

        response.should redirect_to(new_user_session_path)
      end

      it "redirects unauthorized users to the home page" do
        sign_in user

        get :show, id: private_person.id

        response.should redirect_to(root_path)
      end

      it "allows the campaign's DM access" do
        sign_in dm

        get :show, id: private_person.id

        response.should render_template("show")
      end
    end
  end

end
