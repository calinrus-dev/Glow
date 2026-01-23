import 'bootstrap/bootstrap.dart';
import 'config/app_environment.dart';

void main() async {
  EnvironmentConfig.initialize(AppEnvironment.dev);
  await bootstrap();
}
