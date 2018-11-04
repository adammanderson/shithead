import React from 'react'
import styled from 'styled-components'

const Container = styled.div`
  margin: 6px;
  cursor: pointer;
  max-height: 120px;
  border-radius: 4px;
  position: relative;
  text-align: center;
`

const Image = styled.img`
  height: 100%;
`

const Text = styled.div`
  color: white;
  font-size: 30px;
  text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
`

export default function CardPile ({ size }) {
  return (
    <Container>
      <Image className='card'
             src={'/assets/cards/Blue_Back.svg'} />
      <Text>{size}</Text>
    </Container>
  )
}