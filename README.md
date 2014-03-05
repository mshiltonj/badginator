# Badginator

Badginator is a gem to add "badges" (or "trophies" or "achievements") to any model
of a Rails application, like User or Player. Useful for game-oriented applications.


## Installation

Add this line to your application's Gemfile and `bundle install`:

    gem 'badginator'

Once installed run the install generator:

    $ rails g badginator:install

This generates a model and migration for AwardedBadges. Be sure the run the migration:

    $ rake db:migrate


## Usage

Define your badges in `config/initializers/badginator.rb`, using the Badginator.define_badge() method. All badges
are awarded to a *nominee* based on *condition* in a given *context*.

```ruby
Badginator.define_badge do
  code :first_blood
  name First Blood
  description  "Made your first kill"
  condition ->(nominee, context) {
    nominee.kills > 1
  }
  reward 1
  image "http:://example.org/images/first_blood_badge.gif"
  level :bronze
end

Badginator.define_badge do
  code :hoarder
  name "Gold Hoarder"
  description  "You have collected over 100,000 gold!"
  condition ->(nominee, context) {
    nominee.gold > 100000
  }
  reward 10
  image "http://example.org/images/hoarder_badge.gif"
end
```
A class becomes eligible to be nominated when you include the Badginator::Nominee module:
```ruby
class Player
  include Badginator::Nominee

  [...]

end
```
After that setup, you are ready to go!

Try to award a player an award:
```ruby
status = player.try_award_badge(:hoarder, context) # context is optional
```
The result will have one of four states:

1. Did not win (no action taken)
2. Already won (player already has badge, no action taken)
3. Won (badge added)
4. Error (something went wrong)

If the badges was awarded, the return status has the badge attached:
```ruby
if status.code == Badginator::WON
  awarded_badge = status.awarded_badge
end
```
The `awarded_badge` is an ActiveRecord object, and has the defined badge attached to it:
```ruby
awarded_badge.badge.code #=> :hoarder

awarded_badge.reward     #=> 10
```

You can get a list of badges the player has won:
```ruby
player.badges
```

Lastly, you can get a list of all available badges (minus the disabled ones):
```ruby
Badginator.badges
```

## Properties
Badges have a few properties:
#### code
A ruby symbol. Each defined badge must be unique across your badge set

#### disabled
A boolean. You may want to disable a badge if it no longer applies, A disabled badge will never be awarded and will
 not show up in a global badge list. Awardees will still be able to see their own disabled badges if they have them.

#### description
A human readable string.

#### condition
A lamda that accepts a `nominee` and a `context`. Should evaluate to a boolean.
This determines whether or not the nominee won the award. This lambda should have no effects.

#### level
Optional declaration of the difficulty level of the badge for use by the application.
Can be anything, a numeric value (1,2,3,5,8) or string value (bronze, silver, gold, platinum).

It is useful to assign a numeric value here, so you can sum the level of all a players badge's for an
overall score or reputation.

#### image
Optional url of image or code used for a graphic of the badge

#### reward
An optional lambda that gets called and returned as a part of a status object when the badge is awarded.
Also takes the two `nominee` and `context` params. This lambda should have no effects. Use the return value in
application code to actually assign rewards.

This could be a numeric value like bonus points or gold. Or and in-game object to add to a Player's inventory.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
