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
  # @example
  #   Hoge = Struct.new(:id, :name, keyword_init: true)
  #   Fuga = Struct.new(:id, :name, keyword_init: true)
  #   array1 = [
  #     Hoge.new(id: 1, name: "AAA"),
  #     Hoge.new(id: 2, name: "BBB"),
  #     Hoge.new(id: 3, name: "CCC")
  #   ]
  #   array2 = [
  #     Fuga.new(id: 101, name: "BBB"),
  #     Fuga.new(id: 102, name: "CCC"),
  #     Fuga.new(id: 103, name: "DDD")
  #   ]
  #   array1.full_join(array2, &:name) #=> [
  #     [Hoge.new(id: 1, name: "AAA"), nil],
  #     [Hoge.new(id: 2, name: "BBB"), Fuga.new(id: 101, name: "BBB")],
  #     [Hoge.new(id: 3, name: "CCC"), Fuga.new(id: 102, name: "CCC")],
  #     [nil, Fuga.new(id: 103, name: "DDD")]
  #   ]
  def full_join(other, &block)
    block = ->(s) { s } unless block_given?

    results = each_with_object([]) do |obj1, arr|
      found = false
      other.each do |obj2|
        next unless block.call(obj1) == block.call(obj2)

        arr << [obj1, obj2]
        found = true
        break
      end
      arr << [obj1, nil] unless found
    end

    results.concat((other - results.map(&:last)).zip([]).map(&:reverse))
  end
end
