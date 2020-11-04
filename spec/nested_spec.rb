require 'minitest_helper'

describe Hash::Nested do

  it 'Default value is hash' do
    hash = Hash::Nested.new

    hash[:undefined].must_equal Hash.new
  end

  it 'Keept assigned value' do
    hash = Hash::Nested.new

    hash[:key] = 'value'

    hash[:key].must_equal 'value'
  end

  it 'Allow set nested hash levels' do
    hash = Hash::Nested.new

    hash[:level_1][:level_2][:level_3] = 'test'

    hash.must_equal level_1: {level_2: {level_3: 'test'}}
  end

  it 'Deep freeze' do
    hash = Hash::Nested.new
    hash[:level_1][:level_2][:level_3] = 'test'

    hash.deep_freeze

    hash[:level_1].must_be :frozen?
    hash[:level_1][:level_2].must_be :frozen?
    hash[:level_1][:level_2][:level_3].must_be :frozen?
  end

end