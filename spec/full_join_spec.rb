# frozen_string_literal: true

Hoge = Struct.new(:id, keyword_init: true)

RSpec.describe FullJoin do
  it 'has a version number' do
    expect(FullJoin::VERSION).not_to be nil
  end

  describe 'Array#full_join' do
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
end
