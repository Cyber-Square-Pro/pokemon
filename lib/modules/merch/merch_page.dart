import 'package:app/modules/merch/buy_merch.dart';
import 'package:app/modules/merch/widgets/tshirt.dart';
import 'package:app/modules/merch/widgets/tshirt_card.dart';
import 'package:app/shared/utils/page_transitions.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MerchandisePage extends StatefulWidget {
  const MerchandisePage({super.key});

  @override
  State<MerchandisePage> createState() => _MerchandisePageState();
}

class _MerchandisePageState extends State<MerchandisePage> {
  final List<Tshirt> tshirtList = [
    Tshirt(
      name: 'Pikkachu',
      description:
          'A simple and comfortable Tshirt featuring the iconic Pikkachu design.',
      price: 100,
      imageURL:
          'https://imgs.search.brave.com/eZmrEVt1e2MiGd8QmsZnUD-rK5N2T4rr9xfqLz-DB5U/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/OTFkQkpoaTRULUwu/anBn',
    ),
    Tshirt(
      name: 'Team Rocket F',
      description: 'A stylish and comfortable Tshirt.',
      price: 120,
      imageURL:
          'https://imgs.search.brave.com/YjzePZtoPCExTIK4O-IeQ4SK2AQ--4TGPYOwj2U8MIE/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9paDEu/cmVkYnViYmxlLm5l/dC9pbWFnZS4yMzcz/MzA5ODEuMDU4Ny9z/c3JjbyxzbGltX2Zp/dF90X3NoaXJ0LHdv/bWVucywxMDEwMTA6/MDFjNWNhMjdjNixm/cm9udCxzcXVhcmVf/cHJvZHVjdCw2MDB4/NjAwLnUzLmpwZw',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: true,
      child: GridView.builder(
        padding: AppTheme.pagePadding,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.55,
        ),
        itemCount: tshirtList.length,
        itemBuilder: (_, index) {
          final tShirt = tshirtList[index];
          return TshirtCard(
            tag: 't_$index',
            name: tShirt.name,
            description: tShirt.description,
            price: tShirt.price.toString(),
            imageURL: tShirt.imageURL,
            onTap: () {
              Navigator.push(
                context,
                TransitionPageRoute(
                  duration: Durations.long2,
                  child: BuyMerchPage(
                    tag: 't_$index',
                    shirt: tShirt,
                  ),
                  transition: (index % 2 == 0)
                      ? PageTransitions.slideRight
                      : PageTransitions.slideLeft,
                  curve: Curves.ease,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
