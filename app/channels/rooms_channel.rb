class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from room
  end

  def player_is_ready(data)
    player = Player.find(data['dispatchAction']['opponent_id'])
    player.update!(is_ready: true)
    game = player.game
    if Policies::GameReadyToStart.new(game).check?
      game.playing!
      Dealer.new(game).deal
      PlayerBroadcast.receive_initial_state(game.players)
    else
      RoomBroadcast.new(room).rebroadcast(data)
    end
  end

  def unsubscribed
  end

  private

  def room
    "rooms_#{current_player.room.slug}"
  end
end
