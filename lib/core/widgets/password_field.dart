
import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/widgets/custom_text_field.dart';

class passwordField extends StatefulWidget {
  const passwordField({
    super.key, this.onSaved,
  });
 
final void Function(String?)? onSaved;

  @override
  State<passwordField> createState() => _passwordFieldState();
}

class _passwordFieldState extends State<passwordField> {

  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      obscureText: isObscure,
      onSaved: widget.onSaved, // Pass the onSaved callback from parent
      hintText: 'كلمة المرور',
      textInputType: TextInputType.visiblePassword,
      suffixIcon: GestureDetector(
        onTap: () {
          isObscure = !isObscure;
          setState(() {
          });
        },
        child: isObscure ? Icon(Icons.remove_red_eye , color: Color(0xffC9CECF),) : Icon(Icons.visibility_off , color: Color(0xffC9CECF),),
      ),
    );
  }
}