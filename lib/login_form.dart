library login_form;

import 'package:flutter/material.dart';

typedef LoginValueCallback = void Function(String, String);

class LoginForm extends StatefulWidget {
  final String? userLabel;
  final String? userHint;
  final String? userHelper;
  final String? passwordLabel;
  final String? passwordHint;
  final String? passwordHelper;

  final InputBorder? border;
  final bool? filled;
  final Color? fillColor;
  final TextStyle? labelStyle;

  final FormFieldValidator<String>? userValidator;
  final FormFieldValidator<String>? passwordValidator;

  //input text style
  final TextStyle? style;

  final double? loginHeight;
  final Color? loginColor;
  final Widget? loginChild;
  final double? loginRadius;
  final LoginValueCallback? loginOnTap;
  const LoginForm(
      {Key? key,
      this.userLabel,
      this.userHint,
      this.userHelper,
      this.passwordLabel,
      this.passwordHint,
      this.passwordHelper,
      this.border,
      this.filled,
      this.fillColor,
      this.style,
      this.userValidator,
      this.passwordValidator,
      this.loginColor,
      this.loginChild,
      this.loginRadius,
      this.loginOnTap,
      this.loginHeight,
      this.labelStyle})
      : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  late TextEditingController _userController;
  late TextEditingController _passwordController;
  final focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _userController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _userController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _userController,
            validator: widget.userValidator,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(focus);
            },
            style: widget.style,
            decoration: InputDecoration(
                border: widget.border,
                focusedBorder: widget.border,
                fillColor: widget.fillColor,
                filled: widget.filled,
                labelText: widget.userLabel,
                labelStyle: widget.labelStyle,
                hintText: widget.userHint),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            focusNode: focus,
            obscureText: _obscureText,
            validator: widget.passwordValidator,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) {},
            style: widget.style,
            decoration: InputDecoration(
              border: widget.border,
              focusedBorder: widget.border,
              fillColor: widget.fillColor,
              filled: widget.filled,
              hintText: widget.passwordHint,
              labelText: widget.passwordLabel,
              labelStyle: widget.labelStyle,
              helperText: widget.passwordHelper,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: widget.labelStyle?.color,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: widget.loginHeight ?? 40,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() == false) {
                  return;
                }
                if (widget.loginOnTap != null)
                  widget.loginOnTap!(
                      _userController.text, _passwordController.text);
              },
              child: widget.loginChild,
              style: ElevatedButton.styleFrom(
                  elevation: 10,
                  primary: widget.loginColor ?? Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(widget.loginRadius ?? 0))),
            ),
          ),
        ],
      ),
    );
  }
}
