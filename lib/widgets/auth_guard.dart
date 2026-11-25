import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

/// Ensures the user is authenticated,
/// pushing LoginScreen when needed.
Future<bool> ensureLoggedIn(BuildContext context) async {
  // Check whether the user is already logged in.
  if (context.read<AuthState>().isLoggedIn) {
    return true;
  }

  // If not logged in, open LoginScreen.
  final loggedIn = await Navigator.push<bool>(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );

  // Return the login result.
  return loggedIn ?? false;
}
