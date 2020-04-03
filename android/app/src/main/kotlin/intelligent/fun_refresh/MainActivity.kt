package intelligent.fun_refresh

import android.content.Intent
import android.content.pm.ShortcutInfo
import android.content.pm.ShortcutManager
import android.graphics.drawable.Icon
import android.os.Build.VERSION.SDK_INT
import android.os.Build.VERSION_CODES.N_MR1
import android.os.Bundle
import android.view.View
import android.view.WindowManager
import androidx.annotation.RequiresApi
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        if (SDK_INT >= N_MR1) {
            addShortCutMenu()
        }
    }

    @RequiresApi(N_MR1)
    fun addShortCutMenu() {
        val shortcutManager = getSystemService(ShortcutManager::class.java)
        @Suppress("SpellCheckingInspection")
        shortcutManager.dynamicShortcuts =
            listOf(
                shortIcon(iconID = R.drawable.ic_dino, label = "恐龙快跑", route = "dinosaur_run"),
                shortIcon(iconID = R.drawable.snake, label = "贪吃蛇", route = "game_snake"),
                shortIcon(iconID = R.drawable.ic_tetris, label = "俄罗斯方块", route = "game_tetris"),
                shortIcon(iconID = R.drawable.flappy, label = "飞翔的小鸟", route = "flappy_bird"),
                shortIcon(iconID = R.drawable.game2048, label = "2048", route = "game2048"),
                shortIcon(iconID = R.drawable.sudoku, label = "数独", route = "sudoku"),
                shortIcon(iconID = R.drawable.bejeweled, label = "宝石迷阵", route = "bejeweled")
            )
    }

    @RequiresApi(N_MR1)
    fun shortIcon(label: String = "", route: String = "", iconID: Int = 0x0): ShortcutInfo =
        ShortcutInfo.Builder(this, route)
            .setShortLabel(label)
            .setIcon(Icon.createWithResource(this, iconID))
            .setIntent(
                Intent(
                    this, MainActivity::class.java
                ).setAction(Intent.ACTION_RUN).putExtra("route", "/$route")
                    .setFlags(
                        Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_CLEAR_TASK
                    )
            ).build()

    override fun onPause() {
        window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_FULLSCREEN
        super.onPause()
    }

    override fun onResume() {
        window.clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
        super.onResume()
    }
}
