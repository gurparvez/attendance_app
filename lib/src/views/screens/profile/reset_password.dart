import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/views/widgets/buttons/button_text_primary.dart';
import 'package:attendance_app/src/views/widgets/buttons/button_text_secondary.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isLoading = false;
  String _responseError = "";
  bool _isPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmController =
      TextEditingController();

  void resetPass() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_newPasswordController.text != _newPasswordConfirmController.text) {
        setState(() {
          _responseError = "Passwords do not match";
        });
        return;
      }
      bool isSuccess = await Api().user.resetPassword(
            _oldPasswordController.text,
            _newPasswordController.text,
          );
      if (isSuccess) {
        setState(() {
          _responseError = "";
          _oldPasswordController.clear();
          _newPasswordController.clear();
          _newPasswordConfirmController.clear();
        });
        if(!mounted) return;
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: "Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.lightGreen,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      setState(() {
        _responseError = e.toString().replaceAll("Exception: ", "");
      });
      debugPrint(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Reset your password',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Current Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: _isPasswordVisible
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            obscureText: !_isPasswordVisible,
            controller: _oldPasswordController,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'New Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: _isNewPasswordVisible
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isNewPasswordVisible = !_isNewPasswordVisible;
                  });
                },
              ),
            ),
            obscureText: !_isNewPasswordVisible,
            controller: _newPasswordController,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: _isNewPasswordVisible
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isNewPasswordVisible = !_isNewPasswordVisible;
                  });
                },
              ),
            ),
            obscureText: !_isNewPasswordVisible,
            controller: _newPasswordConfirmController,
          ),
          SizedBox(
            height: 50,
            child: Text(_responseError),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonTextSecondary(
                text: "Cancel",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 16),
              ButtonTextPrimary(
                onPressed: resetPass,
                text: "Confirm",
                isLoading: _isLoading,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
