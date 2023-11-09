import 'package:flutter/material.dart';

class OriginalButton extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;
  final Color bgColor;

  const OriginalButton({
    super.key,
    required this.text,
    required this.onpressed,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: onpressed,
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white)),
      ),
    );
  }
}
