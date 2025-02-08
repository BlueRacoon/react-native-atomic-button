// File: AtomicButton.js
import React from 'react';
import { requireNativeComponent, UIManager, findNodeHandle } from 'react-native';
import PropTypes from 'prop-types';

const NativeAtomicButton = requireNativeComponent('AtomicButton');

class AtomicButton extends React.Component {
  constructor(props) {
    super(props);
    this._onPress = this._onPress.bind(this);
  }

  _onPress(event) {
    if (this.props.onPress) {
      this.props.onPress(event);
    }
  }

  // Expose a method to reset the native button
  reset() {
    UIManager.dispatchViewManagerCommand(
      findNodeHandle(this._ref),
      UIManager.getViewManagerConfig('AtomicButton').Commands.reset,
      []
    );
  }

  render() {
    return (
      <NativeAtomicButton
        ref={ref => { this._ref = ref; }}
        {...this.props}
        onPress={this._onPress}
      >
        {this.props.children}
      </NativeAtomicButton>
    );
  }
}

AtomicButton.propTypes = {
  onPress: PropTypes.func,
  style: PropTypes.any,
  // Add any additional prop types you want to support
};

export default AtomicButton;
