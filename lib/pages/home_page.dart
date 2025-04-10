// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Place {
  final int id;
  final String name;
  final String imageUrl;
  final double rating;

  Place({required this.id, required this.name, required this.imageUrl, required this.rating});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Place>> futurePlaces;

  @override
  void initState() {
    super.initState();
    futurePlaces = fetchPlaces();
  }

  Future<List<Place>> fetchPlaces() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/places'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((place) => Place.fromJson(place)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'LIKE'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'USER'),
      ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hi Guy!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text('Where are you going next?'),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search your destination',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Chip(label: Text('Hotels')),
                  Chip(label: Text('Flights')),
                  Chip(label: Text('All')),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Popular Destinations', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List<Place>>(
                  future: futurePlaces,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No places found.'));
                    }

                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data!.map((place) {
                        return Container(
                          margin: const EdgeInsets.only(right: 16),
                          width: 160,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(place.imageUrl, height: 100, width: 160, fit: BoxFit.cover),
                              ),
                              const SizedBox(height: 6),
                              Text(place.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.star, color: Colors.orange, size: 16),
                                  Text(place.rating.toString()),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
