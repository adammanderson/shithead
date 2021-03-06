class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:destroy]

  def show
    player = Player.find_by(id: cookies.encrypted[:player_id])

    if player && player.game.abandoned?
      cookies.delete(:player_id)
      disconnect(player)
      player = nil
    end

    render json: Serializers::Responses::State.new(player).to_h
  end

  def destroy
    player = Player.find_by(id: cookies.encrypted[:player_id])
    if player
      if game = player.game
        game.abandoned!
        PlayerBroadcast.game_abandoned(game.players)
      end
    end
    head :ok
  end

  def disconnect(player)
    ActionCable.server.remote_connections
               .where(current_player: player)
               .disconnect
  end
end
