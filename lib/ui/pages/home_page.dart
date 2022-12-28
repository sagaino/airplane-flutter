import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/cubit/destination_cubit.dart';
import 'package:airplane/cubit/transaction_cubit.dart';
import 'package:airplane/ui/widgets/destination_card.dart';
import 'package:airplane/ui/widgets/destination_tile.dart';
import 'package:flutter/material.dart';
import 'package:airplane/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/destination_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<DestinationCubit>().fetchDestination();
    super.initState();
  }

  List destinationItem = [
    {
      "name": "Lake Ciliwung",
      "city": "Tangerang",
      "imgUrl": "assets/image_destination1.png",
      "rating": 4.2,
    },
    {
      "name": "Lake Ciliwung1",
      "city": "Tangerang1",
      "imgUrl": "assets/image_destination2.png",
      "rating": 3.9,
    },
    {
      "name": "Lake Ciliwung2",
      "city": "Tangerang2",
      "imgUrl": "assets/image_destination3.png",
      "rating": 4.5,
    },
    {
      "name": "Lake Ciliwung3",
      "city": "Tangerang3",
      "imgUrl": "assets/image_destination4.png",
      "rating": 5.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    header() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Container(
              margin: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
                top: 30,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Howdy,\n${state.user.name}",
                          style: blackTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          "Where to fly today?",
                          style: greyTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: light,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/image_profile.png"),
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      );
    }

    popularDestinations(List<DestinationModel> destinations) {
      return Container(
        height: 323,
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: ListView.builder(
          itemCount: destinations.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, index) {
            var item = destinations[index];
            return DestinationCard(item);
          },
        ),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: destinations.map((DestinationModel itemDestination) {
        //       return DestinationCard(itemDestination);
        //     }).toList(),
        //   ),
        // ),
      );
    }

    newDestinations(List<DestinationModel> destinations) {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: defaultMargin,
          right: defaultMargin,
          bottom: 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New This Year",
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            ListView.builder(
              itemCount: destinations.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, index) {
                var item = destinations[index];
                return DestinationTile(item);
              },
            ),
            // Column(
            //   children: destinations.map((DestinationModel itemDestination) {
            //     return DestinationTile(itemDestination);
            //   }).toList(),
            // ),
          ],
        ),
      );
    }

    return BlocConsumer<DestinationCubit, DestinationState>(
      listener: (context, state) {
        if (state is DestinationFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: kRedColor,
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is DestinationSuccess) {
          return ListView(
            children: [
              header(),
              popularDestinations(state.destinations),
              newDestinations(state.destinations),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
