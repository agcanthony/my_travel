import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_travels/core/responsive.dart';

import '../../../core/app_colors.dart';
import '../../../core/hex_color.dart';
import '../../../core/primary_text.dart';
import '../../../infra/models/travels_model.dart';
import '../home_controller.dart';

class AddTravelCard extends StatelessWidget {
  final TravelsModel travel;
  final String cardColor;
  final VoidCallback ontTap;
  final int totalSteps;
  final int currentStep;
  //final String totalTask;
  AddTravelCard({
    Key? key,
    required this.travel,
    required this.cardColor,
    required this.ontTap,
    required this.totalSteps,
    required this.currentStep,
    //required this.totalTask,
  }) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width - 12.0.wp;

    return GestureDetector(
      onTap: ontTap,
      child: SizedBox(
        height: size / 2,
        width: size / 2,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: HexColor.fromHex(cardColor).withOpacity(0.9),
            boxShadow: const [
              BoxShadow(
                color: grey,
                blurRadius: 3,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.0.wp),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                child: PrimaryText(
                  travel.travel,
                  size: 13.0.tx,
                  fontWeight: FontWeight.w500,
                  color: secondaryDark,
                ),
              ),
              SizedBox(height: 3.0.wp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PrimaryText(
                    DateFormat('dd-MM-yyyy').format(travel.startAt).toString(),
                    size: 8.0.tx,
                    color: secondaryDark,
                  ),
                  Flexible(
                    child: PrimaryText(
                      '-',
                      size: 7.0.tx,
                      color: secondaryDark,
                    ),
                  ),
                  PrimaryText(
                    DateFormat('dd-MM-yyyy').format(travel.endAt).toString(),
                    size: 8.0.tx,
                    color: secondaryDark,
                  ),
                ],
              ),
              SizedBox(height: 1.0.wp),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 3.0.wp, vertical: 1.5.hp),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      child: PrimaryText(
                        '${travel.numberOfTasks}',
                        size: 13.0.tx,
                        color: lilyWhite,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    PrimaryText(
                      ' Viagens',
                      size: 13.0.tx,
                      color: secondaryDark,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
