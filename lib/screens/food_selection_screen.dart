import 'package:flutter/material.dart';
import '../models/user_data.dart';
import 'profile_summary_screen.dart';

class FoodSelectionScreen extends StatefulWidget {
  final UserData userData;

  const FoodSelectionScreen({Key? key, required this.userData})
      : super(key: key);

  @override
  _FoodSelectionScreenState createState() => _FoodSelectionScreenState();
}

class _FoodSelectionScreenState extends State<FoodSelectionScreen> {
  late UserData _userData;
  final List<String> selectedFoods = [];

  final List<Map<String, dynamic>> foodCategories = [
    {
      'category': 'Proteins',
      'foods': [
        {'name': 'Chicken', 'icon': Icons.egg_alt},
        {'name': 'Fish', 'icon': Icons.set_meal},
        {'name': 'Tofu', 'icon': Icons.square},
        {'name': 'Eggs', 'icon': Icons.egg},
        {'name': 'Beef', 'icon': Icons.cabin},
      ],
    },
    {
      'category': 'Carbohydrates',
      'foods': [
        {'name': 'Rice', 'icon': Icons.rice_bowl},
        {'name': 'Pasta', 'icon': Icons.ramen_dining},
        {'name': 'Bread', 'icon': Icons.breakfast_dining},
        {'name': 'Oats', 'icon': Icons.breakfast_dining},
        {'name': 'Potatoes', 'icon': Icons.circle},
      ],
    },
    {
      'category': 'Vegetables',
      'foods': [
        {'name': 'Broccoli', 'icon': Icons.park},
        {'name': 'Spinach', 'icon': Icons.eco},
        {'name': 'Carrots', 'icon': Icons.add},
        {'name': 'Bell Peppers', 'icon': Icons.circle},
        {'name': 'Tomatoes', 'icon': Icons.circle},
      ],
    },
    {
      'category': 'Fruits',
      'foods': [
        {'name': 'Apples', 'icon': Icons.apple},
        {'name': 'Bananas', 'icon': Icons.sentiment_satisfied_alt},
        {'name': 'Berries', 'icon': Icons.circle},
        {'name': 'Oranges', 'icon': Icons.circle},
        {'name': 'Avocados', 'icon': Icons.spa},
      ],
    },
    {
      'category': 'Dairy',
      'foods': [
        {'name': 'Milk', 'icon': Icons.water_drop},
        {'name': 'Cheese', 'icon': Icons.square},
        {'name': 'Yogurt', 'icon': Icons.breakfast_dining},
        {'name': 'Cottage Cheese', 'icon': Icons.square},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _userData = widget.userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Preferences',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.teal.shade50,
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.teal),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Select foods you prefer to include in your ${_userData.dietGoal} diet plan.',
                    style: TextStyle(
                      color: Colors.teal.shade800,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: foodCategories.length,
              itemBuilder: (context, index) {
                final category = foodCategories[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Text(
                        category['category'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    Container(
                      height: 110,
                      padding: const EdgeInsets.only(left: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: category['foods'].length,
                        itemBuilder: (context, foodIndex) {
                          final food = category['foods'][foodIndex];
                          final isSelected =
                          selectedFoods.contains(food['name']);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedFoods.remove(food['name']);
                                } else {
                                  selectedFoods.add(food['name']);
                                }
                              });
                            },
                            child: Container(
                              width: 100,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.teal.withOpacity(0.1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.teal
                                      : Colors.grey.withOpacity(0.3),
                                  width: isSelected ? 2 : 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.teal
                                          : Colors.grey.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      food['icon'],
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.teal,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    food['name'],
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? Colors.teal
                                          : Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Selected Foods: ${selectedFoods.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: selectedFoods.isEmpty
                      ? null
                      : () {
                    _userData.selectedFoods = List.from(selectedFoods);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileSummaryScreen(userData: _userData),
                      ),
                    );
                  },
                  child: const Text(
                    'Create My Diet Plan',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}