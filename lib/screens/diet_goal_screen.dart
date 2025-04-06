import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_data.dart';
import 'food_selection_screen.dart';

class DietGoalScreen extends StatefulWidget {
  final UserData userData;

  const DietGoalScreen({Key? key, required this.userData}) : super(key: key);

  @override
  _DietGoalScreenState createState() => _DietGoalScreenState();
}

class _DietGoalScreenState extends State<DietGoalScreen> {
  late UserData _userData;
  String? selectedGoal;

  final List<Map<String, dynamic>> dietGoals = [
    {
      'title': 'Weight Loss',
      'icon': Icons.trending_down,
      'description': 'Reduce body fat while maintaining muscle mass',
    },
    {
      'title': 'Muscle Gain',
      'icon': Icons.fitness_center,
      'description': 'Build muscle and increase strength',
    },
    {
      'title': 'Weight Gain',
      'icon': Icons.trending_up,
      'description': 'Healthy weight gain for underweight individuals',
    },
    {
      'title': 'Keto Diet',
      'icon': Icons.no_food,
      'description': 'Low-carb, high-fat diet for metabolic benefits',
    },
    {
      'title': 'Balanced Nutrition',
      'icon': Icons.balance,
      'description': 'Maintain a healthy balanced diet',
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
        actions: [
          IconButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                await picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  print("Image Path: ${image.path}");
                }
              },
              icon: const Icon(Icons.camera)),
        ],
        title: const Text(
          'Select Diet Goal',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your BMI',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userData.bmi.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          Text(
                            _userData.getBMICategory(),
                            style: TextStyle(
                              fontSize: 16,
                              color: _getBMICategoryColor(_userData.bmi),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child: CircularProgressIndicator(
                                  value: _getBMIProgress(_userData.bmi),
                                  strokeWidth: 10,
                                  backgroundColor: Colors.grey[200],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    _getBMICategoryColor(_userData.bmi),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Icon(
                                _getBMIIcon(_userData.bmi),
                                size: 40,
                                color: _getBMICategoryColor(_userData.bmi),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'What is your diet goal?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Select a diet plan that aligns with your fitness objectives',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: dietGoals.length,
                itemBuilder: (context, index) {
                  final goal = dietGoals[index];
                  final isSelected = selectedGoal == goal['title'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGoal = goal['title'];
                        _userData.dietGoal = goal['title'];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.teal.withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: isSelected
                              ? Colors.teal
                              : Colors.grey.withOpacity(0.2),
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.teal
                                  : Colors.grey.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              goal['icon'],
                              color: isSelected ? Colors.white : Colors.teal,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  goal['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.teal
                                        : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  goal['description'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: Colors.teal,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: selectedGoal == null
                    ? null
                    : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FoodSelectionScreen(userData: _userData),
                    ),
                  );
                },
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Color _getBMICategoryColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  IconData _getBMIIcon(double bmi) {
    if (bmi < 18.5) return Icons.arrow_downward;
    if (bmi < 25) return Icons.check_circle;
    if (bmi < 30) return Icons.warning;
    return Icons.error;
  }

  double _getBMIProgress(double bmi) {
    if (bmi <= 0) return 0;
    if (bmi >= 40) return 1;
    return bmi / 40;
  }
}