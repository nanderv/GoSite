import React from 'react'
import PropTypes from 'prop-types'

import styled, { keyframes } from 'styled-components';
const Wrapper = styled.div`
	padding: 2rem 1rem;
	font-size: 1.2rem;
	padding: 2em;
	background: ${props => props.alt ? 'papayawhip' : 'palevioletred'};
	&:after {
      content: " 🦄";
      clear: both;
      float: left;
    }
`;
const Blob = ({ id, text }) => (
    <Wrapper alt={id%2===0}>{text}</Wrapper>
)

Blob.propTypes = {
    id: PropTypes.number.isRequired,
    text: PropTypes.string.isRequired
}

export default Blob