# frozen_string_literal: true

Hoge = Struct.new(:id, :name, keyword_init: true)
Fuga = Struct.new(:id, :name, keyword_init: true)

RSpec.describe FullJoin do
  it 'has a version number' do
    expect(FullJoin::VERSION).not_to be nil
  end

  describe 'Array#full_join' do
    context 'without block' do
      let(:array1) { [Hoge.new(id: 1), Hoge.new(id: 2), Hoge.new(id: 3)] }
      let(:array2) { [Hoge.new(id: 2), Hoge.new(id: 3), Hoge.new(id: 4)] }

      subject { array1.full_join(array2) }

      it 'to be full joined' do
        is_expected.to eq [
          [Hoge.new(id: 1), nil],
          [Hoge.new(id: 2), Hoge.new(id: 2)],
          [Hoge.new(id: 3), Hoge.new(id: 3)],
          [nil, Hoge.new(id: 4)]
        ]
      end
    end

    context 'with block' do
      let(:array1) do
        Array.new(3) do |i|
          Hoge.new(id: i + 1, name: (65 + i).chr.to_s * 3)
        end
      end
      let(:array2) do
        Array.new(3) do |i|
          Fuga.new(id: i + 1, name: (65 + 1 + i).chr.to_s * 3)
        end
      end

      subject { array1.full_join(array2, &:name) }

      it 'to be full joined' do
        is_expected.to eq [
          [Hoge.new(id: 1, name: 'AAA'), nil],
          [Hoge.new(id: 2, name: 'BBB'), Fuga.new(id: 1, name: 'BBB')],
          [Hoge.new(id: 3, name: 'CCC'), Fuga.new(id: 2, name: 'CCC')],
          [nil, Fuga.new(id: 3, name: 'DDD')]
        ]
      end
    end
  end
end
