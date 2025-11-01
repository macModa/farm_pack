import 'package:flutter/material.dart';
import '../models/plant.dart';

class AddEditPlantPage extends StatefulWidget {
  final Plant? plant;

  const AddEditPlantPage({super.key, this.plant});

  @override
  State<AddEditPlantPage> createState() => _AddEditPlantPageState();
}

class _AddEditPlantPageState extends State<AddEditPlantPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  String? _selectedCategory;
  String? _selectedWaterNeed;
  String? _selectedSoilType;
  String? _selectedRegion;

  final List<String> _categories = ['Légume', 'Fruit', 'Arbre', 'Fleur', 'Herbe'];
  final List<String> _waterNeeds = ['Faible', 'Moyen', 'Élevé'];
  final List<String> _soilTypes = ['Argileux', 'Sablonneux', 'Limoneux', 'Calcaire'];
  final List<String> _regions = [
    'Ariana', 'Béja', 'Ben Arous', 'Bizerte', 'Gabès', 'Gafsa', 'Jendouba',
    'Kairouan', 'Kasserine', 'Kébili', 'Le Kef', 'Mahdia', 'Manouba', 'Médenine',
    'Monastir', 'Nabeul', 'Sfax', 'Sidi Bouzid', 'Siliana', 'Sousse', 'Tataouine',
    'Tozeur', 'Tunis', 'Zaghouan'
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.plant?.name);
    _selectedCategory = widget.plant?.category;
    _selectedWaterNeed = widget.plant?.waterNeed;
    _selectedSoilType = widget.plant?.soilType;
    _selectedRegion = widget.plant?.region;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // For now, we just pop the page.
      // In a real app, you would save this data to your backend or state management solution.
      print('Saving plant: ${_nameController.text}, $_selectedCategory, $_selectedWaterNeed, $_selectedSoilType, $_selectedRegion');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.plant != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Modifier la Plante' : 'Ajouter une Plante',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: isEditing ? Colors.orange[700] : Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildTextField(
              controller: _nameController,
              label: 'Nom de la plante',
              icon: Icons.local_florist,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nom';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              value: _selectedCategory,
              items: _categories,
              label: 'Catégorie',
              icon: Icons.category,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              value: _selectedWaterNeed,
              items: _waterNeeds,
              label: 'Besoin en eau',
              icon: Icons.water_drop,
              onChanged: (value) {
                setState(() {
                  _selectedWaterNeed = value;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              value: _selectedSoilType,
              items: _soilTypes,
              label: 'Type de sol',
              icon: Icons.layers,
              onChanged: (value) {
                setState(() {
                  _selectedSoilType = value;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              value: _selectedRegion,
              items: _regions,
              label: 'Région (Gouvernorat)',
              icon: Icons.public,
              onChanged: (value) {
                setState(() {
                  _selectedRegion = value;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveForm,
        icon: const Icon(Icons.save),
        label: const Text('Enregistrer'),
        backgroundColor: isEditing ? Colors.orange[700] : Colors.green[700],
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      validator: validator,
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String label,
    required IconData icon,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez sélectionner une option';
        }
        return null;
      },
    );
  }
}