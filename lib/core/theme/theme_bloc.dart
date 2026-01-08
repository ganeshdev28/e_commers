import 'package:flipcart/core/theme/taheme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(false)) {
    on<ToggleTheme>((event, emit) {
      emit(ThemeState(!state.isDark));
    });
  }
}
