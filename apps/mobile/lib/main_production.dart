import 'package:mobile/bootstrap.dart';
import 'package:mobile/src/app.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
