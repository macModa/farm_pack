import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/realtime_data.dart';
import 'pages/add_edit_plant_page.dart';
import 'pages/plants_page.dart';
import 'pages/sensors_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arrosage Intelligent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final ApiService _apiService = ApiService();
  RealtimeData? _realtimeData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Try real API first, fallback to mock data
      var data = await _apiService.fetchRealtimeData();
      
      data ??= await _apiService.fetchMockData();

      setState(() {
        _realtimeData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur de chargement: $e';
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Chargement des données...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            Text(_errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }

    if (_realtimeData == null) {
      return const Center(
        child: Text('Aucune donnée disponible'),
      );
    }

    switch (_selectedIndex) {
      case 0:
        return PlantsPage(plants: _realtimeData!.plants);
      case 1:
        return SensorsPage(sensorData: _realtimeData!.sensorData);
      case 2:
        return const SettingsPage();
      default:
        return PlantsPage(plants: _realtimeData!.plants);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Plantes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sensors),
            label: 'Capteurs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[700],
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddEditPlantPage(),
                  ),
                );
              },
              backgroundColor: Colors.green[700],
              tooltip: 'Ajouter une plante',
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}
