class EnhancedWidgetsTemplate {
  // BUTTONS - Primary Button
  static String generatePrimaryButton() {
    return '''
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double height;
  final bool isFullWidth;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = 56,
    this.isFullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.onPrimary,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
''';
  }

  // BUTTONS - Secondary Button
  static String generateSecondaryButton() {
    return '''
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? width;
  final double height;
  final bool isFullWidth;

  const SecondaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.icon,
    this.width,
    this.height = 56,
    this.isFullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: theme.colorScheme.primary,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''';
  }

  // BUTTONS - Social Auth Button
  static String generateSocialAuthButton() {
    return '''
import 'package:flutter/material.dart';

enum SocialAuthProvider { google, apple, facebook, github }

class SocialAuthButton extends StatelessWidget {
  final SocialAuthProvider provider;
  final VoidCallback? onPressed; // Make onPressed nullable
  final bool isLoading;
  final double height;

  const SocialAuthButton({
    Key? key,
    required this.provider,
    required this.onPressed, // Still required but can be null
    this.isLoading = false,
    this.height = 56,
  }) : super(key: key);

  String get _buttonText {
    switch (provider) {
      case SocialAuthProvider.google:
        return 'Continue with Google';
      case SocialAuthProvider.apple:
        return 'Continue with Apple';
      case SocialAuthProvider.facebook:
        return 'Continue with Facebook';
      case SocialAuthProvider.github:
        return 'Continue with GitHub';
    }
  }

  IconData get _icon {
    switch (provider) {
      case SocialAuthProvider.google:
        return Icons.g_mobiledata;
      case SocialAuthProvider.apple:
        return Icons.apple;
      case SocialAuthProvider.facebook:
        return Icons.facebook;
      case SocialAuthProvider.github:
        return Icons.code;
    }
  }

  Color get _backgroundColor {
    switch (provider) {
      case SocialAuthProvider.google:
        return Colors.white;
      case SocialAuthProvider.apple:
        return Colors.black;
      case SocialAuthProvider.facebook:
        return const Color(0xFF1877F2);
      case SocialAuthProvider.github:
        return const Color(0xFF24292E);
    }
  }

  Color get _textColor {
    switch (provider) {
      case SocialAuthProvider.google:
        return Colors.black87;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed, // This now works with nullable
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor,
          foregroundColor: _textColor,
          elevation: provider == SocialAuthProvider.google ? 1 : 0,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: provider == SocialAuthProvider.google
                ? const BorderSide(color: Color(0xFFE0E0E0))
                : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(_textColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_icon, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    _buttonText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _textColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
''';
  }

  // INPUTS - App Text Field
  static String generateAppTextField() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final String? helperText;

  const AppTextField({
    Key? key,
    required this.label,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.helperText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, size: 22)
            : null,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: theme.colorScheme.outline,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
    );
  }
}
''';
  }

  // INPUTS - Password Field
  static String generatePasswordField() {
    return '''
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool showStrengthIndicator;
  final Function(String)? onChanged;

  const PasswordField({
    Key? key,
    this.label = 'Password',
    this.hint,
    this.controller,
    this.validator,
    this.showStrengthIndicator = false,
    this.onChanged,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  double _strength = 0.0;
  String _strengthText = '';
  Color _strengthColor = Colors.red;

  void _calculateStrength(String password) {
    if (!widget.showStrengthIndicator) return;

    double strength = 0.0;
    if (password.isEmpty) {
      setState(() {
        _strength = 0.0;
        _strengthText = '';
      });
      return;
    }

    // Length check
    if (password.length >= 8) strength += 0.25;
    if (password.length >= 12) strength += 0.25;

    // Contains lowercase
    if (password.contains(RegExp(r'[a-z]'))) strength += 0.15;

    // Contains uppercase
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.15;

    // Contains numbers
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.1;

    // Contains special characters
    if (password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) strength += 0.1;

    String text;
    Color color;

    if (strength < 0.3) {
      text = 'Weak';
      color = Colors.red;
    } else if (strength < 0.6) {
      text = 'Fair';
      color = Colors.orange;
    } else if (strength < 0.8) {
      text = 'Good';
      color = Colors.blue;
    } else {
      text = 'Strong';
      color = Colors.green;
    }

    setState(() {
      _strength = strength;
      _strengthText = text;
      _strengthColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: _obscureText,
          onChanged: (value) {
            _calculateStrength(value);
            widget.onChanged?.call(value);
          },
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint ?? 'Enter your password',
            prefixIcon: const Icon(Icons.lock_outline, size: 22),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                size: 22,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
          ),
        ),
        if (widget.showStrengthIndicator && _strength > 0) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _strength,
                    backgroundColor: theme.colorScheme.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(_strengthColor),
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _strengthText,
                style: TextStyle(
                  color: _strengthColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
''';
  }

  // INPUTS - OTP Input
  static String generateOTPInput() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPInput extends StatefulWidget {
  final int length;
  final Function(String) onCompleted;
  final Function(String)? onChanged;

  const OTPInput({
    Key? key,
    this.length = 6,
    required this.onCompleted,
    this.onChanged,
  }) : super(key: key);

  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.length,
      (index) => FocusNode(),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    final otp = _controllers.map((c) => c.text).join();
    widget.onChanged?.call(otp);

    if (otp.length == widget.length) {
      widget.onCompleted(otp);
    }
  }

  void _onKeyEvent(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        widget.length,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.length > 4 ? 4.0 : 8.0,
            ),
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (event) => _onKeyEvent(event, index),
              child: TextFormField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: theme.colorScheme.outline.withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onChanged: (value) => _onChanged(value, index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''';
  }

  // Generate all widgets at once
  static Map<String, String> generateAllWidgets() {
    return {
      // Buttons
      'buttons/primary_button.dart': generatePrimaryButton(),
      'buttons/secondary_button.dart': generateSecondaryButton(),
      'buttons/social_auth_button.dart': generateSocialAuthButton(),

      // Inputs
      'inputs/app_text_field.dart': generateAppTextField(),
      'inputs/password_field.dart': generatePasswordField(),
      'inputs/otp_input.dart': generateOTPInput(),
    };
  }
}
