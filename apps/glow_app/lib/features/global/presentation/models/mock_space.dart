import 'package:flutter/material.dart';

/// Mock Space model for UI demonstration
class MockSpace {
  const MockSpace({
    required this.name,
    required this.description,
    required this.gradientColors,
    required this.icon,
  });

  final String name;
  final String description;
  final List<Color> gradientColors;
  final IconData icon;

  static final List<MockSpace> mockSpaces = [
    MockSpace(
      name: 'MotoGP',
      description: 'Racing passion, speed, and adrenaline',
      gradientColors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
      icon: Icons.sports_motorsports_rounded,
    ),
    MockSpace(
      name: 'Digital Art',
      description: 'Create, share, and discover amazing artwork',
      gradientColors: [Color(0xFF7C3AED), Color(0xFFEC4899)],
      icon: Icons.palette_rounded,
    ),
    MockSpace(
      name: 'Programming',
      description: 'Code, collaborate, and learn together',
      gradientColors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
      icon: Icons.code_rounded,
    ),
    MockSpace(
      name: 'Music Production',
      description: 'Beats, melodies, and creative flow',
      gradientColors: [Color(0xFFF59E0B), Color(0xFFEC4899)],
      icon: Icons.music_note_rounded,
    ),
    MockSpace(
      name: 'Gaming',
      description: 'Play, stream, and connect with gamers',
      gradientColors: [Color(0xFF10B981), Color(0xFF06B6D4)],
      icon: Icons.sports_esports_rounded,
    ),
    MockSpace(
      name: 'Photography',
      description: 'Capture moments, share perspectives',
      gradientColors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
      icon: Icons.camera_alt_rounded,
    ),
  ];
}
