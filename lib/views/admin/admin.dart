import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy/models/modules.dart';
import 'package:pregnancy/repositories/file_repository.dart';

import '../../blocs/module/module_bloc.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleListWidget();
  }
}

class ModuleListWidget extends StatelessWidget {
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
            child: ModuleList(
              modules: modules,
            ),
          );
        }
      },
    );
  }
}

class ModuleList extends StatelessWidget {
  final List<Module> modules;
  const ModuleList({super.key, required this.modules});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: modules.length,
      itemBuilder: (context, index) {
        Module module = modules[index];

        // Customize this part based on how you want to display each module
        return ListTile(
          onTap: () {
            context.push('/module', extra: module.toJson());
          },
          leading: Image.asset('lib/images/folder.png'),
          title: Text(
            module.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle:
              Text(DateFormat('MM/dd/yyyy hh:mm aa').format(module.createdAt)),
          // trailing: IconButton(
          //   icon: const Icon(
          //     Icons.delete,
          //     color: Colors.red,
          //   ),
          //   onPressed: () {
          //     context
          //         .read<ModuleBloc>()
          //         .add(DeleteModule(module.id, module.url));
          //   },
          // ),
          // Add more fields as needed
        );
      },
    );
  }
}
