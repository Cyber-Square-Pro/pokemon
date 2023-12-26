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
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.amazon.in%2FPokemon-Pikachu-T-Shirt-13-14-Years%2Fdp%2FB01MAW524V&psig=AOvVaw1JxC2bRrfb34oiBW9paOag&ust=1703341107803000&source=images&cd=vfe&ved=0CBIQjRxqFwoTCJDog5-eo4MDFQAAAAAdAAAAABAE',
    ),
    Tshirt(
      name: 'PocketMonStyle Tee',
      description: 'A stylish and comfortable Tshirt.',
      price: 120,
      imageURL:
          'https://www.google.com/imgres?imgurl=https%3A%2F%2Ffiles.ekmcdn.com%2Ff8c1cb%2Fimages%2Fpersonalised-pokemon-t-shirt-size-medium-9-11-years-406-p.jpg%3Fw%3D1000%26h%3D1000%26v%3D306e64e7-5f60-4ef4-9571-a7886baab2f0&tbnid=6HMnbRbEE-rLMM&vet=12ahUKEwiZ94nPn6ODAxWDamwGHcbXAuAQMygNegUIARCNAQ..i&imgrefurl=https%3A%2F%2Fwww.tees4geeks.co.uk%2Fpersonalised-pokemon-t-shirt-400-p.asp&docid=Max5u6cLNQ_bEM&w=1000&h=945&q=pokemon%20tshirt%20images&client=safari&ved=2ahUKEwiZ94nPn6ODAxWDamwGHcbXAuAQMygNegUIARCNAQ',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: true,
      child: GridView.builder(
        padding: AppTheme.homePadding,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.60,
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
                PageTransitionWrapper(
                  duration: Durations.long2,
                  page: BuyMerchPage(
                    id: 't_$index',
                    shirt: tShirt,
                  ),
                  transitionType: (index % 2 == 0)
                      ? PageTransitionType.slideRight
                      : PageTransitionType.slideLeft,
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
