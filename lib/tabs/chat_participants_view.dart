import 'package:flutter/material.dart';

import '../properties/config.dart';

class ChatParticipantsView extends StatelessWidget {
  const ChatParticipantsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: ParticipantsList.map(
          (Participant) {
            return Card(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(smallBorderRadius),
                ),
                leading: CircleAvatar(
                  child: Text(Participant.name![0].toUpperCase()),
                ),
                trailing: IconButton(
                  onPressed: RemoveParticipant,
                  icon: const Icon(Icons.remove_circle_outlined),
                ),
                title: Text(Participant.name!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                // onTap: () {
                //   Navigator.pushNamed(context, '/Participant',
                //       arguments: ScreenArguments(Participant.id));
                // },
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  void RemoveParticipant() {}
}


// test data
class Participant {
  int id;
  String? name;

  Participant({
    required this.id,
    this.name,
  });
}

List<Participant> ParticipantsList = [
  Participant(
    id: 1,
    name: 'Фермеры',
  ),
  Participant(
    id: 2,
    name: 'КТИТС',
  ),
  Participant(
    id: 3,
    name: 'думаем',
  ),
  Participant(
    id: 4,
    name: "Избранное",
  ),
  Participant(
    id: 5,
    name: 'Фермеры',
  ),
  Participant(
    id: 6,
    name: 'КТИТС',
  ),
  Participant(
    id: 7,
    name: 'думаем',
  ),
  Participant(
    id: 8,
    name: "Избранное",
  ),
  Participant(
    id: 9,
    name: 'Фермеры',
  ),
  Participant(
    id: 10,
    name: 'КТИТС',
  ),
  Participant(
    id: 11,
    name: 'думаем',
  ),
  Participant(
    id: 12,
    name: "Избранное",
  ),
  Participant(
    id: 9,
    name: 'Фермеры',
  ),
  Participant(
    id: 10,
    name: 'КТИТС',
  ),
  Participant(
    id: 11,
    name: 'думаем',
  ),
  Participant(
    id: 12,
    name: "Избранное",
  ),
];
