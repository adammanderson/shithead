import React, { Fragment } from 'react'
import HandSelect from './OpponentTop/HandSelect'

function OpponentTop (props) {
  const { hasSelectedHand, faceUpCards, hand } = props.opponent

  return (
    <div>
      { !hasSelectedHand && <HandSelect faceUpCards={faceUpCards}
                                        hand={hand} /> }
    </div>
  )
}

export default OpponentTop
