import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/cubit/cubit_state/cubit_state.dart';
import 'package:todoapp/cubit/todo_cubbit/todo_cubit.dart';

class TodoView extends StatelessWidget {
  TodoView({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateEmailController = TextEditingController();


 
 
 
 
 
 
 
 
 
 
 
 
 
 @override
  Widget build(BuildContext context) {
    final todoCubit = TodoCubit();
    return BlocProvider(
      create: (context) => todoCubit,
      child: BlocBuilder<TodoCubit, CubitState<TodoState>>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                          hintText: "Name", border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: emailController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                          hintText: "Email", border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<TodoCubit>().addTodos(
                              name: nameController.text,
                              email: emailController.text);
                          nameController.clear();
                          emailController.clear();
                        },
                        child: const Text("Add")),
                    const SizedBox(
                      height: 20,
                    ),
                    //MyDesign(),
  
                    BlocBuilder<TodoCubit, CubitState<TodoState>>(
                      builder: (context, state) {
                        return state.when(
                          initial: () => const SizedBox(),
                          loading: () => const CircularProgressIndicator(),
                          loaded: (todosState) {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: todosState.todos.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(todosState.todos[index].name),
                                    subtitle:
                                        Text(todosState.todos[index].email),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            updateNameController.text =
                                                todosState.todos[index].name;
  
                                            updateEmailController.text =
                                                todosState.todos[index].email;
                                            showDialog(
                                              context: context,
                                              builder: (ctx) {
                                                return BlocProvider.value(
                                                    value: todoCubit,
                                                    child: AlertDialog(
                                                      title:
                                                          const Text("Update"),
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          TextField(
                                                            controller:
                                                                updateNameController,
                                                            maxLines: 1,
                                                            decoration:
                                                                const InputDecoration(
                                                                    hintText:
                                                                        "Name",
                                                                    border:
                                                                        OutlineInputBorder()),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          TextField(
                                                            controller:
                                                                updateEmailController,
                                                            maxLines: 1,
                                                            decoration:
                                                                const InputDecoration(
                                                                    hintText:
                                                                        "Email",
                                                                    border:
                                                                        OutlineInputBorder()),
                                                          ),
                                                        ],
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              context
                                                                  .read<
                                                                      TodoCubit>()
                                                                  .updateTodos(
                                                                      index:
                                                                          index,
                                                                      name: updateNameController
                                                                          .text,
                                                                      email: updateEmailController
                                                                          .text);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "Update"))
                                                      ],
                                                    ));
                                              },
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            context
                                                .read<TodoCubit>()
                                                .deleteTodos(index: index);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          error: (e) => Text(e.toString()),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}
