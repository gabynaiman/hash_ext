require 'minitest_helper'

describe Hash::Sorted do

  def fill(hash)
    hash[:c] = 1
    hash[:a] = 2
    hash[:d] = 3
    hash[:b] = 4
  end

  it 'Ascending by key' do
    hash = Hash::Sorted.asc { |k,v| k }
    fill hash

    hash.keys.must_equal [:a, :b, :c, :d]
    hash.values.must_equal [2, 4, 1, 3]
  end

  it 'Descending by value' do
    hash = Hash::Sorted.desc { |k,v| v }
    fill hash

    hash.keys.must_equal [:b, :d, :a, :c]
    hash.values.must_equal [4, 3, 2, 1]
  end

  it 'Each' do
    hash = Hash::Sorted.asc { |k,v| k }
    fill hash

    hash.each.must_be_instance_of Enumerator

    list = []
    hash.each { |k,v| list << "#{k}:#{v}" }
    list.must_equal ['a:2', 'b:4', 'c:1', 'd:3']
  end

  it 'Each key' do
    hash = Hash::Sorted.asc { |k,v| k }
    fill hash

    hash.each_key.must_be_instance_of Enumerator

    list = []
    hash.each_key { |k| list << k }
    list.must_equal [:a, :b, :c, :d]
  end

  it 'Each value' do
    hash = Hash::Sorted.asc { |k,v| k }
    fill hash

    hash.each_value.must_be_instance_of Enumerator

    list = []
    hash.each_value { |v| list << v }
    list.must_equal [2, 4, 1, 3]
  end

  it 'To Hash' do
    hash = Hash::Sorted.asc { |k,v| k }
    fill hash

    h = hash.to_h
    h.must_be_instance_of Hash
    h.keys.must_equal [:a, :b, :c, :d]
    h.values.must_equal [2, 4, 1, 3]
  end

  it 'Deep freeze' do
    values = {a: 1, b: [{x: 1}, {x: 2}], c: {x: 1, y: {z: 2}}}
    h = Hash::Sorted.asc(values) { |k,v| k }
    h.deep_freeze

    h.must_be :frozen?
    h[:a].must_be :frozen?
    h[:b].must_be :frozen?
    h[:b][0].must_be :frozen?
    h[:b][0][:x].must_be :frozen?
    h[:b][1].must_be :frozen?
    h[:b][1][:x].must_be :frozen?
    h[:c].must_be :frozen?
    h[:c][:x].must_be :frozen?
    h[:c][:y].must_be :frozen?
    h[:c][:y][:z].must_be :frozen?
  end

end