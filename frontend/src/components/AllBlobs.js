import React from 'react'
import PropTypes from 'prop-types'
import Blob from './Blob'
import { connect } from "react-redux";

const AllBlobs = ({blobs}) => (
    <div>
        {blobs?blobs.map(blob => (
            <Blob key={blob.id} {...blob} />
        )):"NOTHING"}
    </div>
)

AllBlobs.propTypes = {
    blobs: PropTypes.arrayOf(
        PropTypes.shape({
            id: PropTypes.number.isRequired,
            text: PropTypes.string.isRequired
        }).isRequired
    ).isRequired,
}

export default connect(
    (state, ownProps) => ({ blobs: state.blobs })
)(AllBlobs);

