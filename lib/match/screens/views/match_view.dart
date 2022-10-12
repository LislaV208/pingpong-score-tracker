// import 'package:flutter/material.dart';
// import 'package:pingpong_score_tracker/match/widgets/end_match_dialog.dart';

// class MatchView extends StatelessWidget {
//   const MatchView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return await showDialog(
//           context: context,
//           builder: (context) => const EndMatchDialog(),
//         );
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: MatchScore(
//             teamLeft: state.leftPlayer.name,
//             teamRight: state.rightPlayer.name,
//             scoreLeft: state.leftPlayerMatchScore,
//             scoreRight: state.rightPlayerMatchScore,
//           ),
//         ),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 14),
//                 child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: [
//                     Column(
//                       children: [
//                         Expanded(
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: PlayerPointButton(
//                                   player: state.leftPlayer,
//                                   currentPlayerServing:
//                                       state.currentPlayerServing,
//                                   setScore: state.leftPlayerSetScore,
//                                 ),
//                               ),
//                               const VerticalDivider(
//                                 thickness: 4.0,
//                                 color: Colors.white,
//                               ),
//                               Expanded(
//                                 child: PlayerPointButton(
//                                   player: state.rightPlayer,
//                                   currentPlayerServing:
//                                       state.currentPlayerServing,
//                                   setScore: state.rightPlayerSetScore,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 8.0),
//                       child: UndoButton(
//                         onPressed: state.canUndo
//                             ? () {
//                                 context.read<StandardMatchCubit>().undo();
//                               }
//                             : null,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
