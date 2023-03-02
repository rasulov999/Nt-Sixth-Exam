import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_sixth_exam/cubit/get_cards_cubit.dart';
import 'package:nt_sixth_exam/cubit/get_cards_state.dart';
import 'package:nt_sixth_exam/ui/screens/add_cards/add_cards_screen.dart';
import 'package:nt_sixth_exam/ui/screens/all_cards/widget/card_item.dart';

class AllCardsScreen extends StatelessWidget {
  const AllCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Cards Screen"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCardScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocBuilder<CardsCubit, CardsState>(
          builder: (context, state) {
            if (state is InitialCardsState) {
              return Center(
                child: Lottie.asset("assets/lottie/no_data.json"),
              );
            } else if (state is LoadCardsInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadCardsInSuccess) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: List.generate(
                  state.cardModel.length,
                  (index) => CardItem(
                  //  gradient: state.cardModel[index].gradient ,
                    model: state.cardModel[index],
                  ),
                ),
              );
            } else if (state is LoadCardsInFailure) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }

            return Container(
              width: 20,
              height: 20,
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }

  hexColor(String colorhexcode) {
    String colornew = '0xff$colorhexcode';
    colornew = colornew.replaceAll("#", "");
    int colorint = int.parse(colornew);
    return colorint;
  }
}
