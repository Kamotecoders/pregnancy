import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy/styles/color_pallete.dart';
import 'package:pregnancy/widgets/lessons_card.dart';

import '../../../blocs/module/module_bloc.dart';
import '../../../models/lessons.dart';
import '../../../models/modules.dart';
import '../../../repositories/file_repository.dart';

class LessonPage extends StatelessWidget {
  const LessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Module / Lessons",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        backgroundColor: ColorStyle.primary,
      ),
      body: ListLessons(),
    );
  }
}

class ListLessons extends StatelessWidget {
  const ListLessons({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Module>>(
      stream: context.read<FileRepository>().fetchModulesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for data, show a loading indicator
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If there's an error, display an error message
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // If data is available, build the UI with the list of modules
          List<Module> modules = snapshot.data ?? [];
          return BlocProvider(
            create: (context) =>
                ModuleBloc(fileRepository: context.read<FileRepository>()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ModuleCard(
                modules: modules,
              ),
            ),
          );
        }
      },
    );
  }
}

class ModuleCard extends StatelessWidget {
  final List<Module> modules;
  const ModuleCard({super.key, required this.modules});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: modules.length,
      itemBuilder: (context, index) {
        Module module = modules[index];
        return GestureDetector(
          onTap: () {
            // Assuming you have a navigation method like 'context.push'
            // Navigate to the module view with module data
            context.push('/module', extra: module.toJson());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/folder.png',
                height: 100.0, // Adjust the image height as needed
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  module.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
