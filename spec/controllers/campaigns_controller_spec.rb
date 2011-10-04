require 'spec_helper'

describe CampaignsController do

  context "authorization" do

    let(:private_campaign) {Factory.create("private_campaign")}
    let(:user) {Factory.create("user")}
    let(:dm) {private_campaign.dm}

    describe "GET new" do
      it "allows authenticated users" do
        @user = Factory.create("user")
        sign_in @user
        get :new

        response.should render_template("new")
      end

      it "redirects guests to log in" do
        get :new

        response.should redirect_to(new_user_session_path)
      end
    end

    describe "POST create" do
      it "redirects guests to log in" do
        post :create, :campaign => Factory.attributes_for("campaign")

        response.should redirect_to(new_user_session_path)
      end

      it "allows authenticated users" do
        sign_in user
        post :create, :campaign => Factory.attributes_for("campaign")

        response.should redirect_to(assigns("campaign"))
      end
    end

    context "with a private campaign" do
      it "redirects guests to log in" do
        get :show, :id => private_campaign.id

        response.should redirect_to(new_user_session_path)
      end

      it "redirects unauthorized users to the home page" do
        private_campaign # creates dm as the first (admin) user
        sign_in user
        get :show, :id => private_campaign.id

        response.should redirect_to(root_path)
      end

      it "allows the campaign's DM access" do
        sign_in dm
        get :show, :id => private_campaign.id

        response.should render_template("show")
      end
    end
  end

end
