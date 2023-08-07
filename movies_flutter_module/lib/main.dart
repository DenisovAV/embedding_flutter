import 'package:movies_flutter_module/me.dart';
import 'package:movies_flutter_module/me1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter_module/business/movies_bloc.dart';
import 'package:movies_flutter_module/framework/remote_controller.dart';
import 'package:movies_flutter_module/ui/focus/extensions.dart';
import 'package:movies_flutter_module/ui/focus/scale_widget.dart';
import 'package:movies_flutter_module/ui/movies_screen.dart';
import 'package:movies_flutter_module/ui/widgets/platform.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MoviesApp(
    screen: MoviesScreen(),
  ));
}

@pragma("vm:entry-point")
void showMoviesScreen() {
  runApp(const MoviesApp(
    screen: MoviesScreen(),
  ));
}

@pragma("vm:entry-point")
void showMoviesDetails() {
  runApp(const MoviesApp(
    screen: MoviesDetails(),
  ));
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({required Widget this.screen, Key? key}) : super(key: key);

  final Widget screen;

  @override
  Widget build(BuildContext context) {
    print(MyPlatform.isAndroidTV);
    print(kTvSize.width);
    print(width);
    print(pixelRatio);
    return MaterialApp(
      home: BlocProvider<MoviesBloc>(
          create: (_) => MoviesBloc()..add(MoviesEvent.initializing),
          child: isScaled
              ? ScaleWidget(
                  child: screen,
                )
              : screen),
    );
  }
}
