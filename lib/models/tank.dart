import 'package:flutter/material.dart';
import 'package:sensotech/constants/theme.dart';

class FuelTankWidget extends StatefulWidget {
  const FuelTankWidget({
    super.key,
    this.width,
    required this.percentageFilled,
    required this.color,
    required this.supplyType,
  });

  final double? width;
  final String percentageFilled;
  final Color color;
  final String supplyType;

  @override
  State<FuelTankWidget> createState() => _FuelTankWidgetState();
}

class _FuelTankWidgetState extends State<FuelTankWidget> {
  double percentageFilled = 0;

  @override
  Widget build(BuildContext context) {
    percentageFilled = (double.tryParse(widget.percentageFilled) ?? 0.1) / 100;
    double width = MediaQuery.of(context).size.width;
    var grey = Colors.blueGrey.withValues(alpha: 0.4);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: SizedBox(
              width: widget.width ?? width,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      topCaps(),
                      const Spacer(flex: 3),
                      topCaps(),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 2),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: grey,
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          // Filled portion
                          FractionallySizedBox(
                            heightFactor: percentageFilled,
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    percentageFilled > 0 ? widget.color : grey,
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              verticalstruts(),
                              verticalstruts(),
                              verticalstruts(),
                              verticalstruts(),
                            ],
                          ),
                          // Percentage text
                          Center(
                            child: Column(
                              children: [
                                spacer(),
                                Text(
                                  '${(percentageFilled * 100).toStringAsFixed(1)}%',
                                  style: kTitleTextstyle.copyWith(
                                      fontSize: 20, color: Colors.black),
                                ),
                                spacer(),
                                Text(
                                  widget.supplyType,
                                  style: kregularTextstyle.copyWith(
                                      fontSize: 16, color: Colors.black),
                                ),
                                spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bottomCaps(),
              SizedBox(),
              bottomCaps(),
              SizedBox(),
              bottomCaps(),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox spacer() => const SizedBox(height: 20);

  Widget topCaps() {
    percentageFilled = (double.tryParse(widget.percentageFilled) ?? 0.1) / 100;
    var grey = Colors.blueGrey.withValues(alpha: 0.4);
    return Container(
      height: 15,
      width: 80,
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: percentageFilled >= 1 ? Colors.green : grey,
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  Widget bottomCaps() {
    percentageFilled = (double.tryParse(widget.percentageFilled) ?? 0.1) / 100;
    var color = widget.color;
    var grey = Colors.blueGrey.withValues(alpha: 0.4);
    return Container(
      height: 15,
      width: 30,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.blueGrey),
          bottom: BorderSide(color: Colors.blueGrey),
          right: BorderSide(color: Colors.blueGrey),
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
        color: percentageFilled > 0 ? color : grey,
      ),
    );
  }

  Widget verticalstruts() {
    var grey = Colors.blueGrey.withValues(alpha: 0.2);
    return Container(
      width: 7,
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: grey,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
