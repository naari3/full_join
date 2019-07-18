# frozen_string_literal: true

# extension original class
class Array
  # Returns a new array full joined other.
  #
  # @return [Array] a new array full joined other.
  #
  # @example
  #   Hoge = Struct.new(:id, keyword_init: true)
  #   array1 = [Hoge.new(id: 1), Hoge.new(id: 2), Hoge.new(id: 3)]
  #   array2 = [Hoge.new(id: 2), Hoge.new(id: 3), Hoge.new(id: 4)]
  #   array1.full_join(array2) #=> [
  #     [#<struct Hoge id=1>, nil]
  #     [#<struct Hoge id=2>, #<struct Hoge id=2>]
  #     [#<struct Hoge id=3>, #<struct Hoge id=3>]
  #     [nil, #<struct Hoge id=4>]
  #   ]
  def full_join(other)
    results = each_with_object([]) do |obj1, arr|
      found = false
      other.each do |obj2|
        next unless obj1 == obj2

        arr << [obj1, obj2]
        found = true
        break
      end
      arr << [obj1, nil] unless found
    end

    other.each do |obj2|
      results << [nil, obj2] if
        results.map { |a| a.compact.include? obj2 }.none?
    end

    results
  end
end
