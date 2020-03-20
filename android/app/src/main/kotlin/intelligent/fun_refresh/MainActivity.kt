package intelligent.fun_refresh

import android.os.Bundle
import android.view.View
import android.view.WindowManager
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_FULLSCREEN
        GeneratedPluginRegistrant.registerWith(this)
    }

//    override fun onPause() {
//        window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_FULLSCREEN
//        super.onPause()
//    }
//
//    override fun onResume() {
//        window.clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
//        super.onResume()
//    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        window.clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
    }
}
