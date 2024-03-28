// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_provider_/controller/Provider/selectedSize_provider.dart';

class AvailableSize extends StatelessWidget {
  final String size;
  const AvailableSize({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SizeSelection>(
      builder: (context, sizeSelection, _) {
        final isSelected = sizeSelection.selectedSize == size;
        return GestureDetector(
          onTap: () => sizeSelection.setSelectedSize(size),
          child: Container(
            margin: const EdgeInsets.only(right: 13),
            width: 55,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.blue),
            ),
            child: Text(
              size,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
