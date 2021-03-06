import React, { Component, Fragment } from 'react'
import styled from 'styled-components'
import api from '../utils/api'
import HandSelect from './Player/HandSelect'
import Hand from './Player/Hand'
import FaceUpCards from './Player/FaceUpCards'
import FaceDownCards from './Player/FaceDownCards'

const Footer = styled.div`
  display: flex;
  flex-flow: row nowrap;
  justify-content: space-around;
  align-content: center;
`

const LeaveButton = styled.button`
  display: inline-block;
  padding: 6px 12px;
  margin-bottom: 0;
  font-size: 14px;
  font-weight: 400;
  line-height: 1.4;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  cursor: pointer;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: ${props => props.disabled ? 'green' : 'black'};
  border-color: ${props => props.disabled ? 'green' : 'black'};
  width: 70px;
  height: 50px;
  visibility: ${props => props.hidden ? 'hidden' : 'visible'};
`

const Name = styled.p`
  color: ${props => props.isTurn ? 'green' : 'black'};
`

class Player extends Component {
  renderFaceDownCards () {
    const { hasSelectedHand, faceDownCards, faceUpCards } = this.props
    const showFaceDownCards = !hasSelectedHand || !faceUpCards.length

    return (
      <Fragment>
        { showFaceDownCards && <FaceDownCards cards={faceDownCards} /> }
      </Fragment>
    )
  }

  renderHandSelect () {
    const { hasSelectedHand } = this.props

    return (
      <Fragment>
        { !hasSelectedHand && <HandSelect/> }
      </Fragment>
    )
  }

  renderFaceUpCards () {
    const { hasSelectedHand, faceUpCards, handHasCards } = this.props
    const showFaceUpCards = hasSelectedHand && faceUpCards.length > 0

    return (
      <Fragment>
        { showFaceUpCards && <FaceUpCards canPlayCards={!handHasCards} cards={faceUpCards} /> }
      </Fragment>
    )
  }

  renderHand () {
    const { hasSelectedHand, handHasCards } = this.props
    const showHand = hasSelectedHand && handHasCards

    return (
      <Fragment>
        { showHand && <Hand/> }
      </Fragment>
    )
  }

  renderFooter () {
    const { name } = this.props
    const { leaveGame } = api

    return (
      <Footer>
        <LeaveButton onClick={leaveGame}>Leave</LeaveButton>
        <Name>{name}</Name>
        <LeaveButton hidden></LeaveButton>
      </Footer>
    )
  }

  render () {
    const { hasSelectedHand, faceDownCards, faceUpCards, hand } = this.props

    return (
      <div>
        { this.renderFaceDownCards() }
        { this.renderFaceUpCards() }
        { this.renderHandSelect() }
        { this.renderHand() }
        { this.renderFooter() }
      </div>
    )
  }
}

export default Player
