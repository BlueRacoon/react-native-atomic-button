import React from 'react';
import {
  requireNativeComponent,
  UIManager,
  findNodeHandle,
  NativeModules as RNNativeModules,
} from 'react-native';
import PropTypes from 'prop-types';

// Dynamically select the native modules accessor.
let NativeModulesAccessor;

// First, try using expo-modules-core’s NativeModulesProxy
try {
  const { NativeModulesProxy } = require('expo-modules-core');
  if (NativeModulesProxy && NativeModulesProxy.AtomicButton) {
    NativeModulesAccessor = NativeModulesProxy;
  } else {
    throw new Error("AtomicButton not found on NativeModulesProxy");
  }
} catch (e) {
  // Fall back to react-native's NativeModules
  NativeModulesAccessor = RNNativeModules;
}

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

  simulateNativeTap() {
    const viewTag = findNodeHandle(this._ref);
    if (viewTag) {
      if (
        NativeModulesAccessor &&
        NativeModulesAccessor.AtomicButton &&
        typeof NativeModulesAccessor.AtomicButton.simulateDirectTap === 'function'
      ) {
        NativeModulesAccessor.AtomicButton.simulateDirectTap(viewTag);
      } else {
        console.warn(
          'simulateDirectTap not found in NativeModulesAccessor.AtomicButton'
        );
      }
    } else {
      console.warn("AtomicButton reference is not set.");
    }
  }

  reset() {
    const viewTag = findNodeHandle(this._ref);
    if (viewTag) {
      const config = UIManager.getViewManagerConfig('AtomicButton');
      if (config && config.Commands && config.Commands.reset != null) {
        UIManager.dispatchViewManagerCommand(
          viewTag,
          config.Commands.reset,
          []
        );
      } else {
        console.warn('reset command not found in AtomicButton configuration');
      }
    }
  }

  render() {
    return (
      <NativeAtomicButton
        ref={(ref) => { this._ref = ref; }}
        {...this.props}
        onPress={this._onPress}
      />
    );
  }
}

AtomicButton.propTypes = {
  onPress: PropTypes.func,
  title: PropTypes.string,
  style: PropTypes.any,
};

export default AtomicButton;
