import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Панель декана'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Переход к уведомлениям
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Добро пожаловать, декан 👋', style: textTheme.titleLarge),
          const SizedBox(height: 16),

          _SectionTitle('📥 Последние уведомления'),
          _NotificationTile(text: 'Силабус по "История Казахстана" отправлен на проверку'),
          _NotificationTile(text: 'Экзамен по "Физика 1" обновлён преподавателем'),

          const SizedBox(height: 24),
          _SectionTitle('🎯 Быстрые действия'),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _ActionButton(title: 'Силабусы', icon: Icons.menu_book, onTap: () {}),
              _ActionButton(title: 'Экзамены', icon: Icons.assignment, onTap: () {}),
              _ActionButton(title: 'Преподаватели', icon: Icons.group, onTap: () {}),
              _ActionButton(title: 'Отчёты', icon: Icons.bar_chart, onTap: () {}),
            ],
          ),

          const SizedBox(height: 24),
          _SectionTitle('📌 Избранные документы'),
          _FavoriteTile(
            title: 'Информатика 1 — Силабус',
            status: 'Ожидает проверки',
            color: Colors.orange,
          ),
          _FavoriteTile(
            title: 'Биология — Экзамен',
            status: 'На доработке',
            color: Colors.redAccent,
          ),

          const SizedBox(height: 24),
          _SectionTitle('📅 События'),
          _NotificationTile(text: '5 мая — Крайний срок по силабусам'),
          _NotificationTile(text: '10 мая — Отчёт по кафедрам'),
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
    return Text(title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600));
  }
}

class _NotificationTile extends StatelessWidget {
  final String text;
  const _NotificationTile({required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.notifications_none),
      title: Text(text),
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  final String title;
  final String status;
  final Color color;

  const _FavoriteTile({
    required this.title,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(status),
        leading: Icon(Icons.star, color: color),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: переход к документу
        },
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
