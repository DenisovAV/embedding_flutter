import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_flutter_module/business/movies_bloc.dart';
import 'package:movies_flutter_module/ui/movies_screen.dart';
import 'package:movies_flutter_module/util.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MoviesApp(
    screen: MoviesScreen(),
  ));
}

@pragma("vm:entry-point")
void showMoviesScreen() {
  runApp(
    const MoviesApp(
      screen: MoviesScreen(),
      mode: Mode.module_list,
    ),
  );
}

@pragma("vm:entry-point")
void showMoviesDetails() {
  runApp(
    const MoviesApp(
      screen: MoviesDetails(),
      mode: Mode.module_details,
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({
    required Widget this.screen,
    this.mode = Mode.standalone,
    Key? key,
  }) : super(key: key);

  final Widget screen;
  final Mode mode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<MoviesBloc>(
        create: (BuildContext context) =>
            MoviesBloc(context: context, mode: mode)..add(MoviesInitialEvent()),
        child: screen,
      ),
    );
  }
}
