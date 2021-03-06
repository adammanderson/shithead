class PlayerBroadcast
  def initialize(player)
    @player = player
  end
  
  def self.receive_initial_state(players)
    players.each do |player|
      new(player).receive_initial_state
    end
  end

  def self.game_abandoned(players)
    players.each do |player|
      new(player).game_abandoned
    end
  end

  def self.opponent_made_play(opponent)
    opponent.opponents.each do |player|
      new(player).opponent_made_play(opponent)
    end
  end

  def self.opponent_picked_up_pile(opponent)
    opponent.opponents.each do |player|
      new(player).opponent_picked_up_pile(opponent)
    end
  end

  def self.opponent_flipped_card(opponent)
    opponent.opponents.each do |player|
      new(player).opponent_flipped_card(opponent)
    end
  end

  def receive_initial_state
    broadcast_action(
      Serializers::Actions::ReceiveInitialState.new(player).to_h)
  end

  def game_abandoned
    broadcast_action(
      Serializers::Actions::GameAbandoned.new.to_h)
  end

  def player_made_play
    broadcast_action(
      Serializers::Actions::PlayerMadePlay.new(player).to_h)
  end

  def opponent_made_play(opponent)
    broadcast_action(
      Serializers::Actions::OpponentMadePlay.new(player, opponent).to_h)
  end

  def player_picked_up_pile
    broadcast_action(
      Serializers::Actions::PlayerPickedUpPile.new(player).to_h)
  end

  def opponent_picked_up_pile(opponent)
    broadcast_action(
      Serializers::Actions::OpponentPickedUpPile.new(player, opponent).to_h)
  end

  def player_flipped_card
    broadcast_action(
      Serializers::Actions::PlayerFlippedCard.new(player).to_h)
  end

  def opponent_flipped_card(opponent)
    broadcast_action(
      Serializers::Actions::OpponentFlippedCard.new(opponent).to_h)
  end

  private

  attr_reader :player

  def channel
    "player_#{player.id}"
  end

  def broadcast_action(action)
    ActionCable.server.broadcast(channel, dispatchAction: action)
  end
end
