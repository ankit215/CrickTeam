import 'package:crick_team/utils/search_delay_function.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'AddTeams.dart';

class AddPlayerCategory extends StatefulWidget {
  final List<Team> selectedTeam;

  const AddPlayerCategory({super.key, required this.selectedTeam});

  @override
  State<AddPlayerCategory> createState() => _AddPlayerCategoryState();
}

class _AddPlayerCategoryState extends State<AddPlayerCategory> {
  TextEditingController searchController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final searchDelay = SearchDelayFunction();
  var searchStr = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.brown2,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context,"player_category_screen");
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(
              "assets/back_arrow.png",
              color: Colors.white,
            ),
          ),
        ),
        title: const Text(
          "Select Player Category",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Lato_Semibold",
            color: AppColor.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        color: AppColor.lightGreyTrans,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.selectedTeam.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white
                                /*gradient:LinearGradient(
                                        colors: [
                                          AppColor.grey.withOpacity(0.6),
                                          AppColor.grey.withOpacity(0.2),
                                        ],
                                      )*/
                                ,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            child: ClipOval(
                                                child: Image.asset(
                                              "assets/player.png",
                                              fit: BoxFit.contain,
                                              height: 45,
                                              width: 45,
                                            )),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.selectedTeam[index].playerName
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "Lato_Semibold",
                                                  color: AppColor.medGrey,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                  widget.selectedTeam[index].playerCategory
                                                      .toString().isEmpty?"-":widget.selectedTeam[index].playerCategory
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "Lato_Semibold",
                                                  color: AppColor.medGrey,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                   Row(children: [
                                     GestureDetector(
                                       onTap: () {
                                         setState(() {
                                           widget.selectedTeam[index].playerCategory="Bowler";
                                         });
                                       },
                                       child: Image.asset(
                                         "assets/bowler.png",
                                         height: 30,
                                         width: 30,
                                         color: widget.selectedTeam[index].playerCategory.toString().toLowerCase()=="bowler"?Colors.red:AppColor.text_grey,
                                       ),
                                     ),
                                     GestureDetector(
                                       onTap: () {
                                         setState(() {
                                           widget.selectedTeam[index].playerCategory="Batsmen";
                                         });
                                       },
                                       child: Image.asset(
                                         "assets/striker.png",
                                         height: 30,
                                         width: 30,
                                         color: widget.selectedTeam[index].playerCategory.toString().toLowerCase()=="batsmen"?Colors.red:AppColor.text_grey,
                                       ),
                                     ),
                                     GestureDetector(
                                       onTap: () {
                                         setState(() {
                                           widget.selectedTeam[index].playerCategory="Wicket Keeper";
                                         });
                                       },
                                       child: Image.asset(
                                         "assets/keeper.png",
                                         height: 30,
                                         width: 30,
                                         color: widget.selectedTeam[index].playerCategory.toString().toLowerCase()=="wicket keeper"?Colors.red:AppColor.text_grey,
                                       ),
                                     ),
                                     GestureDetector(
                                       onTap: () {
                                         setState(() {
                                           widget.selectedTeam[index].playerCategory="All Rounder";
                                         });
                                       },
                                       child: Image.asset(
                                         "assets/bat_ball.png",
                                         height: 30,
                                         width: 30,
                                         color: widget.selectedTeam[index].playerCategory.toString().toLowerCase()=="all rounder"?Colors.red:AppColor.text_grey,
                                       ),
                                     ),
                                   ],)
                                  ],
                                ),
                              ))),
                    );
                  }),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, top: 30),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  AppColor.red,
                  AppColor.brown2,
                ]),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<StadiumBorder>(
                      const StadiumBorder(),
                    ),
                    elevation: MaterialStateProperty.all(8),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    // elevation: MaterialStateProperty.all(3),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Add Player',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.white,
                        fontFamily: "Lato_Semibold",
                        fontSize: 16),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
