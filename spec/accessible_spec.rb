require 'minitest_helper'

describe Hash::Accessible do
  
  it 'Get and Set' do
    hash = Hash::Accessible.new

    hash.key_1 = 1
    hash[:key_1].must_equal 1

    hash['key_2'] = 2
    hash.key_2.must_equal 2
  end

  it 'Nested Hash' do
    hash = Hash::Accessible.new a: 1, b: {c: 2, d: {f: 3}}

    hash.a.must_equal 1
    hash.b.c.must_equal 2
    hash.b.d.f.must_equal 3
  end

  it 'Nested array' do
    hash = Hash::Accessible.new a: 1, b: [2, {c: 3}]

    hash.a.must_equal 1
    hash.b[0].must_equal 2
    hash.b[1].c.must_equal 3
  end

  it 'Nested hash post initialization' do
    hash = Hash::Accessible.new

    hash.a = {}
    hash.a.must_equal Hash.new

    hash.a.b = 1 
    hash.a.c = 2
    hash.d = {}

    hash.a.b.must_equal 1
    hash.a.c.must_equal 2
    hash.d.must_equal Hash.new
    hash[:a][:b].must_equal 1
  end

  it 'Nested array post initialization' do 
    hash = Hash::Accessible.new

    hash.a = []
    hash.a.must_equal []
    hash[:a].must_equal []
    
    hash.a << 3
    hash.a.size.must_equal 1
    hash.a[0].must_equal 3
  end

  it 'Deep freeze' do
    h = Hash::Accessible.new a: 1, b: [{x: 1}, {x: 2}], c: {x: 1, y: {z: 2}}
    h.deep_freeze

    h.must_be :frozen?
    h.a.must_be :frozen?
    h.b.must_be :frozen?
    h.b[0].must_be :frozen?
    h.b[0].x.must_be :frozen?
    h.b[1].must_be :frozen?
    h.b[1].x.must_be :frozen?
    h.c.must_be :frozen?
    h.c.x.must_be :frozen?
    h.c.y.must_be :frozen?
    h.c.y.z.must_be :frozen?
  end

end