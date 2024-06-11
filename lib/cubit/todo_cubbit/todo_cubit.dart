import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/cubit/cubit_state/cubit_state.dart';
import 'package:todoapp/models/todo_model.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit <CubitState<TodoState>> {
  TodoCubit() : super(InitialState());



 final List<ToDoModel> tempList = [];
  void addTodos({required String name, required String email}) {
     emit(const LoadingState());

    tempList.add(ToDoModel(name: name, email: email));
    print(tempList);

    final todoState = TodoState(todos: [...tempList]);
    emit(LoadedState(todoState));
    
  }

  void deleteTodos({required int index}) {
  

    tempList.removeAt(index);
    final deleteState = TodoState(todos: [...tempList]);

    emit(LoadedState(deleteState));
  }

  void updateTodos(
      {required int index, required String name, required String email}) {
   

    tempList[index] = ToDoModel(name: name, email: email);
    final updatedState = TodoState(todos: [...tempList]);
    print("updatedList : $tempList");

    emit(LoadedState(updatedState));
  }

}


