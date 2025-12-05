import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';
import 'package:union_shop/widgets/buttons.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailController.addListener(_updateCanSubmit);
  }

  void _updateCanSubmit() {
    final hasText = _emailController.text.trim().isNotEmpty;
    if (hasText != _canSubmit) {
      setState(() => _canSubmit = hasText);
    }
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateCanSubmit);
    _emailController.dispose();
    super.dispose();
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // make the scrollable area at least the height of the viewport so we can center vertically
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Center(
            // keep the same padded, constrained column but now centered vertically
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 35,
                      child: Image.asset(
                        'assets/images/sign_in_banner.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                        // prevent test failures when asset is not available by providing a graceful fallback
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            width: 120,
                            height: 120,
                            child: Center(
                              child: Icon(Icons.person, size: 48, color: Colors.grey[400]),
                            ),
                          );
                        },
                        // optional: helpful for accessibility / tests that look for semantics
                        semanticLabel: 'Sign in banner',
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text('Sign in', style: heading2, textAlign: TextAlign.start),
                    const SizedBox(height: 10),
                    const Text(
                      'Enter your email to continue',
                      style: greyText,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: 48,
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          hintText: 'Email address',
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ElevatedButton that is disabled when the text field is empty
                    SizedBox(
                      height: 48,
                      child: PurpleButton(
                        text: 'Continue',
                        borderRadius: BorderRadius.circular(4),
                        onPressed: () {
                          final email = _emailController.text.trim();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Continue with: ${email.isEmpty ? '(empty)' : email}')),
                          );
                        },
                        enabled: _canSubmit,
                        height: 48,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}