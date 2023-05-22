import React from "react";
import PropTypes from "prop-types";

class Text extends React.Component {
  render() {
    const { size, color, value } = this.props;
    const style = `text-${size} text-${color}`;

    return(
      <p className={style}>{value}</p>
    )
  }
}

export default Text;
