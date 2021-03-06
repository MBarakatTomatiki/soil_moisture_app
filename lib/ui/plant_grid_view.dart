/*
 * plant_grid_view
 * 
 * Displays the available plants in Grid in Overview and Analysis page.
 */

import 'package:flutter/material.dart';

// * State import
import 'package:soil_moisture_app/states/selected_card_state.dart';

// * ui import
import 'package:soil_moisture_app/ui/plant_card.dart';

// * data import
import 'package:soil_moisture_app/data/plant_class.dart';

// * utils import
import 'package:soil_moisture_app/utils/sizes.dart';

// * External packages import
import 'package:provider/provider.dart';

class PlantGridView extends StatelessWidget {
  final List<Plant> plantlist;
  PlantGridView({@required this.plantlist});
  @override
  Widget build(BuildContext context) {
    SelectedCardState selectedCardObj = Provider.of<SelectedCardState>(context);
    return GridView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            (appWidth(context) < 600 && isPortrait(context)) ? 3 : 5,
        crossAxisSpacing: appWidth(context) * 0.005,
        mainAxisSpacing: appWidth(context) * 0.005,
      ),
      itemCount: this.plantlist.length,
      itemBuilder: (context, position) {
        return PlantCard(
          plant: plantlist[position],
          isSelected: position == selectedCardObj.selCard,
          onTap: () => selectedCardObj.chooseCard(position),
        );
      },
    );
  }
}
