import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Профиль преподавателя', style: TextStyle(color: Color(0xFF3F3F8F))),
        iconTheme: const IconThemeData(color: Color(0xFF3F3F8F)),
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Профиль
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Нурислам Ильясов', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('nurislam@university.kz', style: textTheme.bodyMedium?.copyWith(color: Colors.black54)),
                    Text('Кафедра: Информатика', style: textTheme.bodyMedium?.copyWith(color: Colors.black54)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

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
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: const Color(0xFF3F3F8F),
        ),
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
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: const Color(0xFF3F3F8F).withOpacity(0.1),
          child: Icon(icon, color: const Color(0xFF3F3F8F)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
        onTap: () {
          // TODO: обработка нажатий
        },
      ),
    );
  }
}