require_relative "spec_helper"

describe "Badginator" do

  it "can reset the singleton for tests" do
    badginator1 = Badginator.instance
    badginator2 = Badginator.instance

    expect(badginator1.object_id).to eql(badginator2.object_id)

    reset_badginator
    badginator3 = Badginator.instance

    expect(badginator3.object_id).to_not eql(badginator2.object_id)
  end

  describe "when defining a badge" do
    before(:each) do
      reset_badginator
      @thecode = thecode = :foo_badge
      @thename = thename = "Foo"

      @badge1 = Badginator.define_badge do
        code thecode
        name thename
        description "Foo'd something"
        condition ->(nominee, context) {
          return true
        }
      end

    end

    it "return a badge definition" do
      expect(@badge1.name).to eql( @thename)
    end

    it "can call the condition" do
      expect(@badge1.condition.call(nil, nil)).to be_true
    end

    it "can not define the same badge code twice" do

      expect {
        thecode = @thecode
        thename = @thename
        other_badge = Badginator.define_badge do
          code thecode
          name thename
          description "Foo'd something"
          condition ->(nominee, context) {
            return true
          }
        end
      }.to raise_error
    end

    describe "when awarding a badge" do
      before(:each) do

        @badge_to_win = badge_to_win = :contest_winner

        @badge2 = Badginator.define_badge do
          code badge_to_win
          name "Won A Contest"
          description "We have a winner over here"
          condition ->(nominee, context) {
            nominee.winner?
          }
         end

        @nominee = double('nominee')

      end

      it "should checking for a winning condition" do
        @nominee = Nominee.new

        @nominee.should_receive(:winner?).and_return(true)

        @nominee.try_award_badge(@badge_to_win)
      end
    end
  end
end
