import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> config = [
      {'type': 'appBar', 'title': 'Delivery to', 'pin': '201301'},
      {
        'type': 'carousel',
        'images': ['assets/pic1.png', 'assets/pic2.png', 'assets/smile.png']
      },
      {
        'type': 'categorySection',
        'title': 'Buy Furniture',
        'categories': [
          {'label': 'Living Room', 'icon': 'assets/living_room.png'},
          {'label': 'Bedroom', 'icon': 'assets/bed_room.png'},
          {'label': 'Storage', 'icon': 'assets/storage.png'},
          {'label': 'Study', 'icon': 'assets/study.png'},
          {'label': 'Dining', 'icon': 'assets/dining.png'},
          {'label': 'Tables', 'icon': 'assets/table.png'},
          {'label': 'Chairs', 'icon': 'assets/chair.png'},
          {'label': 'Z Rated', 'icon': 'assets/Z.png'},
          {'label': 'Best Deal', 'icon': 'assets/deal.png'},
        ]
      },
      {
        'type': 'brand',
        'brand_cat':[
          {
            'icon':'assets/send.png',
            'label':'Buy',
            'title':'Brand New'
          }, {
            'icon':'assets/refurbished.png',
            'label':'Buy',
            'title':'Refurbished'
          },
        ]
      },
      {
        'type': 'OfferSection',
        'title': 'Offer & Discount',
        'images': [
          {'pic': 'assets/sbi.png'},
          {'pic': 'assets/sbi.png'}
        ]
      },

      {
        'type': 'productGrid',
        'products': [
          {
            'image': 'assets/s2.jpeg',
            'discount': '-72%',
            'price': 'off ₹10,499'
          },
          {
            'image': 'assets/s3.jpeg',
            'discount': '-74%',
            'price': 'off ₹9,499'
          },
        ]
      },

    ];
    return Scaffold(
      body: ListView.builder(
        itemCount: config.length,
        itemBuilder: (context, index) {
          return WidgetFactory.build(config[index]);
        },
      ),
    );
  }
}

class WidgetFactory {
  static Widget build(dynamic json) {
    switch (json['type']) {
      case 'appBar':
        return AppBarWidget(
          title: json['title'],
          pin: json['pin'],
        );
      case 'carousel':
        return CarouselWidget(images: json['images']);
      case 'categorySection':
        return CategorySectionWidget(
          title: json['title'],
          categories: json['categories'],
        );
      case 'brand':
        return BrandCategory(categories: json['brand_cat'],);
      case 'OfferSection':
        return OffersWidget(
          images: json['images'],
          title: json['title'],
        );
      case 'productGrid':
        return ProductGridWidget(products: json['products']);
      default:
        return SizedBox.shrink();
    }
  }
}

class AppBarWidget extends StatelessWidget {
  final String title;
  final String pin;

  const AppBarWidget({super.key, required this.title, required this.pin});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8,
            children: [
              Icon(Icons.location_on_outlined),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 14)),
                  Text(pin, style: TextStyle(fontSize: 10))
                ],
              ),
            ],
          ),
          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.search),
              Icon(Icons.favorite_border),
              Icon(Icons.shopping_cart)
            ],
          )
        ],
      ),
    );
  }
}

class CarouselWidget extends StatefulWidget {
  final List<String> images;

  const CarouselWidget({super.key, required this.images});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late PageController pageController;
  late int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.images.length,
            controller: pageController,
            onPageChanged: (index) {
              _currentIndex = index;
              setState(() {});
            },
            itemBuilder: (context, index) {
              return Image.asset(widget.images[index], fit: BoxFit.cover);
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: _currentIndex == index ? 14 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          _currentIndex == index ? 4 : 10),
                      color:
                          _currentIndex == index ? Colors.green : Colors.grey),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class CategorySectionWidget extends StatelessWidget {
  final String title;
  final List<dynamic> categories;

  const CategorySectionWidget(
      {super.key, required this.title, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
              child: Text(title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500))),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.5,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon(Icons.desktop_mac),
                Image.asset(categories[index]['icon'], scale: 2.5),
                Text(categories[index]['label']),
              ],
            );
          },
        )
      ],
    );
  }
}

class OffersWidget extends StatelessWidget {
  final String title;
  final List<dynamic> images;

  const OffersWidget({super.key, required this.images, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
        SizedBox(
          height: 100,
          child: PageView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Image.asset(images[index]['pic'], fit: BoxFit.fitWidth);
            },
          ),
        ),
      ],
    );
  }
}

class BrandCategory extends StatelessWidget {
  final List<dynamic> categories;
  const BrandCategory({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        itemCount: categories.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          var data=categories[index];
          return Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.lightGreen.shade300,),
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(data['icon']),
                const SizedBox(height:10),
                Text(data['label'],style: TextStyle(fontSize: 10,color: Colors.black),),
                const SizedBox(height:5),
                Row(
                  children: [
                    Text(data['title'],style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                    const SizedBox(width:10),
                    Icon(Icons.arrow_forward,size: 16)
                  ],
                ),
              ],
            ),
          );
        },),
    );
  }
}

class ProductGridWidget extends StatelessWidget {
  final List<dynamic> products;

  const ProductGridWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                    child: Icon(Icons.percent_outlined,color: Colors.white,)),
                const SizedBox(width: 10),
                Text('Deal of the day',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
                const SizedBox(width: 50),
                Text('View All',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600,color: Colors.grey),),
                const SizedBox(width: 5),
                Icon(Icons.arrow_forward,size: 10,color: Colors.grey,)
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 10),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Image.asset(product['image'], height: 100, fit: BoxFit.cover),
                      const SizedBox(height: 16),
                      Text('Flex 3 Seater Magic B...'),
                      const SizedBox(height: 14),
                      Container(
                        height: 50,
                        // margin:const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: Color(0xFFFFDD4F),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Text(product['discount']),
                            Text(
                              product['price'],
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


