import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/profile/profile_bloc.dart';
import '../services/user_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provê o ProfileBloc para esta tela e seus filhos
    return BlocProvider(
      create: (context) => ProfileBloc(
        // O UserService pode ser pego de um RepositoryProvider no main.dart
        // ou instanciado aqui para simplicidade.
        userService: UserService(),
      )..add(ProfileFetchRequested()), // Dispara o evento para buscar dados
      child: Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            // Se estiver carregando, mostra um indicador de progresso
            if (state is ProfileLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            // Se carregar com sucesso, mostra os dados
            if (state is ProfileLoadSuccess) {
              final user = state.user;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Text(
                        user.nome.isNotEmpty ? user.nome[0].toUpperCase() : 'U',
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Nome Completo'),
                      subtitle: Text(user.nome),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: Text(user.email),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.badge),
                      title: const Text('Tipo de Conta'),
                      subtitle: Text(user.tipo),
                    ),
                    const Divider(),
                    const SizedBox(height: 24),
                    ListTile(
                      leading: const Icon(Icons.description, color: Colors.blueAccent),
                      title: const Text('Meus Documentos'),
                      subtitle: const Text('Anexar e gerenciar seus documentos'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navegar para a tela de documentos
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.shield_outlined),
                      title: const Text('Segurança'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    const Divider(),

                    // --- Botão de Logout ---
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red.shade400),
                      title: Text(
                        'Sair',
                        style: TextStyle(color: Colors.red.shade400),
                      ),
                      onTap: () {
                        // Dispara o evento de logout para o AuthBloc
                        context.read<AuthBloc>().add(AuthLogoutRequested());
                      },
                    ),
                  ],
                ),
              );
            }
            // Se der erro, mostra a mensagem de falha
            if (state is ProfileLoadFailure) {
              return Center(child: Text('Erro ao carregar perfil: ${state.error}'));
            }
            // Estado inicial
            return const Center(child: Text('Iniciando...'));
          },
        ),
      ),
    );
  }
}