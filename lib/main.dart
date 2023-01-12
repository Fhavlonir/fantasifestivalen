import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://tquhibsbxumaqfttipmr.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTY0NDE3NzU1MSwiZXhwIjoxOTU5NzUzNTUxfQ.UUa0Zoa9TwkX4b8yhaKk5KQhKXE9dUire8WdI_MKRYs',
      debug: true);
  runApp(const Fantamello());
}
