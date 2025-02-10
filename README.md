# React Native Atomic Button

**React Native Atomic Button** is a native component designed to prevent duplicate actions in your React Native applications. It is especially useful in scenarios such as e-commerce order submissions, where users on laggy devices might tap the submit button multiple times, triggering multiple backend requests. This component fires its onPress callback only once and then immediately disables itself to ensure that only one action is processed—even if the user (or simulated code) spams the button.

> **Key Features:**
> - **Atomic (One-Shot) Behavior:** Once pressed, the button disables itself to prevent any subsequent taps.
> - **Native Integration:** Implements native behavior on iOS (and Android if extended) to closely mimic a user’s real touch event.
> - **Dynamic Styling & Text Injection:** Accepts standard React Native style props and a `title` prop to display text.
> - **Simulation Methods for Testing:** Exposes a method to simulate native taps so you can test burst scenarios.
> - **Reset Functionality:** Includes a method to reset the button so it can be reused (useful for development and testing).

## Table of Contents

- [Installation](#installation)
- [Setup](#setup)
  - [Expo Projects (Bridgeless Mode)](#expo-projects-bridgeless-mode)
  - [Plain React Native Projects](#plain-react-native-projects)
- [Usage](#usage)
  - [Basic Usage](#basic-usage)
  - [Styling and Text Injection](#styling-and-text-injection)
  - [Resetting the Button](#resetting-the-button)
- [Testing Multiple Submits](#testing-multiple-submits)
- [Example Code](#example-code)
- [Troubleshooting](#troubleshooting)
- [Compatibility & Considerations](#compatibility--considerations)
- [How to Download and Get Started](#how-to-download-and-get-started)
- [License](#license)

Installation
Using npm
bash
Copy
npm install react-native-atomic-button
Using Yarn
bash
Copy
yarn add react-native-atomic-button
After installing, if you are targeting iOS, navigate to your project’s ios folder and run:

bash
Copy
cd ios && pod install && cd ..
Setup
For Expo Projects (Bridgeless Mode)
This package is compatible with both plain React Native and Expo projects. In Expo projects, it dynamically uses the NativeModulesProxy from the expo-modules-core package if available. No extra configuration is needed—just ensure you have installed the package as above.

For Plain React Native Projects
If you are not using Expo, the package will fall back to using React Native’s built‑in NativeModules. In both cases, the component automatically loads the correct native module accessor.

Usage
Basic Usage
Import the component and use it in your code:

jsx
Copy
import React, { useState, useRef } from 'react';
import { View, Text, Button, StyleSheet } from 'react-native';
import AtomicButton from 'react-native-atomic-button';

export default function TestScreen() {
  const [pressCount, setPressCount] = useState(0);
  const atomicButtonRef = useRef(null);

  const handlePress = () => {
    setPressCount(prev => prev + 1);
    console.log('Atomic button pressed count:', pressCount + 1);
  };

  return (
    <View style={styles.container}>
      <Text style={styles.counterText}>Press count: {pressCount}</Text>
      <AtomicButton
        ref={atomicButtonRef}
        onPress={handlePress}
        testID="atomicButton"
        title="Submit Order"
        style={styles.button}
      />
      {/* Additional buttons for testing (see below) */}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  counterText: {
    fontSize: 24,
    marginBottom: 20,
  },
  button: {
    width: 250,
    height: 50,
    backgroundColor: 'blue',
    justifyContent: 'center',
    alignItems: 'center',
  },
});
Styling and Text Injection
Unlike typical React Native components, custom native components may not automatically render children. Instead, AtomicButton uses a title prop to display text. You can style it using the standard style prop:

jsx
Copy
<AtomicButton
  onPress={handlePress}
  testID="atomicButton"
  title="Submit Order"
  style={{
    width: 250,
    height: 50,
    backgroundColor: 'blue',
    justifyContent: 'center',
    alignItems: 'center',
  }}
/>
Resetting the Button
Since the AtomicButton is designed to disable itself after a single tap (to prevent duplicate submissions), you might need to reset it for testing or reusability. You can call the reset method on the component reference:

jsx
Copy
<Button title="Reset Button" onPress={() => {
  if (atomicButtonRef.current && atomicButtonRef.current.reset) {
    atomicButtonRef.current.reset();
  }
}} />
Testing Multiple Submits
To simulate a burst of user interactions (for example, due to laggy devices), you can programmatically simulate multiple taps. The component exposes a method called simulateNativeTap() that triggers the native tap simulation.

Here’s a sample function that simulates 20 rapid native taps:

jsx
Copy
const simulate20NativeTaps = async () => {
  if (atomicButtonRef.current && atomicButtonRef.current.simulateNativeTap) {
    for (let i = 0; i < 20; i++) {
      atomicButtonRef.current.simulateNativeTap();
      // A small delay between taps (e.g., 10ms) to mimic rapid taps.
      await new Promise(resolve => setTimeout(resolve, 10));
    }
  } else {
    console.warn("AtomicButton reference is not set.");
  }
};
Add a button to your TestScreen for simulation:

jsx
Copy
<Button title="Simulate 20 Native Taps" onPress={simulate20NativeTaps} />
Expected Behavior:

Normal Use: When the button is tapped (manually or via simulation), it should call the onPress callback once, disable itself, and increment the counter only once.
Rapid Tapping: Even if you simulate or spam 20 taps, only the first tap is processed—preventing duplicate submissions.
Example Code
Below is a complete sample TestScreen demonstrating all of the features:

jsx
Copy
import React, { useState, useRef } from "react";
import { Text, View, Button, StyleSheet } from "react-native";
import AtomicButton from "react-native-atomic-button";

export default function TestScreen() {
  const [pressCount, setPressCount] = useState(0);
  const atomicButtonRef = useRef(null);

  const handlePress = () => {
    setPressCount(prev => {
      const newCount = prev + 1;
      console.log("Atomic button pressed count:", newCount);
      return newCount;
    });
  };

  const simulate20NativeTaps = async () => {
    if (atomicButtonRef.current && atomicButtonRef.current.simulateNativeTap) {
      for (let i = 0; i < 20; i++) {
        atomicButtonRef.current.simulateNativeTap();
        // Delay between taps to simulate rapid but sequential touches.
        await new Promise(resolve => setTimeout(resolve, 10));
      }
    } else {
      console.warn("AtomicButton reference is not set.");
    }
  };

  const resetButton = () => {
    if (atomicButtonRef.current && atomicButtonRef.current.reset) {
      atomicButtonRef.current.reset();
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.counterText}>Press count: {pressCount}</Text>
      <AtomicButton
        ref={atomicButtonRef}
        onPress={handlePress}
        testID="atomicButton"
        title="Submit Order"
        style={styles.button}
      />
      <Button title="Simulate 20 Native Taps" onPress={simulate20NativeTaps} />
      <Button title="Reset Button" onPress={resetButton} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    padding: 20,
  },
  counterText: {
    fontSize: 24,
    marginBottom: 20,
  },
  button: {
    width: 250,
    height: 50,
    backgroundColor: "blue",
    justifyContent: "center",
    alignItems: "center",
  },
});
How to Download and Get Started
Download the Package:

You can download the package from npm:

bash
Copy
npm install react-native-atomic-button
or

bash
Copy
yarn add react-native-atomic-button
Linking (for iOS):

Navigate to your ios folder and run:

bash
Copy
cd ios && pod install && cd ..
Using the Component:

Import the component in your React Native code:

js
Copy
import AtomicButton from 'react-native-atomic-button';
For Expo Projects:

No additional linking is needed. The package dynamically uses Expo’s NativeModulesProxy if available.

Test the Component:

Use the provided sample scripts (see the Example Code section) to verify that the AtomicButton behaves as expected—processing only one tap and preventing multiple submits.

Compatibility and Considerations
Purpose:
Designed for preventing duplicate actions on laggy devices, such as multiple order submissions.

One-Shot Behavior:
The button disables itself after the first press. If you need to allow multiple submissions (e.g., for testing), use the provided reset method.

Backend Safeguards:
While the AtomicButton prevents multiple taps, you should also implement backend safeguards (e.g., idempotency keys) to handle any edge cases.

Styling and Customization:
You can style the AtomicButton using standard React Native style props and set the button’s text using the title prop.

Troubleshooting
Simulation Not Working:
If you find that simulating taps does not trigger the onPress callback, ensure that:
Your native module is properly rebuilt and linked.
You are using the latest version of the package.
You’ve followed the clean and rebuild instructions (clean iOS build, run pod install, clear Metro cache).
Expo Compatibility:
In Expo projects (bridgeless mode), the package automatically uses NativeModulesProxy from expo-modules-core. If you encounter issues, verify that your Expo SDK version is compatible.
