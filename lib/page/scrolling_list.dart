import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrolling_list/bloc/string_bloc.dart';
import 'package:scrolling_list/model/app_state.dart';

class ScrollingList extends StatefulWidget {
  const ScrollingList({Key? key}) : super(key: key);

  @override
  State<ScrollingList> createState() => _ScrollingListState();
}

class _ScrollingListState extends State<ScrollingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of String"),
      ),
      body:  BlocConsumer<StringBloc, AppState<List<String>>>(
        listener: (context, state) {
          if (state is FailureAppState<List<String>>) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("$state"), backgroundColor: Colors.red,));
          }
        },
        builder: (context, state){
          if(state is LoadingAppState<List<String>>){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state is SuccessListAppState<List<String>>){
            return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(""),
                    ),
                    title: Text(state.data[index].toString()),
                  );
            });
          }
          return const Center(child: Text("No  data"));
        },
      )
    );
  }
}
