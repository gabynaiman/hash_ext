require 'minitest_helper'

describe Hash::Indifferent do
  
  it 'Get and Set' do
    hash = Hash::Indifferent.new

    hash['a'] = 1
    hash[:b] = 2

    hash[:a].must_equal 1
    hash['b'].must_equal 2
  end

  it 'Fetch' do
    hash = Hash::Indifferent.new

    hash['a'] = 1
    hash[:b] = 2

    hash.fetch(:a).must_equal 1
    hash.fetch('b').must_equal 2
    hash.fetch(:c, 3).must_equal 3
    hash.fetch('c') { 4 }.must_equal 4
    proc { hash.fetch(:c) }.must_raise KeyError
  end

  it 'Include key' do
    hash = Hash::Indifferent.new

    hash['a'] = 1
    hash[:b] = 2

    hash.key?(:a).must_equal true
    hash.key?('a').must_equal true
    
    hash.key?(:b).must_equal true
    hash.key?('b').must_equal true

    hash.key?(:c).must_equal false
    hash.key?('c').must_equal false
  end

  it 'Delete' do
    hash = Hash::Indifferent.new

    hash['a'] = 1
    hash[:b] = 2

    hash.key?(:a).must_equal true
    value = hash.delete :a
    value.must_equal 1
    hash.key?(:a).must_equal false

    hash.key?('b').must_equal true
    value = hash.delete 'b'
    value.must_equal 2
    hash.key?('b').must_equal false

    hash.key?(:c).must_equal false
    hash.key?('c').must_equal false
    value = hash.delete :c
    value.must_be_nil
  end

  it 'Merge' do
    hash = Hash::Indifferent.new

    hash['a'] = 1
    hash[:b] = 2

    other_hash = hash.merge a: 3

    hash.must_equal a: 1, b: 2
    other_hash.must_equal a: 3, b: 2
  end

  it 'Dig' do
    hash = Hash::Indifferent.new a: 1, b: [{x: 1}, {x: 2}], c: {x: 1, y: {z: 2}}

    hash.dig('a').must_equal 1
    hash.dig(:w).must_be_nil
    
    hash.dig('c', :y, 'z').must_equal 2
    hash.dig('c', :w, 'z').must_be_nil
    
    hash.dig(:b, 0, :x).must_equal 1
    hash.dig(:b, 3, :x).must_be_nil
  end

  it 'Build from other hash' do
    hash = Hash::Indifferent.new 'a' => 1, b: 2

    hash[:a].must_equal 1
    hash['b'].must_equal 2
  end

  it 'Nested hashes' do
    hash = Hash::Indifferent.new

    hash['a'] = {'x' => {'y' => 'z'}}
    hash[:b] = [{hello: :world}]

    hash[:a][:x][:y].must_equal 'z'
    hash['b'][0]['hello'].must_equal :world
  end

  it 'Neested to_h' do
    indifferent_hash = Hash::Indifferent.new 'x' => {'y' => ['z', { 'a' => 1 }]}
    hash = indifferent_hash.to_h

    hash.instance_of?(Hash).must_equal true
    hash[:x].instance_of?(Hash).must_equal true
    hash[:x][:y][1].instance_of?(Hash).must_equal true
  end

  it 'Marshal' do
    hash = Hash::Indifferent.new 'a' => 1, b: 2

    Marshal.load(Marshal.dump(hash)).must_equal hash
  end

  it 'Deep freeze' do
    h = Hash::Indifferent.new a: 1, b: [{x: 1}, {x: 2}], c: {x: 1, y: {z: 2}}
    h.deep_freeze

    h.must_be :frozen?

    h[:a].must_be :frozen?
    h[:b].must_be :frozen?
    h[:b][0].must_be :frozen?
    h['b'][0][:x].must_be :frozen?
    h['b'][1].must_be :frozen?
    h[:b][1]['x'].must_be :frozen?
    h[:c].must_be :frozen?
    h[:c][:x].must_be :frozen?
    h['c'][:y].must_be :frozen?
    h['c']['y'][:z].must_be :frozen?
  end

end