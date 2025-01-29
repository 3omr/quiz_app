import 'package:get_it/get_it.dart';
import 'package:quiz_app/features/quiz/logic/quiz_cubit.dart';

GetIt getIt = GetIt.instance;

Future<void> getItSetup() async {
  getIt.registerLazySingleton(() => QuizCubit());
}
