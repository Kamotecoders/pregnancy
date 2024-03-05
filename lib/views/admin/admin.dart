import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy/models/modules.dart';
import 'package:pregnancy/repositories/file_repository.dart';

import '../../blocs/module/module_bloc.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ModuleBloc(fileRepository: context.read<FileRepository>()),
      child: StreamBuilder<List<Module>>(
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
            return BlocConsumer<ModuleBloc, ModuleState>(
              listener: (context, state) {
                if (state is ModuleSuccessState<String>) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.data)));
                }
                if (state is ModuleErrorState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                return state is ModuleLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: modules.length,
                        itemBuilder: (context, index) {
                          Module module = modules[index];
                          return ModuleList(
                            modules: module,
                            onTap: (Module module) => {
                              context
                                  .read<ModuleBloc>()
                                  .add(DeleteModule(module.id, module.url))
                            },
                          );
                        },
                      );
              },
            );
          }
        },
      ),
    );
  }
}

class ModuleList extends StatelessWidget {
  final Module modules;
  final Function(Module module) onTap;
  const ModuleList({Key? key, required this.modules, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ModuleBloc(fileRepository: context.read<FileRepository>()),
      child: Dismissible(
        key: Key(modules.id), // Unique key for each module
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: Icon(Icons.delete, color: Color.fromARGB(255, 142, 238, 209)),
        ),
        confirmDismiss: (_) {
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Delete Module'),
              content: Text('Are you sure you want to delete this module?'),
              actions: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    onTap(modules);
                    context.pop();
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          );
        },
        onDismissed: (_) {
          print("test");
        },
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/module',
                arguments: modules.toJson());
          },
          leading: Image.asset('lib/images/folder.png'),
          title: Text(
            modules.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle:
              Text(DateFormat('MM/dd/yyyy hh:mm aa').format(modules.createdAt)),
        ),
      ),
    );
  }
}
