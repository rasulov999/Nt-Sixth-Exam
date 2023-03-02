import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nt_sixth_exam/bloc/single_state_bloc.dart';
import 'package:nt_sixth_exam/data/model/card_model.dart';
import 'package:nt_sixth_exam/ui/screens/update_cards/update_cards_screen.dart';
import 'package:nt_sixth_exam/utils/colors.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.model,
  });
  final CardModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.only(left: 20, top: 20),
        width: MediaQuery.of(context).size.width,
        height: 185,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.deepPurpleAccent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.cardNumber,
              style: const TextStyle(color: MyColors.white, fontSize: 23),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  model.expireData,
                  style: const TextStyle(color: MyColors.white, fontSize: 20),
                ),
                const Spacer(),
                SizedBox(
                    height: 30,
                    width: 55,
                    child: Image.network(
                        "https://humocard.uz/bitrix/templates/main/img/card2.png")),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              model.cardName,
              style: const TextStyle(color: MyColors.white, fontSize: 17),
            ),
            const Spacer(),
            Row(children: [
              Expanded(
                child: Text(
                  model.owner,
                  style: const TextStyle(color: MyColors.white, fontSize: 19),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: const Text(
                                  "Haqiqatdan ham o'chirmoqchimisiz"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Yo'q")),
                                ElevatedButton(
                                    onPressed: () {
                                      context.read<AUDStateBloc>().add(
                                            DeleteCard(
                                              cardId: model.cardId,
                                            ),
                                          );
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ha")),
                              ],
                            ));
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UpdateCardsScreen()));
                },
                icon: const Icon(
                  Icons.edit,
                  color: MyColors.white,
                  size: 21,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
