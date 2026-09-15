//2411533003

import 'package:flutter/material.dart';

// Widget untuk menampilkan semua contoh Layout Widgets
Widget buildLayoutWidgets() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // ==================== SECTION HEADER ====================
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: const Text(
          'PART 1: LAYOUT WIDGETS',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
          textAlign: TextAlign.center,
        ),
      ),

      const SizedBox(height: 16),
      const Divider(),

      // ==================== 1. ROW WIDGET ====================
      const SizedBox(height: 16),
      _buildSectionTitle('1. Row Widget', Icons.view_week, Colors.blue),
      const SizedBox(height: 8),
      const Text('Layout horizontal - Mengatur widget dalam baris'),
      const SizedBox(height: 12),

      // Contoh MainAxisAlignment.start
      _buildSubtitle('MainAxisAlignment.start'),
      Container(
        color: Colors.grey[200],
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildBox(Colors.red, '1'),
            _buildBox(Colors.green, '2'),
            _buildBox(Colors.blue, '3'),
          ],
        ),
      ),
      const SizedBox(height: 12),

      // Contoh MainAxisAlignment.center
      _buildSubtitle('MainAxisAlignment.center'),
      Container(
        color: Colors.grey[200],
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBox(Colors.red, '1'),
            _buildBox(Colors.green, '2'),
            _buildBox(Colors.blue, '3'),
          ],
        ),
      ),
      const SizedBox(height: 12),

      // Contoh MainAxisAlignment.spaceBetween
      _buildSubtitle('MainAxisAlignment.spaceBetween'),
      Container(
        color: Colors.grey[200],
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBox(Colors.red, '1'),
            _buildBox(Colors.green, '2'),
            _buildBox(Colors.blue, '3'),
          ],
        ),
      ),

      const SizedBox(height: 24),
      const Divider(),

      // ==================== 2. COLUMN WIDGET ====================
      const SizedBox(height: 16),
      _buildSectionTitle('2. Column Widget', Icons.view_agenda, Colors.green),
      const SizedBox(height: 8),
      const Text('Layout vertikal - Mengatur widget dalam kolom'),
      const SizedBox(height: 12),

      // Contoh Column dengan berbagai MainAxisAlignment
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Column dengan start
          Column(
            children: [
              _buildSubtitle('start'),
              Container(
                width: 100,
                height: 200,
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildBox(Colors.red, '1', width: 40, height: 40),
                    _buildBox(Colors.green, '2', width: 40, height: 40),
                    _buildBox(Colors.blue, '3', width: 40, height: 40),
                  ],
                ),
              ),
            ],
          ),
          // Column dengan center
          Column(
            children: [
              _buildSubtitle('center'),
              Container(
                width: 100,
                height: 200,
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildBox(Colors.red, '1', width: 40, height: 40),
                    _buildBox(Colors.green, '2', width: 40, height: 40),
                    _buildBox(Colors.blue, '3', width: 40, height: 40),
                  ],
                ),
              ),
            ],
          ),
          // Column dengan end
          Column(
            children: [
              _buildSubtitle('end'),
              Container(
                width: 100,
                height: 200,
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildBox(Colors.red, '1', width: 40, height: 40),
                    _buildBox(Colors.green, '2', width: 40, height: 40),
                    _buildBox(Colors.blue, '3', width: 40, height: 40),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      const SizedBox(height: 24),
      const Divider(),

      // ==================== 3. CONTAINER WIDGET ====================
      const SizedBox(height: 16),
      _buildSectionTitle('3. Container Widget', Icons.crop_square, Colors.orange),
      const SizedBox(height: 8),
      const Text('Kotak dengan dekorasi - Border, padding, margin, shadow'),
      const SizedBox(height: 12),

      // Contoh Container dengan berbagai properti
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Container dengan color
          Column(
            children: [
              _buildSubtitle('Color'),
              Container(
                width: 80,
                height: 80,
                color: Colors.purple,
                child: const Center(
                  child: Text('Color', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            ],
          ),
          // Container dengan border
          Column(
            children: [
              _buildSubtitle('Border'),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.red, width: 3),
                ),
                child: const Center(
                  child: Text('Border', style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
          // Container dengan borderRadius
          Column(
            children: [
              _buildSubtitle('Radius'),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text('Radius', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),

      const SizedBox(height: 12),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Container dengan shadow
          Column(
            children: [
              _buildSubtitle('Shadow'),
              Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('Shadow', style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
          // Container dengan gradient
          Column(
            children: [
              _buildSubtitle('Gradient'),
              Container(
                width: 140,
                height: 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.pink],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text('Gradient', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),

      const SizedBox(height: 24),
      const Divider(),

      // ==================== 4. CENTER WIDGET ====================
      const SizedBox(height: 16),
      _buildSectionTitle('4. Center Widget', Icons.center_focus_strong, Colors.teal),
      const SizedBox(height: 8),
      const Text('Posisi tengah - Menempatkan widget di tengah'),
      const SizedBox(height: 12),

      // Contoh Center widget
      Container(
        height: 150,
        color: Colors.grey[200],
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, size: 48, color: Colors.amber),
              SizedBox(height: 8),
              Text(
                'Widget di Tengah',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),

      const SizedBox(height: 24),
      const Divider(),

      // ==================== 5. SCAFFOLD INFO ====================
      const SizedBox(height: 16),
      _buildSectionTitle('5. Scaffold Widget', Icons.dashboard, Colors.deepPurple),
      const SizedBox(height: 8),
      const Text('Struktur dasar app - AppBar, Body, FloatingActionButton'),
      const SizedBox(height: 12),

      // Info Card Scaffold
      Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scaffold Components:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text('✓ AppBar - Bar di bagian atas (lihat di atas)'),
              SizedBox(height: 4),
              Text('✓ Body - Area konten utama (ini yang kamu scroll)'),
              SizedBox(height: 4),
              Text('✓ FloatingActionButton - Tombol melayang (kanan bawah)'),
            ],
          ),
        ),
      ),

      const SizedBox(height: 32),
    ],
  );
}

// ==================== HELPER FUNCTIONS ====================

// Helper untuk membuat judul section
Widget _buildSectionTitle(String title, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 28),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

// Helper untuk membuat subtitle
Widget _buildSubtitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(
      text,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
    ),
  );
}

// Helper untuk membuat kotak berwarna (untuk demo Row & Column)
Widget _buildBox(Color color, String text, {double width = 60, double height = 60}) {
  return Container(
    width: width,
    height: height,
    margin: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
