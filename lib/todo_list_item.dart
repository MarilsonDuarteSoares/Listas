import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:listas/todo.dart';






class TodoListItem extends StatelessWidget {
  TodoListItem({super.key, required this.todo, required this.onDelete});

  final Todo todo;
  final Function (Todo) onDelete;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Slidable(
          endActionPane: ActionPane(
          motion: DrawerMotion(),
          extentRatio: 0.12,
          children: [
              SlidableAction(
              onPressed: ((CONTEXT) {
                onDelete (todo); // Deletar
              }),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Deletar',

          ),
          ]
          ),


        child: SizedBox(width: 820,
          child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.grey[200],

                        ),


                        padding: const EdgeInsets.all(16),



            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text (
                                DateFormat ('dd/MM/yyyy - HH:mm').format(todo.datetime),
                                style: const TextStyle (fontSize: 12),
                            ),

                            Text (
                              todo.title, style: const TextStyle (fontSize: 16, fontWeight: FontWeight.w600),)

                        ]

                        )

                      ),
        ),
      ),
    );

    



  }

  


}



