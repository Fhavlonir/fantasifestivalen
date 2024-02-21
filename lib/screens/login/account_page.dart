import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../utils/constants.dart';
import '../modmin/modminpage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  var _loading = false;
  var _isModmin = false;

  Future<void> _modminCheck() async {
    var _modminResponse = await supabase
      .from('modmins')
      .select(
          'id')
      .execute();
    setState((){_isModmin = (_modminResponse.data.length>0);});
  }
  
  Future<void> _signOut() async {
    try { 
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Ett oväntat fel uppstod: $error');
    }
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  @override
  void onAuthenticated(Session session) {
    final user = session.user;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _modminCheck();
    return Scaffold(
      appBar: AppBar(title: const Text('Konto')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          const SizedBox(height: 18),

          _isModmin?ElevatedButton(onPressed: (){
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ModminPage()));
          }, child: const Text('Modmin')):SizedBox.shrink(),
          const SizedBox(height: 18),
          ElevatedButton(onPressed: _signOut, child: const Text('Logga Ut')),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
