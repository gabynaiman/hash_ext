require 'coverage_helper'
require 'minitest/autorun'
require 'turn'
require 'pry-nav'
require 'hash_ext'

Turn.config do |c|
  c.format = :pretty
  c.natural = true
  c.ansi = true
end