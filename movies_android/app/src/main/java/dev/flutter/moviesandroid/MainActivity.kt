package dev.flutter.moviesandroid

import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.Star
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FabPosition
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import dev.flutter.moviesandroid.ui.theme.Movies_androidTheme
import io.flutter.embedding.android.FlutterView
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlin.random.Random

class MainActivity : ComponentActivity(), EngineBindingsDelegate {

    private lateinit var showMoviesScreenEngine: FlutterViewEngine
    private lateinit var showMoviesDetailsEngine: FlutterViewEngine
    private lateinit var sink: EventChannel.EventSink

    private val moviesBindings: EngineBindings by lazy {
        EngineBindings(activity = this, delegate = this, entrypoint = "showMoviesScreen")
    }

    private val detailsBindings: EngineBindings by lazy {
        EngineBindings(activity = this, delegate = this, entrypoint = "showMoviesDetails")
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        showMoviesScreenEngine = FlutterViewEngine(moviesBindings.engine)
        showMoviesScreenEngine.attachToActivity(this)

        showMoviesDetailsEngine = FlutterViewEngine(detailsBindings.engine)
        showMoviesDetailsEngine.attachToActivity(this)

        MethodChannel(showMoviesScreenEngine.engine.dartExecutor.binaryMessenger, "OPEN").setMethodCallHandler {
                call, result ->
            if (call.method == "CALL") {
                val name = call.argument<String>("NAME")
                sink.success(name)
            } else {
                result.notImplemented()
            }
        }

        EventChannel(showMoviesDetailsEngine.engine.dartExecutor, "MOVIES").setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(args: Any?, events: EventChannel.EventSink) {
                    sink = events
                }

                override fun onCancel(args: Any?) {
                    sink.endOfStream()
                }
            }
        )

        setContent {
            Movies_androidTheme() {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    EmbeddingAndroidComposable(showMoviesScreenEngine, showMoviesDetailsEngine)
                }
            }
        }
    }

    override fun onNext() {
        TODO("Not yet implemented")
    }
}

@Composable
fun FlutterComposable(flutterViewEngine: FlutterViewEngine, modifier: Modifier = Modifier,) {
    AndroidView(
        modifier = modifier, // Occupy the max size in the Compose UI tree
        factory = { context ->
            FlutterView(context).apply {
                flutterViewEngine.attachFlutterView(this)
            }
        },
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun EmbeddingAndroidComposable(flutterViewEngine: FlutterViewEngine, flutterViewEngine2: FlutterViewEngine) {
    Scaffold(
        content = { padding ->
            Column(
                modifier = Modifier.fillMaxSize(),
                verticalArrangement = Arrangement.Center,
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                val imageModifier = Modifier.size(200.dp)
                val flutterModifier = Modifier
                    .fillMaxWidth()
                    .height(250.dp)
                FlutterComposable(
                    flutterViewEngine = flutterViewEngine,
                    modifier = flutterModifier
                )
                Image(
                    painter = painterResource(id = R.drawable.android),
                    contentDescription = "Android",
                    contentScale = ContentScale.Fit,
                    modifier = imageModifier
                )
                Text(
                    text = "This is an example of simple Jetpack Compose application, created specifically for my talk",
                    modifier = Modifier.padding(16.dp),
                    textAlign = TextAlign.Center
                )
                FlutterComposable(
                    flutterViewEngine = flutterViewEngine2,
                    modifier = flutterModifier
                )
            }
        },
        floatingActionButtonPosition = FabPosition.End,
        floatingActionButton = {
            FloatingActionButton(onClick = {}) {
                Icon(
                    imageVector = Icons.Rounded.Star,
                    contentDescription = "Details",
                )
            }
        }
    )
}

/*@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    TestTheme {
        EmbeddingAndroidComposable()
    }
}*/