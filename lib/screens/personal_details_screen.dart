import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/user_data.dart';
import 'diet_goal_screen.dart';
import '../widgets/custom_widgets.dart';

class PersonalDetailsScreen extends StatefulWidget {
  final UserData userData;

  const PersonalDetailsScreen({Key? key, required this.userData})
      : super(key: key);

  @override
  _PersonalDetailsScreenState createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late UserData _userData;
  final List<String> genders = ['Male', 'Female', 'Other'];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _userData = widget.userData;
  }

  void _pickImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Open Camera'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  File selectedImage = File(image.path);
                  // Handle selectedImage
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Open Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  File selectedImage = File(image.path);
                  // Handle selectedImage
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.teal,
                        child: CircleAvatar(
                          radius: 57,
                          backgroundImage:
                          AssetImage('assets/images/pic2.jpg'),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt),
                            onPressed: () => _pickImage(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Basic Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: inputDecoration('Full Name', Icons.person),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userData.name = value ?? '';
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        decoration: inputDecoration('Age', Icons.calendar_today),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your age';
                          }

                          final int? age = int.tryParse(value);
                          if (age == null) {
                            return 'Please enter a valid number';
                          }

                          if (age < 0 || age > 110) {
                            return 'Not valid';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _userData.age = int.tryParse(value ?? '0') ?? 0;
                        },
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        decoration: inputDecoration('Gender', Icons.people),
                        value: _userData.gender,
                        items: genders.map((gender) {
                          return DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _userData.gender = value ?? 'Male';
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Body Measurements',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: inputDecoration('Height (cm)', Icons.height),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your height';
                          }

                          final double? height = double.tryParse(value);
                          if (height == null) {
                            return 'Please enter a valid number';
                          }

                          if (height < 50 || height > 300) {
                            return 'Not valid';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _userData.height = double.tryParse(value ?? '0') ?? 0;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        decoration: inputDecoration('Weight (kg)', Icons.monitor_weight),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your weight';
                          }

                          final double? weight = double.tryParse(value);
                          if (weight == null) {
                            return 'Please enter a valid number';
                          }

                          if (weight < 1 || weight > 300) {
                            return 'Not valid';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _userData.weight = double.tryParse(value ?? '0') ?? 0;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _userData.bmi = _userData.calculateBMI();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DietGoalScreen(userData: _userData),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}