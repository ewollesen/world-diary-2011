require 'spec_helper'

describe User do

  subject {Factory.build("user")}

  it "requires a name" do
    subject.name = nil

    subject.should have(1).error_on("name")
  end

end
