require_relative "spec_helper"

describe "Badginator::Badge" do

  before :each do
    reset_badginator
    Badginator.define_badge do
      code :one
      description "ONE"
      condition ->(nominee, context) {
        true
      }
    end

    Badginator.define_badge do
      code :two
      description "TWO"
      condition ->(nominee, context) {
        true
      }
    end

    Badginator.define_badge do
      code :three
      description "THREE"
      condition ->(nominee, context) {
        true
      }
    end

    Badginator.define_badge do
      code :four
      description "FOUR"
      condition ->(nominee, context) {
        true
      }
      disabled true
    end

    Badginator.define_badge do
      code :five
      description "FIVE"
      condition ->(nominee, context) {
        true
      }
    end
  end

  it "will show a list of all available badges" do
    expect(Badginator.badges.size).to eql(4)

  end

end
