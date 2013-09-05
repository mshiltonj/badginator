# Badginator

Badginator is a gem to add badges to a rails model. ALPHA.


## Installation

Add this line to your application's Gemfile:

    gem 'badginator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install badginator


**TODO: rails model migration generator**


## Usage

Define your badges in `config/initializers/badginator.rb`, using the Badginator.define_badge() method. Badges have a
unique `code`, which should be a ruby symbol, a name, a description, and a winning condition. All badges
are awarded to a *nominee* based on *condition* in a given *context*. You must define a badges `condition` as a lamda
that accepts a nominee and a context.

    Badginator.define_badge do
      code :first_blood
      name First Blood
      description  "Made your first kill"
      condition ->(nominee, context) {
        nominee.kills > 1
      }
    end

    Badginator.define_badge do
      code :hoarder
      name "Gold Hoarder"
      description  "You have collected over 100,000 gold!"
      condition ->(nominee, context) {
        nominee.gold > 100000
      }
    end

A class becomes eligible to be nominated when you include the Badginator::Nominee module:

    class Player
      include Badginator::Nominee

      [...]

    end

After that setup, you can try to award a player an award:

    result = player.try_award_badge(:hoarder, context) # context is optional

The result will have one of four states:

1. Did not win (no action taken)
2. Already won (player already has badge, no action taken)
3. Won (badge added)
4. Error (something went wrong)



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
