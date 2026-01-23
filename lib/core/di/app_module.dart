import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'app_module.config.dart';

final di = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: false,
  asExtension: true,
)
GetIt configureDependencies() => di..init();
