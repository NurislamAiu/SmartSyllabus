import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль преподавателя'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Профилььььььььь
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/avatar_placeholder.png'), // замените на ваш путь
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Нурислам Ильясов', style: textTheme.titleMedium),
                  const Text('nurislam@university.kz'),
                  const Text('Кафедра: Информатика'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          _SectionTitle('🔧 Настройки'),
          const _SettingTile(title: 'Изменить пароль', icon: Icons.lock_outline),
          const _SettingTile(title: 'Язык интерфейса', icon: Icons.language),
          const _SettingTile(title: 'Тёмная тема', icon: Icons.dark_mode),

          const SizedBox(height: 24),
          _SectionTitle('📥 Документы'),
          const _SettingTile(title: 'Скачать договор', icon: Icons.download_outlined),
          const _SettingTile(title: 'Методичка по силабусам', icon: Icons.book_outlined),

          const SizedBox(height: 24),
          _SectionTitle('🔐 Безопасность'),
          const _SettingTile(title: 'Выйти из аккаунта', icon: Icons.exit_to_app),

          const SizedBox(height: 24),
          _SectionTitle('📞 Поддержка'),
          const _SettingTile(title: 'Связаться с деканатом', icon: Icons.support_agent),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SettingTile({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // TODO: обработка нажатий
      },
    );
  }
}
