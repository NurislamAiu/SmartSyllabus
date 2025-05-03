import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Добро пожаловать, преподаватель!',
                style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              _SectionTitle('📊 Статистика силабусов'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _StatCard(label: 'Всего', value: '12'),
                  _StatCard(label: 'Черновик', value: '4'),
                  _StatCard(label: 'Утверждено', value: '6'),
                  _StatCard(label: 'Отклонено', value: '2'),
                ],
              ),

              const SizedBox(height: 24),
              _SectionTitle('🤖 AI-помощник'),
              _FeatureCard(
                title: 'Сгенерировать задания',
                subtitle: 'По теме и цели курса',
                icon: Icons.auto_awesome,
                onTap: () => context.go('/syllabus/ai-assistant'),
              ),

              const SizedBox(height: 24),
              _SectionTitle('📚 Мои силабусы'),
              _FeatureCard(
                title: 'История Казахстана',
                subtitle: 'Статус: На проверке',
                icon: Icons.book_online,
                onTap: () => context.go('/syllabus/detail/1'),
              ),
              _FeatureCard(
                title: 'Информатика',
                subtitle: 'Статус: Черновик',
                icon: Icons.computer,
                onTap: () => context.go('/syllabus/detail/2'),
              ),

              const SizedBox(height: 24),
              _SectionTitle('⚡ Быстрые действия'),
              Wrap(
                spacing: 12,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => context.go('/syllabus'),
                    icon: const Icon(Icons.note_add),
                    label: const Text('Новый силабус'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/exam'),
                    icon: const Icon(Icons.assignment),
                    label: const Text('Создать экзамен'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Экспорт в PDF'),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              _SectionTitle('🔔 Уведомления'),
              const _NotificationTile(text: '✅ Силабус "История" утвержден'),
              const _NotificationTile(text: '⏳ Билет по биологии в статусе Review'),
            ],
          ),
        ),
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

class _FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String text;
  const _NotificationTile({required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.notifications_outlined),
      title: Text(text),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(value, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
