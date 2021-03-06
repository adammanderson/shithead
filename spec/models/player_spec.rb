require 'rails_helper'

describe Player do
  context 'associations' do
    it { is_expected.to belong_to(:game) }
    it { is_expected.to have_one(:room).through(:game) }
  end

  context 'validations' do
    it { should validate_uniqueness_of(:name).scoped_to(:game_id) }
  end

  describe '#opponents' do
    it 'returns the other players in this game' do
      player = build(:player)
      opponent = build(:player)
      create(:game, players: [player, opponent])

      expect(player.opponents).to eq([opponent])
    end
  end
end
