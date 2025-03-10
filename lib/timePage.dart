import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:pomodoro/database_handler.dart';
import 'package:pomodoro/timer.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class timePage extends StatefulWidget {
  const timePage({super.key});

  @override
  State<timePage> createState() => _timePageState();
}

class _timePageState extends State<timePage> with TickerProviderStateMixin {
  DatabaseHandler handler = DatabaseHandler();
  ScrollController controller = ScrollController();
  Timer timer = Timer();

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            FluentIcons.arrow_circle_left_24_regular,
            size: 32,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: ListTileTheme(
        style: ListTileStyle.list,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        iconColor: Theme.of(context).primaryColorLight,
        textColor: Theme.of(context).primaryColorLight,
        contentPadding: const EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 8,
        ),
        child: Container(
          width: size.width,
          height: size.height * 0.9,
          margin: const EdgeInsets.only(left: 10, right: 0),
          padding: const EdgeInsets.only(left: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    "Pomodoro List",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                StreamBuilder<List<MapEntry<String, Timer>>>(
                    stream: handler.listenToTimers(),
                    builder: ((context, snapshot) {
                      return snapshot.data != null
                          ? SizedBox(
                              width: size.width * 0.9,
                              height: size.height * 0.7,
                              child: snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              "Loading...",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                    )
                                  : Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: ((context1, index) {
                                          final key = snapshot.data![index].key;
                                          final timer = snapshot.data![index].value;
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(bottom: 10),
                                            child: SwipeActionCell(
                                              backgroundColor: Colors.white,
                                              key: ValueKey<int>(
                                                  snapshot.data![index].hashCode),
                                              trailingActions: [
                                                SwipeAction(
                                                    widthSpace: size.width * 0.3,
                                                    color: Colors.white,
                                                    backgroundRadius: 10,
                                                    content: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Icon(
                                                            FluentIcons
                                                                .delete_32_regular,
                                                            color: Colors.red,
                                                          ),
                                                          Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color: Colors.red,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ]),
                                                    onTap: (tap) {
                                                      Alert(
                                                          useRootNavigator: false,
                                                          context: context1,
                                                          title: "Alert",
                                                          desc:
                                                              "Do you want to delete this note?",
                                                          style: AlertStyle(
                                                              backgroundColor:
                                                                  Theme.of(context)
                                                                      .primaryColor,
                                                              alertAlignment: Alignment
                                                                  .center,
                                                              alertBorder: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          20)),
                                                              descStyle: TextStyle(
                                                                  color: Theme.of(context)
                                                                      .primaryColorLight,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight
                                                                      .bold),
                                                              titleStyle: TextStyle(
                                                                  color: Theme.of(context)
                                                                      .primaryColorLight,
                                                                  fontSize: 24,
                                                                  fontWeight: FontWeight
                                                                      .w300)),
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: 0,
                                                              vertical: 10),
                                                          buttons: [
                                                            DialogButton(
                                                                color:
                                                                    Colors.black,
                                                                child: Text(
                                                                    "Dismiss",
                                                                    style: TextStyle(
                                                                        color: Theme.of(
                                                                                context)
                                                                            .primaryColorLight,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400)),
                                                                onPressed: () {
                                                                  setState(() {});
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }),
                                                            DialogButton(
                                                                color:
                                                                    Colors.black,
                                                                child: Text(
                                                                    "Confrim",
                                                                    style: TextStyle(
                                                                        color: Theme.of(
                                                                                context)
                                                                            .primaryColorLight,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400)),
                                                                onPressed: () {
                                                                  handler.deleteTimer(
                                                                      key);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  setState(() {});
                                                                })
                                                          ]).show();
                                                    })
                                              ],
                                              child: Card(
                                                color: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: ListTile(
                                                  trailing: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    child: Text(
                                                      snapshot.data![index].value.timer,
                                                      style: TextStyle(
                                                          color: Theme.of(context)
                                                              .primaryColorLight,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  leading: Icon(
                                                    FluentIcons.clock_24_filled,
                                                    color: Theme.of(context)
                                                        .primaryColorLight,
                                                  ),
                                                  title: Text(
                                                    timer.title,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  subtitle: Text(
                                                    timer.datetime,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorDark,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        })),
                                  ),
                            )
                          : SizedBox(
                              width: size.width * 0.8,
                              height: size.height * 0.8,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                      width: 200,
                                      height: 200,
                                      image:
                                          AssetImage("lib/photos/error.jpg")),
                                  Text(
                                    "No Data Available",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                    }))
              ]),
        ),
      ),
    );
  }
}
