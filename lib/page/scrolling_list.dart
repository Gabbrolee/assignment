import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrolling_list/bloc/data_bloc.dart';
import 'package:scrolling_list/model/app_state.dart';
import 'package:scrolling_list/service/data_service.dart';

class ScrollingList extends StatefulWidget {
  const ScrollingList({Key? key}) : super(key: key);
  @override
  State<ScrollingList> createState() => _ScrollingListState();
}

class _ScrollingListState extends State<ScrollingList> {
  final bloc = DataBloc();
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(FetchEvent());
      controller.addListener(onScroll);
    });
  }

  void onScroll() {
    if (controller.offset >= controller.position.maxScrollExtent) {
      bloc.add(FetchEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List of String")),
      body: BlocConsumer(
        bloc: bloc,
        listener: (context, AppState<String> state) {
          if (state is FailureAppState<List<String>>) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$state"), backgroundColor: Colors.red));
          }
        },
        builder: (context, AppState<String> state) {
          if (state is LoadingAppState<List<String>>) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SuccessListAppState<String>) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(DataService.imageUrl),
                  ),
                  title: Text(state.data[index].toString()),
                );
              },
            );
          }
          return const Center(child: Text("Could not fetch data!!!"));
        },
      ),
    );
  }
}
