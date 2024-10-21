import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/user.model.dart';
import 'package:attendance_app/src/providers/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  Map<String, String> formData = {
    "auid": "",
    "password": "",
  };
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String _responseError = "";

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  final OutlineInputBorder borderRed = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red, width: 2.0),
    borderRadius: BorderRadius.circular(8),
  );

  void toggleShowPassword() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      setState(() {
        _isLoading = true;
        _responseError = "";
      });
      _formKey.currentState?.save();
      ApiResponse<UserModel> response = await Api().user.login(formData);

      if (response.success) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", response.data.accessToken!);

        ref.read(userProvider.notifier).setUser(response.data);

        final role = response.data.user!.role;
        if (role == "student") {
          if (!mounted) return;
          context.go("/student");
        } else if (role == "faculty") {
          if (!mounted) return;
          context.go("/teacher");
        }
      }
    } catch (e) {
      setState(() {
        _responseError = e.toString().replaceAll("Exception: ", "");
        debugPrint(_responseError);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
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
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 50),
                          TextFormField(
                            onSaved: (value) {
                              formData["auid"] = value.toString();
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
                              border: border,
                              enabledBorder: _responseError != "" ? borderRed : border,
                              focusedBorder: _responseError != "" ? borderRed : border,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            onSaved: (value) {
                              formData["password"] = value.toString();
                            },
                            obscureText: !_isPasswordVisible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              if (value.length < 7) {
                                return "Password should be at least 7 characters long";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: toggleShowPassword,
                                icon: _isPasswordVisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                              border: border,
                              enabledBorder: _responseError != "" ? borderRed : border,
                              focusedBorder: _responseError != "" ? borderRed : border,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Text(_responseError),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ButtonTextPrimary(
                                  text: "Log In",
                                  onPressed: _handleLogin,
                                  isLoading: _isLoading,
                                ),
                              ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
