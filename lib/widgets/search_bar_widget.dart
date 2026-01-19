import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/search_provider.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.read<SearchProvider>();
    

    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search tasks...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.mic),
            onPressed: () => searchProvider.clear(),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: searchProvider.updateQuery,
      ),
    );
  }
}
