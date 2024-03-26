import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_provider_/controller/Provider/selectedSize_provider.dart';

class AvailableSize extends StatefulWidget {
  final String size;
  const AvailableSize({super.key, required this.size});

  @override
  State<AvailableSize> createState() => _AvailableSizeState();
}

class _AvailableSizeState extends State<AvailableSize> {
  @override
  Widget build(BuildContext context) {
    final sizeSelection = Provider.of<SizeSelection>(context);
    final isSelected = sizeSelection.selectedSize == widget.size;

    return GestureDetector(
      onTap: () => sizeSelection.setSelectedSize(widget.size),
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
          widget.size,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
