import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pregnancy/repositories/file_repository.dart';

import '../../blocs/module/module_bloc.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final moduleBloc =
        ModuleBloc(fileRepository: context.read<FileRepository>());

    moduleBloc.add(const GetAllModulesEvent());

    return BlocProvider(
      create: (context) => moduleBloc,
      child: ModuleListWidget(),
    );
  }
}

class ModuleListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModuleBloc, ModuleState>(
      builder: (context, state) {
        if (state is ModuleLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ModuleSuccessState<List<Map<String, String>>>) {
          final List<Map<String, String>> fileList = state.data;
          return ListView.builder(
            itemCount: fileList.length,
            itemBuilder: (context, index) {
              final module = fileList[index];

              return ListTile(
                onTap: () {
                  final String url = module['downloadURL'] ?? '';
                  final String encodedUrl = Uri.encodeComponent(url);
                  context.push('/pdf/$encodedUrl');
                },
                leading: const Icon(Icons.picture_as_pdf_rounded),
                title: Text(module['name'] ?? ''),
              );
            },
          );
        } else if (state is ModuleErrorState) {
          return Text('Error: ${state.message}');
        } else {
          return const Text('Unknown state');
        }
      },
    );
  }
}
