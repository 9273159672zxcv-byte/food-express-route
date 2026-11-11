import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Строй Портал',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE65100),
        title: const Text('🏗 Строй Портал', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuCard(context, '🏢', 'Объекты', 'Список строек и этажей', const ObjectsScreen()),
          _buildMenuCard(context, '🚜', 'Оборудование', 'Пневмонагнетатели, пушки', const EquipmentScreen()),
          _buildMenuCard(context, '🛠', 'Инструмент', 'Болгарки, уровни', const ToolsScreen()),
          _buildMenuCard(context, '🧱', 'Материалы', 'Цемент, песок, фибра', const MaterialsScreen()),
          _buildMenuCard(context, '📝', 'Потребности', 'Заявки на объект', const NeedsScreen()),
          _buildMenuCard(context, '👷', 'Бригады', 'Кто где работает', const BrigadesScreen()),
          _buildMenuCard(context, '🔒', 'Инспектор', 'Проверка работ (по паролю)', const InspectorLoginScreen()),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String icon, String title, String subtitle, Widget screen) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      child: ListTile(
        leading: Text(icon, style: const TextStyle(fontSize: 32)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
      ),
    );
  }
}

// --- ЭКРАН "ОБЪЕКТЫ" (Заглушка) ---
class ObjectsScreen extends StatelessWidget {
  const ObjectsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFE65100), title: const Text('Объекты')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('ЖК «Солнечный», Корп. 2'), subtitle: Text('Бригад: 3 | Инструментов: 5'))),
          Card(child: ListTile(title: Text('Дом на Ленина'), subtitle: Text('Бригад: 1 | Инструментов: 2'))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

// --- ЭКРАН "ОБОРУДОВАНИЕ" (Заглушка) ---
class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFE65100), title: const Text('Оборудование')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('Пневмонагнетатель №123'), subtitle: Text('ЖК Солнечный, Вагончик 5'))),
          Card(child: ListTile(title: Text('Компрессор №8'), subtitle: Text('Дом на Ленина, Вагончик 2'))),
        ],
      ),
    );
  }
}

// --- ЭКРАН "ИНСТРУМЕНТ" (Заглушка) ---
class ToolsScreen extends StatelessWidget {
  const ToolsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFE65100), title: const Text('Инструмент')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('Лазерный уровень №45'), subtitle: Text('ЖК Солнечный, Этаж 5'))),
          Card(child: ListTile(title: Text('Болгарка №14'), subtitle: Text('Дом на Ленина, Этаж 3'))),
        ],
      ),
    );
  }
}

// --- ЭКРАН "МАТЕРИАЛЫ" (Заглушка) ---
class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFE65100), title: const Text('Материалы')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('Цемент М500'), subtitle: Text('Склад: 150 мешков | На объектах: 50'))),
          Card(child: ListTile(title: Text('Песок'), subtitle: Text('Склад: 5 тонн | На объектах: 2'))),
        ],
      ),
    );
  }
}

// --- ЭКРАН "ПОТРЕБНОСТИ" (Заглушка) ---
class NeedsScreen extends StatelessWidget {
  const NeedsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFE65100), title: const Text('Потребности')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('Потребность №1 (15.11)'), subtitle: Text('Цемент 50, Песок 2т | Ожидает'))),
          Card(child: ListTile(title: Text('Потребность №2 (18.11)'), subtitle: Text('Пневмонагнетатель 1 шт | В пути'))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

// --- ЭКРАН "БРИГАДЫ" (Заглушка) ---
class BrigadesScreen extends StatelessWidget {
  const BrigadesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFE65100), title: const Text('Бригады')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('Стяжечники (Иван)'), subtitle: Text('ЖК Солнечный, Этаж 5'))),
          Card(child: ListTile(title: Text('Подложка (Петр)'), subtitle: Text('Дом на Ленина, Этаж 3'))),
        ],
      ),
    );
  }
}

// --- ЭКРАН "ВХОД ИНСПЕКТОРА" (Пароль) ---
class InspectorLoginScreen extends StatelessWidget {
  const InspectorLoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFE65100), title: const Text('Вход Инспектора')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 80, color: Colors.orange),
              const SizedBox(height: 20),
              const Text('Введите ПИН-код', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: '****'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, minimumSize: const Size(200, 50)),
                onPressed: () {
                  // Заглушка для входа
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const InspectorReportScreen()));
                },
                child: const Text('ВОЙТИ', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- ЭКРАН "ОТЧЕТ ИНСПЕКТОРА" (Заглушка) ---
class InspectorReportScreen extends StatelessWidget {
  const InspectorReportScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFE65100), title: const Text('Отчет Инспектора')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(child: ListTile(title: Text('Объект: ЖК Солнечный, Этаж 5'), subtitle: Text('Дата: 12.11.2026'))),
          const Card(
            child: Column(
              children: [
                ListTile(title: Text('🎤 Голосовой ввод'), subtitle: Text('Нажмите, чтобы наговорить отчет')),
                Divider(),
                ListTile(title: Text('Проверка: Стяжка (Принято)'), trailing: Icon(Icons.check_circle, color: Colors.green)),
                ListTile(title: Text('Проверка: Подложка (Брак)'), trailing: Icon(Icons.cancel, color: Colors.red)),
                Divider(),
                ListTile(title: Text('Оборудование на объекте'), subtitle: Text('Пневмонагнетатель №123 (Шланг порван)')),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 50)),
            onPressed: () {},
            child: const Text('ОТПРАВИТЬ ШЕФУ', style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
