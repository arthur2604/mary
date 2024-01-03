import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<Map<String, dynamic>> animals = [];
  List<Map<String, dynamic>> filteredAnimals = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAnimals();
  }

  Future<void> fetchAnimals({String? searchQuery}) async {
    try {
      String url;

      if (searchQuery != null && searchQuery.isNotEmpty) {
        url = 'http://192.168.143.163/maryam/search.php?name=$searchQuery';
      } else {
        url = 'http://192.168.143.163/maryam/getAnimals.php';
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          animals = List<Map<String, dynamic>>.from(json.decode(response.body));
          filteredAnimals = List<Map<String, dynamic>>.from(animals);
        });
      }
    } catch (e) {
      print("Error fetching animals: $e");
    }
  }

  void searchAnimals(String query) {
     fetchAnimals(searchQuery: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animal List'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(labelText: 'Search Animal'),
                onChanged: searchAnimals,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: filteredAnimals.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(filteredAnimals[index]['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          filteredAnimals[index]['image_url'],
                          height: 100, // Adjust the height as needed
                          width: 100, // Adjust the width as needed
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAnimal(),
                    ),
                  );
                },
                child: const Text('Add Animal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class AddAnimal extends StatefulWidget {
  @override
  _AddAnimalState createState() => _AddAnimalState();
}

class _AddAnimalState extends State<AddAnimal> {
  final TextEditingController addNameController = TextEditingController();
  final TextEditingController addImageUrlController = TextEditingController();
  String selectedCategory = 'D'; // Default value

  void addAnimal() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.143.163/maryam/addAnimal.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': addNameController.text,
          'category_id': selectedCategory, // Use selected category
          'image_url': addImageUrlController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Successfully added an animal
        print(response.body);
        // You may want to navigate back or show a success message here
      }
    } catch (e) {
      print("Error adding an animal: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Animal'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: addNameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items: <String>['D', 'N']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextField(
                controller: addImageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: addAnimal,
                child: const Text('Add Animal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
