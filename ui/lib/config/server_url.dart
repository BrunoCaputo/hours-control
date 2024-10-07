import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

String serverApiBaseUrl =
    kIsWeb || !Platform.isAndroid ? "http://localhost:3000" : "http://10.0.2.2:3000";
