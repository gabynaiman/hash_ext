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

end