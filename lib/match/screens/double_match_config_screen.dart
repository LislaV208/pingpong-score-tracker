// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:pingpong_score_tracker/match/bloc/double_match_state.dart';
// import 'package:pingpong_score_tracker/match/bloc/standard_match_cubit.dart';
// import 'package:pingpong_score_tracker/match/bloc/standard_match_state.dart';
// import 'package:pingpong_score_tracker/match/screens/standard_match_screen.dart';
// import 'package:pingpong_score_tracker/match/widgets/standard_serve_dialog.dart';
// import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
// import 'package:pingpong_score_tracker/players/models/player.dart';

// class DoubleMatchConfigScreen extends HookWidget {
//   const DoubleMatchConfigScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final leftTopPlayer = useState<String?>(null);
//     final leftBottomPlayer = useState<String?>(null);
//     final rightTopPlayer = useState<Player?>(null);
//     final rightBottomPlayer = useState<Player?>(null);

//     final players = context
//         .select<PlayersCubit, List<Player>>((cubit) => cubit.state.players);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Konfiguracja meczu'),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Zawodnik w lewym górnym:'),
//                         SizedBox(width: 20.0),
//                         DropdownButton<String>(
//                           value: leftTopPlayer.value,
//                           items: players
//                               .map(
//                                 (item) => DropdownMenuItem<String>(
//                                   value: item,
//                                   child: Text(item.name),
//                                 ),
//                               )
//                               .toList(),
//                           onChanged: (value) {
//                             if (value != null) {
//                               leftTopPlayer.value = value;
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Zawodnik w lewym dolnym:'),
//                         SizedBox(width: 20.0),
//                         DropdownButton<Player>(
//                           value: leftBottomPlayer.value,
//                           items: players
//                               .map(
//                                 (item) => DropdownMenuItem<Player>(
//                                   value: item,
//                                   child: Text(item.name),
//                                 ),
//                               )
//                               .toList(),
//                           onChanged: (value) {
//                             if (value != null) {
//                               leftBottomPlayer.value = value;
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               VerticalDivider(thickness: 5.0),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Zawodnik w prawym górnym:'),
//                         SizedBox(width: 20.0),
//                         DropdownButton<Player>(
//                           value: rightTopPlayer.value,
//                           items: players
//                               .map(
//                                 (item) => DropdownMenuItem<Player>(
//                                   value: item,
//                                   child: Text(item.name),
//                                 ),
//                               )
//                               .toList(),
//                           onChanged: (value) {
//                             if (value != null) {
//                               rightTopPlayer.value = value;
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Zawodnik w prawym dolnym:'),
//                         SizedBox(width: 20.0),
//                         DropdownButton<Player>(
//                           value: rightBottomPlayer.value,
//                           items: players
//                               .map(
//                                 (item) => DropdownMenuItem<Player>(
//                                   value: item,
//                                   child: Text(item.name),
//                                 ),
//                               )
//                               .toList(),
//                           onChanged: (value) {
//                             if (value != null) {
//                               rightBottomPlayer.value = value;
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: canProceed(
//           leftTopPlayer.value,
//           leftBottomPlayer.value,
//           rightTopPlayer.value,
//           rightBottomPlayer.value,
//         )
//             ? () async {
//                 final navigator = Navigator.of(context);
//                 final playerServing = await showDialog<Player>(
//                   barrierDismissible: false,
//                   context: context,
//                   builder: (context) => StandardServeDialog(
//                     leftPlayer: leftTopPlayer.value!,
//                     rightPlayer: rightTopPlayer.value!,
//                   ),
//                 );

//                 if (playerServing != null) {
//                   navigator.pushReplacement(
//                     MaterialPageRoute(
//                       builder: (context) => BlocProvider(
//                         create: (context) => DoubleMatchCubit(
//                           DoubleMatchState(
//                             leftPlayer: leftTopPlayer.value!,
//                             rightPlayer: rightTopPlayer.value!,
//                             playerServing: playerServing,
//                             currentPlayerServing: playerServing,
//                           ),
//                         ),
//                         child: StandardMatchScreen(
//                           leftPlayer: leftTopPlayer.value!,
//                           rightPlayer: rightTopPlayer.value!,
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//               }
//             : null,
//         backgroundColor: canProceed(
//           leftTopPlayer.value,
//           leftBottomPlayer.value,
//           rightTopPlayer.value,
//           rightBottomPlayer.value,
//         )
//             ? null
//             : Colors.grey,
//         child: const Icon(Icons.arrow_forward),
//       ),
//     );
//   }

//   bool canProceed(Player? leftTop, Player? leftBottom, Player? rightTop,
//           Player? rightBottom) =>
//       leftTop != null &&
//       leftBottom != null &&
//       rightTop != null &&
//       rightBottom != null;
// }
