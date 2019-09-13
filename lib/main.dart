import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/services.dart';

void main() async {
  /// Force the layout to Portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tuupai Home',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _posisi = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize (
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          title: _search(),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            _buildSlider(),
            _buildText("Explore Kategori"),
            _buildCategory(), //sepertinya pakai tab harusnya, saya masih salah
            _buildText("Butuh jasa cleaning service?"),
            _buildService(),
            GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  margin: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: activeBoxDecoration(), //       <--- BoxDecoration here
                  child: Text('Lihat Lebih Banyak',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                )
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 30), title: Text('Cari Jasa')),
          BottomNavigationBarItem(
            title: new Text('Order'),
            icon: new Stack(
              children: <Widget>[
                new Icon(Icons.playlist_add_check, size: 30),
                  new Positioned(  // draw a red marble
                    top: 0.0,
                    right: 0.0,
                    child: new CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      maxRadius: 8.0,
                      child: Text("1", style: TextStyle(fontSize: 8.0),),
                    ),
                  )
              ],
            ),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline, size: 30), title: Text('Chat')),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 30), title: Text('Profil')),
        ],
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.lightBlueAccent,
      ),
    );
  }

  Widget _search(){
    return Container(
        margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
        alignment: Alignment.center,
        height: 80.0,
        decoration: new BoxDecoration(
            color: Colors.black12,
            border: new Border.all(
                color: Colors.black54,
                width: 1.0
            ),
            borderRadius: new BorderRadius.circular(30.0)
        ),
        child: new TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 13.0,
              horizontal: 0.0,
            ),
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            hintText: "Butuh jasa apa, Daud Muhajir?",

          ),
        ),
      );
  }

  final List<String> sliderItems = [
    "assets/slider/slider1.jpg",
    "assets/slider/slider2.jpg",
    "assets/slider/slider3.jpg",
    "assets/slider/slider4.jpg",
  ];

  Widget _buildSlider() {
    return Container(
      height: 300.0,
      child: Stack(
        children: <Widget>[
          Container(
            child: Swiper(
              autoplay: true,
              itemBuilder: (BuildContext context,int index){
                return new Image.asset(sliderItems[index],fit: BoxFit.cover,);
              },
              itemCount: sliderItems.length,
              pagination: new SwiperPagination(
                  builder: new DotSwiperPaginationBuilder(
                      color: Colors.grey, activeColor: Colors.black)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, left: 20.0, bottom: 0.0),
      child: Text(text, textAlign: TextAlign.left, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
    );
  }

  final List<String> categories = ['Servis Elektronik', 'Rumah Tangga', 'Massage & Therapy', 'Fashion & Perawatannya', 'Pertukangan'];

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        border: new Border.all(
            color: Colors.white,
            width: 1.0
        ),
        borderRadius: new BorderRadius.circular(30.0)
    );
  }

  BoxDecoration activeBoxDecoration() {
    return BoxDecoration(
        color: Colors.lightBlueAccent,
        border: new Border.all(
            color: Colors.white,
            width: 1.0
        ),
        borderRadius: new BorderRadius.circular(30.0)
    );
  }

  Widget _buildCategoriesGrid() {
    return Container(
      height: 85.0,
      child: ListView.builder(
        padding: EdgeInsets.all(15.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index){
          return GestureDetector(
            onTap: () => {
              print(categories[index]),
              setState(() {
                _posisi = index;
              })
            },
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: index == _posisi ? activeBoxDecoration() : myBoxDecoration(), //       <--- BoxDecoration here
              child: Text(
                categories[index],
                style: TextStyle(fontSize: 16.0, color: index == _posisi ? Colors.white : Colors.black45),
              ),
            )
          );
        },
        itemCount: categories.length,
      ),
    );
  }

  Widget _buildCategoriesList(){ //sepertinya pakai Card yang benar, saya masih salah
    return Container(
      height: 250.0,
      child: GridView.builder(
//        shrinkWrap: true,
        padding: EdgeInsets.all(1.0),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1.0,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 4),
        ),
        itemBuilder: (_, int index){
          return GestureDetector(
              onTap: ()=>print(categories[index]),
              child: Container(
                margin: EdgeInsets.only(top: 5, right: 10, bottom: 5, left: 15),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container (
                      padding: EdgeInsets.only(top: 2, right: 2, bottom: 2, left: 10),
                      width: 54,
                      child: Text("Servis Listrik"),
                    ),
                    Container (
//                    padding: EdgeInsets.only(top: 0, right: 0, bottom: 0, left: 0),
                      decoration: BoxDecoration (
                          border: Border(left: BorderSide( //border kiri blur harusnya, saya masih salah
                              color: Colors.black12.withOpacity(0.3),
                              style: BorderStyle.solid,
                              width: 1
                          )),
                      ),
                      child: ClipRRect(
                        borderRadius: new BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        child: Image.asset(
                          'assets/servis.jpg',
                        ),
                      )
                    ),
                  ],
                ),
              )
          );
        },
        itemCount: categories.length,
      ),
    );
  }

  Widget _buildCategory(){ //Sepertinya pakai Tab yang benar, saya masih salah
    return Container (
      child: Column (
        children: <Widget>[
          _buildCategoriesGrid(), //harusnya tab sepertinya, antara text kategori dan List Card Categori menyatu, saya masih salah
          _buildCategoriesList() //sepertinya pakai Card yang benar, border tengah angata text dan gambar blur harusmya, saya masih salah
        ],
      )
    );
  }

  Widget _buildService(){
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: new BorderRadius.all(Radius.circular(10)
                  ),
                  child: Image.asset(
                    'assets/servis.jpg',
                  ),
                ),
                SizedBox(height: 10.0,),
                Text('Cleaning Service', style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 10.0,),
                Text('Rp 150.000 per 3 jam', style: TextStyle(fontSize: 14.0, color: Colors.redAccent),)
              ],
            ),
          ),
          SizedBox(width: 10.0,),
          Expanded(
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: new BorderRadius.all(Radius.circular(10)
                  ),
                  child: Image.asset(
                    'assets/servis.jpg',
                  ),
                ),
                SizedBox(height: 10.0,),
                Text('Cleaning Service', style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 10.0,),
                Text('Rp 150.000 per 3 jam', style: TextStyle(fontSize: 14.0, color: Colors.redAccent),)
              ],
            ),
          ),
        ],
      ),
    );
  }

}