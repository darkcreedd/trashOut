import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/gap.dart';

class WasteClassificationPage extends StatelessWidget {
  const WasteClassificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
            splashRadius: 25.sp,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () => context.pop()),
        title: Text(
          'Waste Classification Guide',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            // Domestic Waste
            buildWasteCategory(
              'Domestic Waste',
              'Domestic waste, also known as household waste, is generated from residential properties and everyday activities of individuals and families. It includes waste produced from regular living and consumption habits.',
              [
                'Food waste: Leftover food, kitchen scraps, and spoiled groceries.',
                'Paper waste: Newspapers, magazines, cardboard boxes, used notebooks, and packaging materials.',
                'Plastic waste: Plastic bottles, bags, food containers, and other single-use plastic items.',
                'Glass waste: Empty glass bottles, jars, and broken glassware.',
                'Textile waste: Old clothing, worn-out linens, and fabric scraps.',
                'Furniture/wooden waste: Old or destroyed wooden furniture and items made of wood',
                'E-waste: Discarded electronic devices like smartphones, laptops, and small appliances.',
              ],
            ),

            // Commercial/Industrial Waste
            buildWasteCategory(
              'Commercial/Industrial Waste',
              'Commercial and industrial waste is generated from businesses, factories, and commercial establishments. This type of waste is often more diverse and can be hazardous, requiring careful handling and disposal.',
              [
                'Manufacturing waste: Scraps, offcuts, and rejected products from production processes.',
                'Hazardous waste: Chemicals, solvents, paints, batteries, and other materials that are potentially harmful to human health and the environment.',
                'Construction and demolition waste: Debris from building and infrastructure construction, such as concrete, wood, and metal.',
                'Electronic waste: Defective or outdated electronics and electrical equipment from businesses and industries.',
              ],
            ),

            // Medical Waste
            buildWasteCategory(
              'Medical Waste',
              'Medical waste, also known as healthcare or biomedical waste, is generated from healthcare facilities like hospitals, clinics, and laboratories. Due to its potential to transmit infections, medical waste requires special handling and disposal procedures.',
              [
                'Infectious waste: Contaminated materials like used syringes, gloves, and bandages.',
                'Pathological waste: Tissues, organs, and body parts from surgeries and autopsies.',
                'Pharmaceutical waste: Expired or unused medications and drugs.',
                'Sharps waste: Needles, blades, and other sharp objects used in medical procedures.',
                'Chemical waste: Discarded chemicals and reagents from laboratory testing and research.',
                'Anatomy waste: Discarded human organs from surgical operations and research.',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWasteCategory(
      String title, String description, List<String> examples) {
    return Card(
      color: Colors.transparent,
      elevation: 1,
      shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                color: KColors.green300,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(8.h),
            Text(
              description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ),
            Gap(16.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: examples
                  .map(
                    (example) => RichText(
                      text: TextSpan(
                        text: '• ',
                        style: TextStyle(
                            color: Colors.red[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        children: [
                          TextSpan(
                            text: example,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Sen',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
