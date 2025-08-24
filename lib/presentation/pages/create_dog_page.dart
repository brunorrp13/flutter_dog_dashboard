import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dog_dashboard/domain/entities/dog_info.dart';
import 'package:flutter_dog_dashboard/presentation/components/dog_photo_selector_modal.dart';
import 'package:flutter_dog_dashboard/presentation/pages/custom_camera_preview_page.dart';
import 'package:flutter_dog_dashboard/presentation/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';

class CreateDogPage extends ConsumerStatefulWidget {
  const CreateDogPage({super.key});

  @override
  ConsumerState<CreateDogPage> createState() => _CreateDogPageState();
}

class _CreateDogPageState extends ConsumerState<CreateDogPage> {
  bool _isEditingName = false;
  bool _isEditingOwnerName = false;
  String? _selectedCountry;
  late TextEditingController _nameController;
  late TextEditingController _ownerNameController;

  final _nameError = 'Please enter the dog\'s name.';
  final _dogPhotoError = 'Please select a photo of the dog.';
  final _ownerPhotoError = 'Please take a photo of the owner.';
  final _ownerNameError = 'Please enter the owner\'s name.';
  final _countryError = 'Please select a country.';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ownerNameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ownerNameController.dispose();
    super.dispose();
  }

  /// Just calls the notifier — UI reaction happens in ref.listen
  Future<void> _saveDog() async {
    await ref.read(getDogProvider.notifier).saveDog();
  }

  @override
  Widget build(BuildContext context) {
    final countriesAsync = ref.watch(countriesProvider);
    final dogAsync = ref.watch(getDogProvider);
    final showError = ref.watch(showErrorProvider);

    ref.listen<AsyncValue<DogInfo>>(getDogProvider, (previous, next) {
      final prevSaved = previous?.valueOrNull?.saved ?? false;
      final nextSaved = next.valueOrNull?.saved ?? false;

      if (nextSaved && !prevSaved) {
        // ✅ Dog was just saved
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dog saved successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        ref.read(getDogProvider.notifier).refresh();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('🐾 Dog Dashboard'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: dogAsync.when(
            data: (dog) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🐕 Dog Info Card
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _selectDogPhoto,
                          child: CircleAvatar(
                            radius: 90,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: dog.imageUrl.isNotEmpty
                                ? NetworkImage(dog.imageUrl)
                                : null,
                            child: dog.imageUrl.isEmpty
                                ? const Icon(Icons.pets, size: 60)
                                : null,
                          ),
                        ),
                        if (dog.imageUrl.isEmpty && showError)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              _dogPhotoError,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        const SizedBox(height: 12),
                        // 📝 Dog Name Editor
                        dog.name.isEmpty || _isEditingName
                            ? Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      autofocus: true,
                                      controller: _nameController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter the dog\'s name',
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.save,
                                        color: Colors.green),
                                    onPressed: () {
                                      setState(() {
                                        _isEditingName = false;
                                      });
                                      ref
                                          .read(getDogProvider.notifier)
                                          .updateName(_nameController.text);
                                    },
                                  ),
                                ],
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isEditingName = true;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        dog.name.isNotEmpty
                                            ? dog.name
                                            : 'Enter dog\'s name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(color: Colors.black)),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.edit),
                                  ],
                                ),
                              ),
                        if (dog.name.isEmpty && showError)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              _nameError,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // 🌍 Country Selector Card
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: countriesAsync.when(
                      data: (countries) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('🌍 Select Country of Origin',
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 12),
                          DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedCountry,
                            hint: const Text('Choose a country'),
                            items: countries
                                .map<DropdownMenuItem<String>>(
                                    (c) => DropdownMenuItem<String>(
                                          value: c['name'] as String,
                                          child: Text(c['name'] as String),
                                        ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCountry = value;
                                ref
                                    .read(getDogProvider.notifier)
                                    .updateCountryOfOrigin(
                                        _selectedCountry ?? '');
                              });
                            },
                          ),
                          if (dog.countryOfOrigin.isEmpty && showError)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                _countryError,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                      loading: () => const CircularProgressIndicator(),
                      error: (e, _) => Text('Error loading countries: $e'),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 👤 Owner Info
                Text('👤 Enter Owner\'s Name',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 16),
                dog.ownerName.isEmpty || _isEditingOwnerName
                    ? Row(
                        children: [
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              controller: _ownerNameController,
                              decoration: const InputDecoration(
                                hintText: 'Enter owner\'s name',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.save, color: Colors.green),
                            onPressed: () {
                              setState(() {
                                _isEditingOwnerName = false;
                              });
                              ref
                                  .read(getDogProvider.notifier)
                                  .updateOwnerName(_ownerNameController.text);
                            },
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            _isEditingOwnerName = true;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                dog.ownerName.isNotEmpty
                                    ? dog.ownerName
                                    : 'Enter owner\'s name',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: Colors.black)),
                            const SizedBox(width: 5),
                            const Icon(Icons.edit),
                          ],
                        ),
                      ),
                if (dog.ownerName.isEmpty && showError)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      _ownerNameError,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),

                const SizedBox(height: 16),

                // 📸 Owner Photo
                if (dog.ownerImageUrl != null)
                  Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(File(dog.ownerImageUrl!)),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CustomCameraPage()),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Owner photo captured successfully!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take Owner Photo'),
                  ),
                ),
                if (dog.ownerImageUrl == null && showError)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      _ownerPhotoError,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                const SizedBox(height: 24),

                // 💾 Save Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _saveDog,
                    icon: const Icon(Icons.save),
                    label: const Text('Save Dog'),
                  ),
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error loading dog: $e'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          setState(() {
            _selectedCountry = null;
            _ownerNameController.clear();
            _nameController.clear();
            _isEditingName = false;
            _isEditingOwnerName = false;
            ref.read(getDogProvider.notifier).resetData();
          }),
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Future<void> _selectDogPhoto() async {
    final selectedUrl = await showModalBottomSheet<String>(
      context: context,
      builder: (_) => const DogPhotoSelectorModal(),
    );

    if (selectedUrl != null) {
      ref.read(getDogProvider.notifier).updateDogPhoto(selectedUrl);
    }
  }
}
