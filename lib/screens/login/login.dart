import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

import '../../utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _emailController;
  late final StreamSubscription<AuthState> _authStateSubscription;
  
  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_emailController.text == 'test@fantamello.se') {
        await supabase.auth.signInWithPassword(
          email: _emailController.text,
          password: 'testtest',
          //emailRedirectTo:
          //  kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
        );
        if (mounted) {
          context.showSnackBar(message: 'Loggar in på testkontot...');
          _emailController.clear();
        }
      } else {
        await supabase.auth.signInWithOtp(
          email: _emailController.text,
          emailRedirectTo:
            kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
        );
        if (mounted) {
          context.showSnackBar(message: 'Kolla mailen för inloggningslänk!');
          _emailController.clear();
        }
      }
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Oväntat fel upstod');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/teampage');
      }
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logga In')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          const Text('Skriv in din mailaddress för att få en inloggningslänk'),
          const SizedBox(height: 18),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'E-postaddress'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _isLoading ? null : _signIn,
            child: Text(_isLoading ? 'Laddar' : 'Skicka magisk länk'),
          ),
        ],
      ),
    );
  }
}
