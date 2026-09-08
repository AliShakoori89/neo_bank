import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget buildAddCardButton(BuildContext context) {
  return InkWell(
    onTap: () => context.push('/add_card_page'),
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(1.83), // ضخامت border
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment(-0.3, -1),
              end: Alignment(1, 0.3),
              colors: [
                Color.fromRGBO(255, 255, 255, 0.7),
                Color.fromRGBO(255, 255, 255, 0),
              ],
              stops: [0.0, 0.9998],
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.17),
            child: Stack(
              children: [
                // Background gradient 1
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.3, -1),
                      end: Alignment(1, 0.3),
                      colors: [
                        Color.fromRGBO(255, 255, 255, 0.06),
                        Color.fromRGBO(255, 255, 255, 0),
                      ],
                      stops: [0.0, 0.9998],
                    ),
                  ),
                ),

                // Background gradient 2
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.25, -1),
                      end: Alignment(1, 0.4),
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.016),
                        Color.fromRGBO(0, 0, 0, 0.08),
                      ],
                      stops: [0.0011, 1.0],
                    ),
                  ),
                ),

                // Content
                Center(child: Icon(Icons.add, color: Colors.white, size: 40)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
