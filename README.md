# Karel Interpreter

A interpreter for programs written in the Apartment List dialect of Karel.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'karel-interpreter'
```

## Usage

The interpreter takes a single file as an argument and prints out the final state
of the Karel grid after executing the program.

### Example

```
# square_dance.krl
move
put
turn_left
move
turn_left
move
put
turn_left
move
```

```
% karel square_dance.krl
location: (0, 0)
direction: right
tokens: [{"location"=>"(-1, 0)", "count"=>1}, {"location"=>"(0, 1)", "count"=>1}]
operations: 9
```

### Output

* Location - location of Karel when the program finishes
* Direction - direction Karel is facing when the program finishes
* Tokens - location and counts of all tokens left on the grid
* Operation - number of built-in commands executed

## Karel Language Specification: Apartment List Dialect

Karel is a creature that lives on an infinite two dimensional grid. Using built-in
commands as the basic building blocks, rudimentary control flow, and user-defined
commands, programs can move Karel around the grid and place and remove tokens from
squares on the grid.

The Karel language is case-sensitive and indentation-sensitive. All built-in commands
and reserved words for control flow and user-defined commands are lower case. Statements
within the body of control flow branches and user-defined commands must be indented
two spaces beyond the containing branch/command definition. Only one statement is
allowed per line. Blank lines are permitted.

Comments begin with a `#` and continue to the end of the line. Comments can be placed
on their own line or after a statement.

### Built-in commands

The following commands are available out of the box.

* `move` - Move Karel one square forward in the direction she is facing
* `turn_left` - Turn Karel left (CCW) 90 degrees
* `token?` - Return `true` if there is one or more tokens on Karel's current location, otherwise false
* `pick` - Pick up one token from Karel's current location. If there are no tokens, this command will crash the program.
* `put` - Put one token down on Karel's current location.

### Control flow

Karel responds to `if`/`else` branching and `while` loops. The condition evaluated for
these two control flow structures can be negated with a `!` (no spaces are allowed between
the negation operator and the condition)

#### Example: a basic `if` statement

```
if token?
  pick
end
```

#### Example: `if`/`else`

```
if token?
  pick
else
  move
end
```

#### Example: negated condition

```
if !token?
  put
end
```

#### Example: nested `if`

```
if token?
  pick
  if token?
    move
  end
end
```

#### Example: nested `while`

```
# This will safely remove all tokens from a square.
while token?
  pick
end
```

### User-defined commands

The Karel language supports user-defined commands, though these commands do not take
arguments and do not return a value. Commands are defined as follows

```
def turn_around
  turn_left
  turn_left
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/karel-interpreter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Karel::Interpreter project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/karel-interpreter/blob/master/CODE_OF_CONDUCT.md).
