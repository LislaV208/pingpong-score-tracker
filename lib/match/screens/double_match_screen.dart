// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';
// import 'package:pingpong_score_tracker/injectable/injectable.dart';
// import 'package:pingpong_score_tracker/match/bloc/double_match_state.dart';
// import 'package:pingpong_score_tracker/match/bloc/standard_match_cubit.dart';
// import 'package:pingpong_score_tracker/match/bloc/standard_match_state.dart';
// import 'package:pingpong_score_tracker/match/widgets/match_finished_dialog.dart';
// import 'package:pingpong_score_tracker/match/widgets/match_score.dart';
// import 'package:pingpong_score_tracker/match/widgets/player_name.dart';
// import 'package:pingpong_score_tracker/match/widgets/player_score.dart';
// import 'package:pingpong_score_tracker/players/bloc/players_cubit.dart';
// import 'package:pingpong_score_tracker/players/models/player.dart';
// import 'package:pingpong_score_tracker/players/screens/players_screen.dart';

// @injectable
// class DoubleMatchScreen extends StatelessWidget {
//   const DoubleMatchScreen({
//     super.key,
//     required this.leftTopPlayer,
//     required this.leftBottomPlayer,
//     required this.rightTopPlayer,
//     required this.rightBottomPlayer,
//   });

//   final Player leftTopPlayer;
//   final Player leftBottomPlayer;
//   final Player rightTopPlayer;
//   final Player rightBottomPlayer;

//   String get leftTeamName => '$leftTopPlayer - $leftBottomPlayer';
//   String get rightTeamName => '$rightTopPlayer - $rightBottomPlayer';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 00),
//           child: BlocConsumer<DoubleMatchCubit, DoubleMatchState>(
//               listener: (context, state) async {
//             if (state.isFinished) {
//               final navigator = Navigator.of(context);

//               // await showDialog(
//               //   barrierDismissible: false,
//               //   context: context,
//               //   builder: (context) => MatchFinishedDialog(
//               //     leftPlayer: leftPlayer,
//               //     rightPlayer: rightPlayer,
//               //     leftPlayerScore: state.leftPlayerMatchScore,
//               //     rightPlayerScore: state.rightPlayerMatchScore,
//               //   ),
//               // );
//               navigator.popUntil(
//                 ModalRoute.withName('/'),
//               );
//             }
//           }, builder: (context, state) {
//             return Column(
//               children: [
//                 MatchScore(
//                   teamLeft: '${leftTopPlayer.name} - ${leftBottomPlayer.name}',
//                   teamRight:
//                       '${rightTopPlayer.name} - ${rightBottomPlayer.name}',
//                   scoreLeft: state.leftPlayerMatchScore,
//                   scoreRight: state.rightPlayerMatchScore,
//                 ),
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: InkWell(
//                           onTap: () {
//                             context
//                                 .read<DoubleMatchCubit>()
//                                 .givePointToPlayer(leftTeamName);
//                           },
//                           child: Container(
//                             color: Colors.green.withOpacity(0.4),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 PlayerName(
//                                   name: leftTeamName,
//                                   isServing:
//                                       state.currentPlayerServing == leftPlayer,
//                                 ),
//                                 PlayerScore(score: state.leftPlayerSetScore),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       VerticalDivider(
//                         thickness: 4.0,
//                         color: Colors.white,
//                       ),
//                       Expanded(
//                         child: InkWell(
//                           onTap: () {
//                             context
//                                 .read<DoubleMatchCubit>()
//                                 .givePointToPlayer(rightPlayer);
//                           },
//                           child: Container(
//                             color: Colors.green.withOpacity(0.4),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 PlayerName(
//                                   name: rightPlayer.name,
//                                   isServing:
//                                       state.currentPlayerServing == rightPlayer,
//                                 ),
//                                 PlayerScore(score: state.rightPlayerSetScore),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
