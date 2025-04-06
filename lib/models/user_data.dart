class UserData {
  String name;
  int age;
  double height; // in cm
  double weight; // in kg
  String gender;
  String dietGoal;
  List<String> selectedFoods;
  double bmi;

  UserData({
    this.name = '',
    this.age = 0,
    this.height = 0,
    this.weight = 0,
    this.gender = 'Male',
    this.dietGoal = '',
    this.selectedFoods = const [],
    this.bmi = 0,
  });

  double calculateBMI() {
    if (height <= 0 || weight <= 0) return 0;
    return weight / ((height / 100) * (height / 100));
  }

  String getBMICategory() {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
}