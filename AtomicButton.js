// AtomicButton.js
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

  // Expose a method to simulate a native tap.
  simulateNativeTap() {
    const viewTag = findNodeHandle(this._ref);
    if (viewTag) {
      const config = UIManager.getViewManagerConfig('AtomicButton');
      if (config && config.Commands && config.Commands.simulateTap != null) {
        UIManager.dispatchViewManagerCommand(
          viewTag,
          config.Commands.simulateTap,
          [] // no arguments needed
        );
      } else {
        console.warn('simulateTap command not found in AtomicButton configuration');
      }
    }
  }

  render() {
    return (
      <NativeAtomicButton
        ref={(ref) => { this._ref = ref; }}
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
};

export default AtomicButton;
