require 'minitest_helper'

describe Hash::Builder do
  
  it 'Build' do
    hash = Hash::Builder.build do |h|
      h.a 1
      h.b true
      h.c do
        h.d :abc
        h.e do
          h.f ['x', 'y']
        end
      end
    end

    hash.must_equal a: 1, 
                    b: true, 
                    c: {
                      d: :abc, 
                      e: {
                        f: ['x', 'y']
                      }
                    }
  end

end