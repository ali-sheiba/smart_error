require "spec_helper"

RSpec.describe SmartError do
  it "has a version number" do
    expect(SmartError::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
