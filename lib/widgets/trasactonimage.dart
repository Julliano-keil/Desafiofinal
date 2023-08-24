import 'package:flutter/material.dart';

class TransactionImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height; // Corrigido de heigth para height
  final Function() onTap;

  const TransactionImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height, // Corrigido de heigth para height
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  imageUrl,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
