# Advent of Code 2020
## Robert Haines

My attempt at doing [Advent of Code 2020](http://adventofcode.com/2020) in Ruby, with tests and all the trimmings.

[![Maintainability](https://api.codeclimate.com/v1/badges/c5309e30ce5c9f6ed043/maintainability)](https://codeclimate.com/github/hainesr/aoc-2020/maintainability)

### Usage

After cloning, and changing into the `aoc-2020` directory, run:

```shell
$ gem install bundler
$ bundle install
$ rake
```

This will set everything up and run all the tests.

To run the solution for a particular day:

```shell
$ ./aoc-2020 <day>
```

Or via `rake`:

```shell
$ rake run <day>
```

You can run multiple days like this:

```shell
$ rake run <day_1> <day_2> ... <day_n>
```

### Licence

[Public Domain](http://unlicense.org).
