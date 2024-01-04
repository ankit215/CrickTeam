import 'package:crick_team/startMatchRelatedScreens/SelectTeam.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/material.dart';

import '../main.dart';


class SelectPlayingTeams extends StatefulWidget {
  const SelectPlayingTeams({super.key});

  @override
  State<SelectPlayingTeams> createState() => _SelectPlayingState();
}

class _SelectPlayingState extends State<SelectPlayingTeams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.brown2,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
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
          "Select Playing Teams",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Lato_Bold",
            color: AppColor.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height*0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(getContext, MaterialPageRoute(builder: (context) =>  const SelectTeam(team: "A",)));
              },
              child: const Center(
                  child: Icon(
                Icons.add_circle_rounded,
                color: AppColor.medBrown,
                size: 100,
              )),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(getContext, MaterialPageRoute(builder: (context) => const SelectTeam(team: "A",)));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.brown2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Select Team A",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Lato_Sembold",
                      color: AppColor.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Image.asset("assets/vs.png",color:AppColor.brown2,width: 40,height: 40,fit: BoxFit.contain,),
            const SizedBox(height: 10,),

            GestureDetector(
              onTap: (){
                Navigator.push(getContext, MaterialPageRoute(builder: (context) =>  const SelectTeam(team: "B",)));
              },
              child: const Center(
                  child: Icon(
                Icons.add_circle_rounded,
                color: AppColor.medBrown,
                size: 100,
              )),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(getContext, MaterialPageRoute(builder: (context) =>  const SelectTeam(team: "B",)));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.brown2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Select Team B",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Lato_Sembold",
                      color: AppColor.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
