import 'package:app/shared/models/pokemon_summary.dart';
import 'package:flutter/material.dart';

class ShirtProvider with ChangeNotifier {
  final List<Color> _colors = [
    Colors.white,
    const Color(0xFF555555),
    const Color(0xFFA7A877),
    const Color(0xFFC03128),
    const Color(0xFFFB6C6C),
    const Color(0xFFFFCE4B),
    const Color(0xFF48D0B0),
    const Color(0xFF99D7D8),
    const Color(0xFFA890F0),
    const Color(0xFF9F419F),
  ];
  late Color _selectedColorIndex = _colors[0];
  PokemonSummary? _selectedPokemon;

  void changeColor(Color color) {
    _selectedColorIndex = color;
    notifyListeners();
  }

  void setPokemon(PokemonSummary? pokemon) {
    _selectedPokemon = pokemon;
    notifyListeners();
  }

  @override
  void dispose() {
    _selectedPokemon = null;
    notifyListeners();
    super.dispose();
  }

  List<Color> get colors => _colors;
  Color get selectedColor => _selectedColorIndex;
  PokemonSummary? get selectedPokemon => _selectedPokemon;
}
