require 'minitest_helper'

describe Hash::Normalized do

  Insensitive = Hash::Normalized.subclass { |key| key.to_s.downcase }

  it 'Case insensitive' do
    hash = Insensitive.new
    hash["A"] = 1
    hash[:B] = 2

    hash["a"].must_equal 1
    hash["A"].must_equal 1

    hash[:B].must_equal 2
    hash[:b].must_equal 2
  end

  it 'Merge' do
    h1 = Insensitive.new a: 100, b: 200
    h2 = Insensitive.new B: 254, c: 300
    m = h1.merge h2

    m[:a].must_equal 100
    m[:b].must_equal 254
    m[:c].must_equal 300
  end

  it 'Merge with block' do
    h1 = Insensitive.new a: 100, b: 200
    h2 = Insensitive.new B: 254, c: 300
    m = h1.merge(h2) { |key, oldval, newval | newval - oldval }

    m[:a].must_equal 100
    m[:b].must_equal 54
    m[:c].must_equal 300
  end

  it 'Update' do
    h1 = Insensitive.new a: 100, b:200
    h2 = Insensitive.new B: 254, c:300
    h1.update(h2)

    h1[:a].must_equal 100
    h1[:b].must_equal 254
    h1[:c].must_equal 300
  end

  it 'Update with block' do
    h1 = Insensitive.new a: 100, b:200
    h2 = Insensitive.new B: 254, c:300
    h1.update(h2) { |key, v1, v2| v1 }

    h1[:a].must_equal 100
    h1[:b].must_equal 200
    h1[:c].must_equal 300
  end

  it 'Custom instance normalization' do
    h = Hash::Normalized.new(a: 100, b: 200) { |k| k.to_s.upcase }
    h[:c] = {X: 1, y: {z: 2}}

    h[:a].must_equal 100
    h[:B].must_equal 200
    h[:c][:x].must_equal 1
    h[:c][:Y][:Z].must_equal 2
  end

  it 'Deep freeze' do
    h = Insensitive.new a: 1, b: [{x: 1}, {x: 2}], c: {x: 1, y: {z: 2}}
    h.deep_freeze

    h.must_be :frozen?
    h[:A].must_be :frozen?
    h[:b].must_be :frozen?
    h[:B][0].must_be :frozen?
    h['b'][0][:x].must_be :frozen?
    h['B'][1].must_be :frozen?
    h[:b][1]['X'].must_be :frozen?
    h[:c].must_be :frozen?
    h[:C][:x].must_be :frozen?
    h['c'][:Y].must_be :frozen?
    h['C']['y'][:Z].must_be :frozen?
  end

end