import 'package:attendance_app/src/views/widgets/buttons/button_text_primary.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, String> formData = {
    "id": "",
    "password": "",
  };
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isLoading = false;

  void toggleShowPassword() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void login() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      print(formData);
      setState(() {
        isLoading = !isLoading;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: formKey,
            child: Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Akal University Attendance',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[900],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Image(image: AssetImage("assets/images/logo.png")), // TODO: add uni logo
                    const SizedBox(height: 50),
                    TextFormField(
                      onSaved: (value) {
                        formData["id"] = value.toString();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your id";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'User ID',
                        hintText: 'Enter User ID',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      onSaved: (value) {
                        formData["password"] = value.toString();
                      },
                      obscureText: !isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your id";
                        }
                        if (value.length < 8) {
                          return "Password should be of 8 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: toggleShowPassword,
                          icon: isPasswordVisible
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonTextPrimary(
                          text: "Log In",
                          onPressed: login,
                          isLoading: isLoading,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Akal University, Talwandi Sabo, Punjab, India. For any assistance, please contact our support team at support@auts.ac.in or call us at +91-9682343567. Your data privacy is our priority.',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
