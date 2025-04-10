import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<Map<String, dynamic>> dummyPlaces = [
    {
      'name': 'Hoi An',
      'image':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Ph%E1%BB%91_c%E1%BB%95_H%E1%BB%99i_An_-_NKS.jpg/1920px-Ph%E1%BB%91_c%E1%BB%95_H%E1%BB%99i_An_-_NKS.jpg',
      'rating': 4.0,
    },
    {
      'name': 'Sai Gon',
      'image':
      'https://upload.wikimedia.org/wikipedia/commons/0/08/Ho_Chi_Minh_City_Skyline_at_Night.jpg',
      'rating': 4.5,
    },
    {
      'name': 'Da Nang',
      'image':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/B%E1%BB%9D_%C4%91%C3%B4ng_c%E1%BA%A7u_R%E1%BB%93ng.jpg/1280px-B%E1%BB%9D_%C4%91%C3%B4ng_c%E1%BA%A7u_R%E1%BB%93ng.jpg',
      'rating': 4.3,
    },
    {
      'name': 'Hanoi',
      'image':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Hanoi_Skyline_-_NKS.jpg/1920px-Hanoi_Skyline_-_NKS.jpg',
      'rating': 4.4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text("Hi Guy!",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
              const Text("Where are you going next?",
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search your destination',
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.grey[700]),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  categoryButton(Icons.location_city, "Hotels", Colors.orange[100]),
                  categoryButton(Icons.flight, "Flights", Colors.pink[100]),
                  categoryButton(Icons.travel_explore, "All", Colors.green[100]),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                "Popular Destinations",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dummyPlaces.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  final place = dummyPlaces[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        Image.network(
                          place['image'],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Icon(Icons.favorite, color: Colors.redAccent),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.black54,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  place['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "⭐ ${place['rating']}",
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }

  Widget categoryButton(IconData icon, String label, Color? color) {
    return Container(
      width: 90,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
