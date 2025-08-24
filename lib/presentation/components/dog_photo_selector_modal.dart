import 'package:flutter/material.dart';
import 'package:flutter_dog_dashboard/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DogPhotoSelectorModal extends ConsumerWidget {
  const DogPhotoSelectorModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dogsAsync = ref.watch(randomDogsProvider(6));
    return SizedBox(
      height: 300,
      child: dogsAsync.when(
        data: (urls) => GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
          itemCount: urls.length,
          itemBuilder: (_, index) {
            final url = urls[index];
            return GestureDetector(
              onTap: () => Navigator.pop(context, url),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(url, fit: BoxFit.cover),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading images')),
      ),
    );
  }
}
