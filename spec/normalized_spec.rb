require 'minitest_helper'

describe Hash::Normalized do
  
  Insensitive = Hash::Normalized.subclass { |key| key.to_s.downcase }

  it 'case insensitive' do
    hash = Insensitive.new 
    hash["A"] = 1
    hash[:B] = 2

    hash["a"].must_equal 1
    hash["A"].must_equal 1

    hash[:B].must_equal 2
    hash[:b].must_equal 2
  end

  it 'merge' do
    h1 = Insensitive.new a: 100, b: 200
    h2 = Insensitive.new B: 254, c: 300
    m = h1.merge h2 

    m[:a].must_equal 100
    m[:b].must_equal 254
    m[:c].must_equal 300
  end

  it 'merge with block' do
    h1 = Insensitive.new a: 100, b: 200
    h2 = Insensitive.new B: 254, c: 300
    m = h1.merge(h2) { |key, oldval, newval | newval - oldval }

    m[:a].must_equal 100
    m[:b].must_equal 54
    m[:c].must_equal 300
  end

  it 'update' do
    h1 = Insensitive.new a: 100, b:200
    h2 = Insensitive.new B: 254, c:300
    h1.update(h2)

    h1[:a].must_equal 100
    h1[:b].must_equal 254
    h1[:c].must_equal 300
  end

  it 'update with block' do
    h1 = Insensitive.new a: 100, b:200
    h2 = Insensitive.new B: 254, c:300
    h1.update(h2) { |key, v1, v2| v1 }

    h1[:a].must_equal 100
    h1[:b].must_equal 200
    h1[:c].must_equal 300
  end

end