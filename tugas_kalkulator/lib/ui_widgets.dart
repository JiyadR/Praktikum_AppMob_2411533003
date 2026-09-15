//2411533003

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Widget untuk menampilkan semua contoh UI Widgets
Widget buildUIWidgets(BuildContext context, int counter, bool isFavorite, 
    Function incrementCounter, Function toggleFavorite) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // ==================== SECTION HEADER ====================
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green, width: 2),
        ),
        child: const Text(
          'PART 2: UI WIDGETS',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          textAlign: TextAlign.center,
        ),
      ),

      const SizedBox(height: 16),
      const Divider(),

      // ==================== 1. TEXT WIDGET ====================
      const SizedBox(height: 16),
      _buildSectionTitle('6. Text Widget', Icons.text_fields, Colors.indigo),
      const SizedBox(height: 8),
      const Text('Widget untuk menampilkan teks dengan berbagai style'),
      const SizedBox(height: 12),

      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubtitle('Default Text'),
            const Text('Ini adalah text default'),
            const SizedBox(height: 12),
            
            _buildSubtitle('Text dengan FontSize 20'),
            const Text(
              'Text dengan fontSize 20',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 12),
            
            _buildSubtitle('Text dengan Color dan Bold'),
            const Text(
              'Text berwarna biru dan bold',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            _buildSubtitle('Text dengan Italic'),
            const Text(
              'Text dengan style italic',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 12),
            
            _buildSubtitle('Text dengan MaxLines & Overflow'),
            const Text(
              'Ini adalah text yang sangat panjang sekali dan akan dibatasi hanya 2 baris saja, sisanya akan ditampilkan dengan ellipsis',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),

      const SizedBox(height: 24),
      const Divider(),

      // ==================== 2. ICON WIDGET ====================
      const SizedBox(height: 16),
      _buildSectionTitle('7. Icon Widget', Icons.emoji_emotions, Colors.amber),
      const SizedBox(height: 8),
      const Text('Widget untuk menampilkan icon Material dan Cupertino'),
      const SizedBox(height: 12),

      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            _buildSubtitle('Material Icons'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconColumn(Icons.home, 'home', Colors.blue),
                _buildIconColumn(Icons.favorite, 'favorite', Colors.red),
                _buildIconColumn(Icons.star, 'star', Colors.amber),
                _buildIconColumn(Icons.shopping_cart, 'cart', Colors.green),
                _buildIconColumn(Icons.settings, 'settings', Colors.grey),
              ],
            ),
            const SizedBox(height: 16),
            _buildSubtitle('Cupertino Icons (iOS)'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconColumn(CupertinoIcons.house_fill, 'home', Colors.blue),
                _buildIconColumn(CupertinoIcons.heart_fill, 'heart', Colors.red),
                _buildIconColumn(CupertinoIcons.star_fill, 'star', Colors.amber),
                _buildIconColumn(CupertinoIcons.cart_fill, 'cart', Colors.green),
                _buildIconColumn(CupertinoIcons.gear, 'settings', Colors.grey),
              ],
            ),
          ],
        ),
      ),

      const SizedBox(height: 24),
      const Divider(),

      // ==================== 3. IMAGE WIDGET ====================
      const SizedBox(height: 16),
      _buildSectionTitle('8. Image Widget', Icons.image, Colors.pink),
      const SizedBox(height: 8),
      const Text('Widget untuk menampilkan gambar dari network'),
      const SizedBox(height: 12),

      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubtitle('Image dari Network (URL)'),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/400/200',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image, size: 48, color: Colors.grey),
                          SizedBox(height: 8),
                          Text('Gambar tidak dapat dimuat'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Image.network() - Load gambar dari URL',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),

      const SizedBox(height: 24),
      const Divider(),

      // ==================== 4. ELEVATED BUTTON WIDGET ====================
      const SizedBox(height: 16),
      _buildSectionTitle('9. ElevatedButton Widget', Icons.touch_app, Colors.deepOrange),
      const SizedBox(height: 8),
      const Text('Widget tombol dengan shadow (elevasi)'),
      const SizedBox(height: 12),

      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSubtitle('Default ElevatedButton'),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Button diklik!')),
                );
              },
              child: const Text('Click Me'),
            ),
            const SizedBox(height: 12),
            
            _buildSubtitle('ElevatedButton dengan Icon'),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Button dengan icon diklik!')),
                );
              },
              icon: const Icon(Icons.send),
              label: const Text('Send Message'),
            ),
            const SizedBox(height: 12),
            
            _buildSubtitle('ElevatedButton dengan Custom Style'),
            ElevatedButton(
              onPressed: () => incrementCounter(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Counter: $counter'),
            ),
            const SizedBox(height: 12),
            
            _buildSubtitle('ElevatedButton dengan Warna Custom'),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Success'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Danger'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            _buildSubtitle('ElevatedButton dengan State'),
            ElevatedButton.icon(
              onPressed: () => toggleFavorite(),
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              label: Text(isFavorite ? 'Favorited' : 'Add to Favorite'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isFavorite ? Colors.red : Colors.grey,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 24),
      const Divider(),

      // ==================== 5. APPBAR INFO ====================
      const SizedBox(height: 16),
      _buildSectionTitle('10. AppBar Widget', Icons.apps, Colors.purple),
      const SizedBox(height: 8),
      const Text('Widget bar aplikasi di bagian atas'),
      const SizedBox(height: 12),

      Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Properti AppBar yang digunakan:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildAppBarProperty('title', 'Text judul aplikasi'),
              _buildAppBarProperty('backgroundColor', 'Warna background AppBar'),
              _buildAppBarProperty('foregroundColor', 'Warna icon dan text'),
              _buildAppBarProperty('leading', 'Widget di sisi kiri (menu icon)'),
              _buildAppBarProperty('actions', 'List widget di sisi kanan (search, more)'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '💡 Lihat AppBar di bagian atas aplikasi ini!',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),

      const SizedBox(height: 100),
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

// Helper untuk membuat column icon dengan label
Widget _buildIconColumn(IconData icon, String label, Color color) {
  return Column(
    children: [
      Icon(icon, size: 32, color: color),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 10)),
    ],
  );
}

// Helper untuk membuat properti AppBar
Widget _buildAppBarProperty(String property, String description) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, size: 16, color: Colors.green),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              children: [
                TextSpan(
                  text: '$property: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: description),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
