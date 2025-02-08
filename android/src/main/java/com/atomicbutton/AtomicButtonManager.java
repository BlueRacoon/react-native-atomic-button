// File: android/src/main/java/com/atomicbutton/AtomicButtonManager.java
package com.atomicbutton;

import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;

public class AtomicButtonManager extends SimpleViewManager<AtomicButtonView> {
    public static final String REACT_CLASS = "AtomicButton";

    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    protected AtomicButtonView createViewInstance(ThemedReactContext reactContext) {
        return new AtomicButtonView(reactContext);
    }

    // If you want to expose a "reset" command to JS, add:
    @Override
    public void receiveCommand(AtomicButtonView view, int commandId, com.facebook.react.bridge.ReadableArray args) {
        if (commandId == 1) { // For example, command id 1 means "reset"
            view.reset();
        }
    }

    @Override
    public java.util.Map<String, Integer> getCommandsMap() {
        return java.util.Collections.singletonMap("reset", 1);
    }
}
