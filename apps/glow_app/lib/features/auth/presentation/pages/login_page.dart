import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bloc/auth_bloc.dart';

/// Login page.
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: _LoginView(),
        ),
      ),
    );
  }
}

class _LoginView extends ConsumerWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome to Glow',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 48),
        
        authState.maybeWhen(
          loading: () => const CircularProgressIndicator(),
          error: (message) => Text(
            message,
            style: const TextStyle(color: Colors.red),
          ),
          orElse: () => const SizedBox.shrink(),
        ),
        
        const SizedBox(height: 16),
        const _EmailField(),
        const SizedBox(height: 16),
        const _PasswordField(),
        const SizedBox(height: 24),
        const _LoginButton(),
      ],
    );
  }
}

class _EmailField extends ConsumerWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class _PasswordField extends ConsumerWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
      ),
      obscureText: true,
    );
  }
}

class _LoginButton extends ConsumerWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement login with actual email/password
          ref.read(authNotifierProvider.notifier).login('', '');
        },
        child: const Text('Login'),
      ),
    );
  }
}
