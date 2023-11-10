import 'package:flutter/material.dart';
import 'package:listas/todo.dart';
import 'package:listas/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];
  Todo? deleteTodo;
  int? deleteTodoPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adicione uma tarefa',
                          hintText: 'Ex. Estudar Flutter',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;

                        setState(() {
                          Todo newTodo =
                              Todo(title: text, datetime: DateTime.now());

                          todos.add(newTodo);
                        });

                        todoController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff00d7f3),
                        padding: EdgeInsets.all(17),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(todo: todo, onDelete: onDelete),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child:
                          Text('Você possui ${todos.length} tarefas pendentes'),
                    ),
                    ElevatedButton(
                      onPressed: showdeleteAlltodosDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff00d7f3),
                        padding: EdgeInsets.all(17),
                      ),
                      child: Text('Limpar tudo'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deleteTodo = todo;
    deleteTodoPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '        Tarefa removida com sucesso !',
          style: TextStyle(
              color: Color(0xff060708),
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer ?',
          onPressed: () {
            setState(() {
              todos.insert(deleteTodoPos!, deleteTodo!);
            });
          },
          backgroundColor: Colors.red,
          textColor: Colors.white,
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void showdeleteAlltodosDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text ('Limpar Tudo ?', style: TextStyle(
            color: Color(0xff060708),
          fontSize: 25,
          fontWeight: FontWeight.w500),
        ),

        content: Text ('Você tem certeza que quer excluir todas as tarefas ?', style: TextStyle(
            color: Color(0xff060708),
          fontSize: 15, ),

        ),

        actions: [

          TextButton(
              onPressed: () {

                Navigator.of(context).pop();


              },

              child: Text('Cancelar')),

          TextButton(
              onPressed: () {

                Navigator.of(context).pop();
                deletarAll();


              },

              child: Text('Limpar Tudo',style: TextStyle(color: Colors.red),),),



        ],





      ),
    );
  }


  void deletarAll() {

    setState(() {
      todos.clear();
    });

  }



}
