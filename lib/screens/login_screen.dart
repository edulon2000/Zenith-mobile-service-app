import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Pega os estilos de texto e cores do tema global que definimos
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // O fundo agora é branco, controlado pelo tema
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Ícone do App, agora usando a cor primária do tema (preto)
              Icon(
                Icons.handyman_rounded,
                size: 80,
                color: colorScheme.primary, // MODIFICADO
              ),
              const SizedBox(height: 16),

              // Título, usando o estilo e a cor do tema
              Text(
                'Zenith',
                textAlign: TextAlign.center,
                style: textTheme.headlineLarge, // MODIFICADO
              ),
              const SizedBox(height: 8),

              // Subtítulo, usando a cor do tema
              Text(
                'Conectando você aos melhores profissionais.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: Colors.black54), // MODIFICADO
              ),
              const SizedBox(height: 64),

              // Botão de Login com Google
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    // O indicador agora usa a cor primária do tema (preto)
                    return Center(child: CircularProgressIndicator(color: colorScheme.primary));
                  }

                  return Center(
                    child: InkWell(
                      onTap: () {
                        context.read<AuthBloc>().add(AuthGoogleSignInRequested());
                      },
                      customBorder: const CircleBorder(),
                      child: Image.asset(
                        'assets/google_logo.png',
                        height: 55.0,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}