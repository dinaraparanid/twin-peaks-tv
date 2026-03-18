import 'dart:js_interop';

import 'package:twin_peaks_tv/core/log/app_logger.dart';
import 'package:web/web.dart' as web;

void setupWebGLContextLostListener() {
  final fltGlassPane = web.document.querySelector('flt-glass-pane');
  final canvas = fltGlassPane?.shadowRoot?.querySelector('canvas');

  if (canvas == null) {
    AppLogger.instance.w('Canvas is null');
    return;
  }

  canvas.addEventListener(
    'webglcontextlost',
    (web.Event event) {
      AppLogger.instance.w('WebGL Context Lost Detected');
      event.preventDefault();
    }.toJS,
  );
}
