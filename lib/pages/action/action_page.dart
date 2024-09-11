import 'package:flutter/material.dart';

class ActionsPage extends StatefulWidget {
  const ActionsPage({super.key});

  @override
  _ActionsPageState createState() => _ActionsPageState();
}

class _ActionsPageState extends State<ActionsPage> {
  final List<String> _actions = ["Jazda autobusem", "Jazda na rowerze", "Spacer"];
  String? _selectedAction;
  String? _actionDetails;
  final List<Map<String, String>> _addedActions = [];
  String _searchQuery = "";

  void _addAction() {
    if (_selectedAction != null && _actionDetails != null && _actionDetails!.isNotEmpty) {
      setState(() {
        _addedActions.add({
          "action": _selectedAction!,
          "details": _actionDetails!,
        });
        _actionDetails = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildActionForm(),
            const SizedBox(height: 20),
            _buildSearchBar(),
            const SizedBox(height: 10),
            Expanded(child: _buildActionList()),
          ],
        ),
      ),
    );
  }

  Widget _buildActionForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<String>(
          hint: const Text("Wybierz akcję"),
          value: _selectedAction,
          onChanged: (String? newValue) {
            setState(() {
              _selectedAction = newValue;
            });
          },
          items: _actions.map<DropdownMenuItem<String>>((String action) {
            return DropdownMenuItem<String>(
              value: action,
              child: Text(action),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: const InputDecoration(
            labelText: "Szczegóły akcji",
            hintText: "Np. 10 km jazdy autobusem",
          ),
          onChanged: (value) {
            _actionDetails = value;
          },
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _addAction,
          child: const Text("Dodaj akcję"),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Wyszukaj akcję",
        hintText: "Wpisz nazwę akcji...",
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (value) {
        setState(() {
          _searchQuery = value.toLowerCase();
        });
      },
    );
  }

  Widget _buildActionList() {
    List<Map<String, String>> filteredActions = _addedActions.where((action) {
      return action["action"]!.toLowerCase().contains(_searchQuery);
    }).toList();

    return ListView.builder(
      itemCount: filteredActions.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Text(filteredActions[index]["action"]!),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(filteredActions[index]["details"]!),
            ),
          ],
        );
      },
    );
  }
}