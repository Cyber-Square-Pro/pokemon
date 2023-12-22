import 'package:app/shared/tshirt.dart';
import 'package:app/shared/tshirt_card.dart';
import 'package:flutter/material.dart';

class TshirtLists extends StatefulWidget {
  const TshirtLists({super.key});

  @override
  State<TshirtLists> createState() => _TshirtListsState();
}

class _TshirtListsState extends State<TshirtLists> {
  final List<Tshirt> tshirtLists = [
    Tshirt(
      name: 'Pikkachu', 
      description: 'A simple and comfortable Tshirt featuring the iconic Pikkachu design.', 
      price: 100, 
      imageurl: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.amazon.in%2FPokemon-Pikachu-T-Shirt-13-14-Years%2Fdp%2FB01MAW524V&psig=AOvVaw1JxC2bRrfb34oiBW9paOag&ust=1703341107803000&source=images&cd=vfe&ved=0CBIQjRxqFwoTCJDog5-eo4MDFQAAAAAdAAAAABAE'
      ),
      Tshirt(
        name: 'PocketMonStyle Tee', 
        description: 'A stylish and comfortable Tshirt.', 
        price: 120, 
        imageurl: 'https://www.google.com/imgres?imgurl=https%3A%2F%2Ffiles.ekmcdn.com%2Ff8c1cb%2Fimages%2Fpersonalised-pokemon-t-shirt-size-medium-9-11-years-406-p.jpg%3Fw%3D1000%26h%3D1000%26v%3D306e64e7-5f60-4ef4-9571-a7886baab2f0&tbnid=6HMnbRbEE-rLMM&vet=12ahUKEwiZ94nPn6ODAxWDamwGHcbXAuAQMygNegUIARCNAQ..i&imgrefurl=https%3A%2F%2Fwww.tees4geeks.co.uk%2Fpersonalised-pokemon-t-shirt-400-p.asp&docid=Max5u6cLNQ_bEM&w=1000&h=945&q=pokemon%20tshirt%20images&client=safari&ved=2ahUKEwiZ94nPn6ODAxWDamwGHcbXAuAQMygNegUIARCNAQ'
        ),
        Tshirt(
          name: '', 
          description: '', 
          price: 230, 
          imageurl: ''
          ),
           Tshirt(
          name: '', 
          description: '', 
          price: 230, 
          imageurl: ''
          ),

  ];
  @override
  Widget build(BuildContext context) {
    return TshirtCard();
  }
}