import { showLoading, hideLoading } from 'react-redux-loading-bar'
import api from '../utils/api'
import roomChannel from '../utils/roomChannel.js'
import playerChannel from '../utils/playerChannel.js'

export const LOAD_INITIAL_STATE = 'LOAD_INITIAL_STATE'
export const RECEIVE_INITIAL_STATE = 'RECEIVE_INITIAL_STATE'

export function authenticate (navigateToRoom) {
  return (dispatch) => {
    dispatch(showLoading())
    return api.authenticate()
      .then(response => {
        const { room } = response.data.data

        if (room) {
          navigateToRoom(room.slug)
        }
        dispatch(hideLoading())
      })
  }
}

export function receiveInitialState (room, player, opponents, game) {
  return {
    type: RECEIVE_INITIAL_STATE,
    room: room,
    player: player,
    opponents: opponents,
    game: game
  }
}

export function loadInitialState (returnToLoginUnlessGame) {
  return dispatch => {
    dispatch(showLoading())
    return api.getGame()
      .then(response => {
        const { room, player, opponents, game } = response.data.data

        if (!returnToLoginUnlessGame(game)) {
          dispatch(receiveInitialState(room, player, opponents, game))
          roomChannel.subscribe(action => dispatch(action))
          playerChannel.subscribe(action => dispatch(action))
          dispatch(hideLoading())
        }
      })
  }
}

export function leaveRoom (navigateToLogin) {
  return dispatch => {
    return api.leaveRoom()
      .then(response => {
        navigateToLogin()

        dispatch(receiveInitialState(null, null, [], null))
      })
  }
}
