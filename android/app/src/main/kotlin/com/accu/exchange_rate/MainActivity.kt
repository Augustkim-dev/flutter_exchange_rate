package com.accu.exchange_rate

import android.os.Build
import android.os.Bundle
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsControllerCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Enable edge-to-edge display using WindowCompat (recommended for Android 15+)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        
        // Configure system bars appearance for Android 15+ compatibility
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController?.let {
            // Set system bars appearance based on theme
            it.isAppearanceLightStatusBars = true  // or false for dark content
            it.isAppearanceLightNavigationBars = true  // or false for dark content
        }
    }
}