// File: android/src/main/java/com/atomicbutton/AtomicButtonView.java
package com.atomicbutton;

import android.content.Context;
import android.util.AttributeSet;
import androidx.appcompat.widget.AppCompatButton;

public class AtomicButtonView extends AppCompatButton {
    private boolean isDisabled = false;

    public AtomicButtonView(Context context) {
        super(context);
    }

    public AtomicButtonView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public AtomicButtonView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    @Override
    public boolean performClick() {
        // Only allow click if not already disabled.
        if (!isDisabled) {
            isDisabled = true;
            // For visual feedback (optional): reduce opacity.
            setAlpha(0.5f);
            // Fire the click event.
            boolean result = super.performClick();
            return result;
        }
        return true;
    }

    // Public method to re-enable the button.
    public void reset() {
        isDisabled = false;
        setAlpha(1.0f);
    }
}
