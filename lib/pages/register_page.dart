import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:prototpye_glowguide/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  String? _selectedGender;
  bool _isLoading = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
        data: {
          'username': usernameController.text,
          'gender': _selectedGender,
          'birth_date': birthDateController.text,
        },
      );

      if (response.user == null) {
        throw Exception('Registration failed');
      }

      // Save additional user information to Supabase
      final userId = response.user!.id;
      final userResponse = await Supabase.instance.client.from('users').insert({
        'id': userId,
        'email': emailController.text,
        'username': usernameController.text,
        'gender': _selectedGender,
        'birth_date': birthDateController.text,
      });

   

      // Navigate to home page
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again. $e')));
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(228, 224, 225, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(228, 224, 225, 1),
        centerTitle: true,
        title: const Text('CREATE ACCOUNT'),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.4,
                height: screenHeight * 0.4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
              CustomTextField(
                labelText: "Email",
                controller: emailController,
                hintText: "Enter your email",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                labelText: "Username",
                controller: usernameController,
                hintText: "Enter your username",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                labelText: "Password",
                controller: passwordController,
                obscureText: true,
                hintText: "Enter your password",
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: CustomTextField(
                    labelText: "Date of Birth",
                    controller: birthDateController,
                    hintText: "Enter your birth date",
                    obscureText: false,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: 'Male',
                    activeColor: Color(Colors.blue[400]!.value),
                    groupValue: _selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  const Text('Male'),
                  Radio<String>(
                    value: 'Female',
                    activeColor: Color(Colors.pink[400]!.value),
                    groupValue: _selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color.fromRGBO(91, 56, 12, 0.74),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
