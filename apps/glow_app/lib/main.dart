import 'bootstrap/app_bootstrap.dart';

void main() async {
  final bootstrap = AppBootstrap();
  await bootstrap.initialize();
  bootstrap.run();
}
