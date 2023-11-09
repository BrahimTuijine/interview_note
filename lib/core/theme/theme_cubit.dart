import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<bool> {
  ThemeCubit() : super(true);

  void toggleTheme() {
    emit(!state);
  }

  @override
  bool? fromJson(Map<String, dynamic> json) {
    return json['isDark'];
  }

  @override
  Map<String, dynamic>? toJson(bool state) {
    return {'isDark': state};
  }
}
