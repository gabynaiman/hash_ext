require 'minitest_helper'

describe Hash::Normalized do
  
  it 'case insensitive' do
    Insensitive = Hash::Normalized.subclass { |key| key.to_s.downcase }
    hash = Insensitive.new 
    hash["A"] = 1
    hash[:B] = 2

    hash["a"].must_equal 1
    hash["A"].must_equal 1

    hash[:B].must_equal 2
    hash[:b].must_equal 2
  end

end