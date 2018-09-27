require 'rails_helper'

describe JoinGame do
  describe '::in' do
    let(:room_name) { 'Gaming room' }

    it 'creates new room if room does not exists' do
      JoinGame.in(room_name)
      expect(Room.find_by(name: room_name)).to be_present
    end

    it "creates an instance with the current game if status is 'joining'" do
      room = create(:room, :joining, name: room_name).reload
      expect(JoinGame).to receive(:new).with(room.game)
      JoinGame.in(room_name)
    end

    it "creates an instance with the a new game if status is 'ended'" do
      room = create(:room, :ended, name: room_name)
      expect(JoinGame).to receive(:new).with(
        having_attributes(status: Game::Status::JOINING))
      JoinGame.in(room_name)
    end

    it "raises an error if a game is in progress" do
      room = create(:room, :playing, name: room_name)
      expect { JoinGame.in(room_name) }.to raise_error(
        JoinGame::Errors::GAME_IN_PROGRESS)
    end
  end

  describe '#add' do
    let(:room) { create(:room, :joining).reload }
    let(:player_name) { 'Rick' }

    it 'adds a new player to a game' do
      JoinGame.in(room.name).add(player_name)
      expect(room.game.players.last.name).to eq(player_name)
    end
  end
end
