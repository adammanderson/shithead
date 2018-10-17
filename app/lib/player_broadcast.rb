class PlayerBroadcast
  def initialize(player)
    @player = player
  end
  
  def self.receiveInitialState(players)
    players.each do |player|
      new(player).receiveInitialState
    end
  end

  def receiveInitialState
    broadcast_action(
      Serializers::Actions::ReceiveInitialState.new(player).to_h)
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