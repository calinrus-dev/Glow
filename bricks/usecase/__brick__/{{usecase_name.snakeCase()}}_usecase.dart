import 'package:glow_core/glow_core.dart';

{{#has_params}}
class {{usecase_name}}Usecase extends BaseUsecase<void, {{usecase_name}}Params> {
  const {{usecase_name}}Usecase();

  @override
  Future<Result<void, Failure>> call({{usecase_name}}Params params) async {
    // TODO: Implement use case logic
    throw UnimplementedError();
  }
}

class {{usecase_name}}Params {
  const {{usecase_name}}Params();
}
{{/has_params}}{{^has_params}}
class {{usecase_name}}Usecase extends BaseUsecase<void, NoParams> {
  const {{usecase_name}}Usecase();

  @override
  Future<Result<void, Failure>> call(NoParams params) async {
    // TODO: Implement use case logic
    throw UnimplementedError();
  }
}
{{/has_params}}
