import 'dart:io';

import 'package:crick_team/apiRelatedFiles/rest_apis.dart';
import 'package:crick_team/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apiRelatedFiles/api_utils.dart';
import '../loginSignupRelatedFiles/LoginScreen.dart';
import '../main.dart';
import '../modalClasses/GetTeamModel.dart';
import '../modalClasses/TeamSelected.dart';
import '../utils/AppColor.dart';
import '../utils/CommonFunctions.dart';
import '../utils/constant.dart';
import '../utils/search_delay_function.dart';
import '../utils/shared_pref.dart';
import 'AddTeams.dart';

class SelectTeam extends StatefulWidget {
  final String team;
  final TeamSelected teamASelected;
  final TeamSelected teamBSelected;

  const SelectTeam(
      {super.key,
      required this.team,
      required this.teamASelected,
      required this.teamBSelected});

  @override
  State<SelectTeam> createState() => _SelectTeamState();
}

class _SelectTeamState extends State<SelectTeam> with TickerProviderStateMixin {
  late TabController tabController;
  TextEditingController teamController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final searchDelay = SearchDelayFunction();
  var searchStr = "";
  File? imageFile;
  List<GetTeamData> teamList = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    tabController.addListener(_handleTabSelection);
    Future.delayed(Duration.zero, () {
      getTeamListApi(searchStr);
    });
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 5.0,
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
          title: Text(
            "Select Team ${widget.team}",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Lato_Semibold",
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
          bottom: TabBar(
            controller: tabController,
            labelColor: AppColor.white,
            unselectedLabelColor: AppColor.grey,
            indicatorColor: AppColor.orange_light,
            tabs: <Widget>[
              Tab(
                child: SizedBox(
                  width: 100,
                  child: Text(
                    "MY TEAMS",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: tabController.index == 0
                          ? "Lato_Semibold"
                          : "Lato_Regular",
                    ),
                  ),
                ),
              ),
              Tab(
                child: SizedBox(
                  width: 100,
                  child: Center(
                    child: Text(
                      "ADD TEAM",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: tabController.index == 2
                            ? "Lato_Semibold"
                            : "Lato_Regular",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          myTeamsScreen(),
          addTeamScreen(),
        ],
      ),
    );
  }

  myTeamsScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            margin: const EdgeInsets.all(10),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColor.white,
                border: Border.all(color: AppColor.brown2)),
            child: Center(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        searchStr = value;
                        searchDelay.run(() {
                          if(searchStr.isEmpty){
                            setState(() {
                              searchController.text = "";
                              searchStr = "";
                              teamList.clear();
                              Future.delayed(Duration.zero, () {
                                getTeamListApi(searchStr);
                              });
                            });
                          }else{
                            Future.delayed(Duration.zero, () {
                              getTeamListApi(searchStr);
                            });
                          }
      
                        });
                      },
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Quick Search',
                          hintStyle: TextStyle(color: AppColor.medBrown)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  (searchStr == "")
                      ? Image.asset(
                    "assets/search.png",
                    color: Colors.red,
                  )
                      : GestureDetector(
                      onTap: () {
                        setState(() {
                          searchController.text = "";
                          searchStr = "";
                          teamList.clear();
                          Future.delayed(Duration.zero, () {
                            getTeamListApi(searchStr);
                          });
                        });
      
                      },
                      child: Image.asset(
                        "assets/cross.png",
                        height: 15,
                        width: 15,
                        color: AppColor.orange_0,
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            child: ListView.builder(
              itemCount: teamList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (widget.teamASelected.getTeamData == teamList[index] ||widget.teamBSelected.getTeamData == teamList[index]) {
                      CommonFunctions().showToastMessage(context, "Team already added for the match.");
                    } else if (widget.team == "A" ) {
                      widget.teamASelected.getTeamData = teamList[index];
                      Navigator.push(
                          getContext,
                          MaterialPageRoute(
                              builder: (context) => AddTeams(
                                getTeamData: teamList[index],
                                teamASelected: widget.teamASelected,
                                teamBSelected: widget.teamBSelected,
                                team: widget.team,
                              ))).then((value){if(value=="add_teams"){
                                  debugPrint("dadaddadaddsadasdad");
                                  setState(() {
                                    widget.teamASelected.getTeamData = null;
                                  });

                                }
                      });
                    } else if(widget.team == "B" ){
                      widget.teamBSelected.getTeamData = teamList[index];
                      Navigator.push(
                          getContext,
                          MaterialPageRoute(
                              builder: (context) => AddTeams(
                                getTeamData: teamList[index],
                                teamASelected: widget.teamASelected,
                                teamBSelected: widget.teamBSelected,
                                  team: widget.team
                              ))).then((value) {
                        debugPrint("dewdwd"+value);
                        if(value=="add_teams"){
                          debugPrint("dadaddadaddsadasdad");
                          setState(() {
                            widget.teamBSelected.getTeamData = null;
                          });
                        }
                      });
                    }/*else{
                      Navigator.push(
                          getContext,
                          MaterialPageRoute(
                              builder: (context) => AddTeams(
                                getTeamData: teamList[index],
                                teamASelected: widget.teamASelected,
                                teamBSelected: widget.teamBSelected,
                              )));
                    }*/

                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          // AppColor.yellow.withOpacity(0.5),
                          AppColor.yellowV2.withOpacity(0.3),
                          AppColor.brown2.withOpacity(0.2),
                          // AppColor.yellowMed.withOpacity(0.5),
                        ]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              "assets/team_placeholder.png",
                              fit: BoxFit.cover,
                              height: 90,
                              width: 90,
                              opacity: const AlwaysStoppedAnimation(.09),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                    child: teamList[index].teamPhoto == null
                                        ? Image.asset(
                                            "assets/team_placeholder.png",
                                            fit: BoxFit.contain,
                                            height: 80,
                                            width: 80,
                                          )
                                        : Image.network(
                                            mediaUrl +
                                                teamList[index].teamPhoto.toString(),
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      teamList[index].name.toString(),
                                      style: const TextStyle(
                                          fontFamily: "Lato_Semibold",
                                          color: AppColor.brown2,
                                          fontSize: 20),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          "assets/location.png",
                                          height: 15,
                                          width: 15,
                                          color: AppColor.brown2,
                                        ),
                                        Text(
                                          teamList[index].city.toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Lato_Semibold",
                                              letterSpacing: 1,
                                              color: AppColor.brown2),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

  addTeamScreen() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColor.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: AppColor.lightCream,
                        child: ClipOval(
                            child: imageFile == null
                                ? Image.asset(
                                    "assets/team_placeholder.png",
                                    fit: BoxFit.cover,
                                    color: AppColor.brown2,
                                    height: 60,
                                    width: 60,
                                  )
                                : Image.file(
                                    imageFile!,
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 80,
                      left: 85,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColor.brown2,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            _showBottomSheet(context);
                          },
                          child: Center(
                              child: Image.asset(
                            "assets/editing.png",
                            width: 15,
                            height: 15,
                            fit: BoxFit.contain,
                            color: AppColor.white,
                          )),
                        ),
                      ))
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Team Name *",
                style: TextStyle(
                    fontSize: 16.0,
                    color: AppColor.brown2,
                    fontFamily: "Lato_Semibold"),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColor.white,
                    border: Border.all(color: AppColor.border)),
                child: Center(
                  child: TextField(
                    controller: teamController,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Enter team name',
                        hintStyle: TextStyle(color: AppColor.grey)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "City/Town *",
                style: TextStyle(
                    fontSize: 16.0,
                    color: AppColor.brown2,
                    fontFamily: "Lato_Semibold"),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColor.white,
                    border: Border.all(color: AppColor.border)),
                child: Center(
                  child: TextField(
                    controller: cityNameController,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Enter city name',
                        hintStyle: TextStyle(color: AppColor.grey)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 60),
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
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      if (checkValidation()) {
                        createTeamApi();
                      }
                    },
                    child: const Text(
                      'Add Team',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.white,
                          fontFamily: "Lato_Semibold",
                          fontSize: 16),
                    )),
              )
            ],
          ),
        ));
  }

  Future getTeamListApi(String search) async {
    await getTeamList(search).then((res) async {
      hideLoader();
      if (res.success == 1) {
        setState(() {
          teamList = [];
          teamList.addAll(res.body!);
        });
      } else if (res.success != 1 && res.code == 401) {
        toast(res.message);
        Navigator.pushAndRemoveUntil(
            getContext,
            MaterialPageRoute(
              builder: (getContext) => const LoginScreen(),
            ),
            (route) => false);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
      } else {
        CommonFunctions().showToastMessage(context, res.message!);
      }
    });
  }

  Future<void> createTeamApi() async {
    showLoader();
    MultipartRequest multiPartRequest =
        await getMultiPartRequest('create_team', method: 'POST');
    multiPartRequest.fields['name'] = teamController.text.trim().toString();
    multiPartRequest.fields['city'] = cityNameController.text.trim().toString();
    if (imageFile != null) {
      multiPartRequest.files
          .add(await MultipartFile.fromPath('team_photo', imageFile!.path));
    }
    multiPartRequest.headers.addAll(buildHeaderTokens());
    var res = await createTeam(multiPartRequest);
    hideLoader();
    if (res.success == 1) {
      toast(res.message);
      teamController.text = "";
      cityNameController.text = "";
      imageFile = null;
      Future.delayed(Duration.zero, () {
        getTeamListApi("");
      });
      tabController.animateTo(0);
      if (widget.team == "A" ) {
        widget.teamASelected.getTeamData = res.body!;
        Navigator.push(
            getContext,
            MaterialPageRoute(
                builder: (context) => AddTeams(
                  getTeamData: res.body!,
                  teamASelected: widget.teamASelected,
                  teamBSelected: widget.teamBSelected,
                  team: widget.team,
                ))).then((value){if(value=="add_teams"){
          debugPrint("dadaddadaddsadasdad");
          setState(() {
            widget.teamASelected.getTeamData = null;
          });

        }
        });
      } else if(widget.team == "B" ){
        widget.teamBSelected.getTeamData = res.body!;
        Navigator.push(
            getContext,
            MaterialPageRoute(
                builder: (context) => AddTeams(
                    getTeamData: res.body!,
                    teamASelected: widget.teamASelected,
                    teamBSelected: widget.teamBSelected,
                    team: widget.team
                ))).then((value) {
          debugPrint("dewdwd"+value);
          if(value=="add_teams"){
            debugPrint("dadaddadaddsadasdad");
            setState(() {
              widget.teamBSelected.getTeamData = null;
            });
          }
        });
      }
    } else if (res.success != 1 && res.code == 401) {
      toast(res.message);
      Navigator.pushAndRemoveUntil(
          getContext,
          MaterialPageRoute(
            builder: (getContext) => const LoginScreen(),
          ),
          (route) => false);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
    } else if (res.success != 1 && res.code == 401) {
      toast(res.message);
      Navigator.pushAndRemoveUntil(
          getContext,
          MaterialPageRoute(
            builder: (getContext) => const LoginScreen(),
          ),
          (route) => false);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
    } else {
      CommonFunctions().showToastMessage(getContext, res.message!);
    }
  }

  Future _imagePick(ImageSource source) async {
    var images = await ImagePicker().pickImage(source: source);
    if (images != null) {
      debugPrint("image_path: ${images.path}");
      imageFile = await FlutterNativeImage.compressImage(images.path,
          quality: 20, percentage: 60);
      // await setValue(image, imageFile!.path);
      setState(() {});
    }
  }

  bool checkValidation() {
    if (teamController.text.trim().toString() == '') {
      CommonFunctions()
          .showToastMessage(getContext, "Team Name Field Is Required");
      return false;
    } else if (cityNameController.text.trim().toString().isEmpty) {
      CommonFunctions().showToastMessage(getContext, "City Field Is Required.");
      return false;
    } else {
      return true;
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: const Text(
                "Gallery",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              leading: const Icon(Icons.image),
              onTap: () {
                _imagePick(ImageSource.gallery);
                // _getFromGallery();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                "Camera",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              leading: const Icon(Icons.camera),
              onTap: () {
                _imagePick(ImageSource.camera);
                // _getFromCamera();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
