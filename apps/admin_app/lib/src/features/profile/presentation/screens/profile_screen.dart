import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('ФИО'),
            subtitle: Text('Ильясов Нурислам Бауыржанұлы'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            subtitle: Text('dean@example.edu'),
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Факультет'),
            subtitle: Text('Факультет информационных технологий'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Настройки'),
            onTap: null, // TODO: перейти в настройки
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Выйти'),
            onTap: null, // TODO: реализовать выход
          ),
        ],
      ),
    );
  }
}
