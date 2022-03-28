import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listcompany/Screen/ThongTinChiTietCongTy.dart';
import 'package:flutter_listcompany/network/network_request.dart';
import '../model/company.dart';


class ListViewCompanyPage extends StatefulWidget {
  const ListViewCompanyPage({Key? key}) : super(key: key);

  @override
  State<ListViewCompanyPage> createState() => _ListViewCompanyPageState();
}

class _ListViewCompanyPageState extends State<ListViewCompanyPage> {
  final NetWorkRequest netWorkRequest = NetWorkRequest();
  List<Company> listCompany = <Company>[];
  List<Company> companyDisplay = <Company>[];
  int soTrang = 1;





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    netWorkRequest.numberPage(soTrang);
    netWorkRequest.fetchCompany().then((dataFromSever) {
      setState(() {
        listCompany.addAll(dataFromSever);
        companyDisplay = listCompany;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('List Company')),
      ),
      body: ListView.builder(
          key: UniqueKey(),
          itemCount: companyDisplay.length + 1,
          itemBuilder: (BuildContext context, int index) {
            return index == 0 ? _searchView() : _listItem(index - 1);
          })
    );
  }

  _searchView() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              companyDisplay = listCompany
                  .where((data) => (data.ma_so_thue
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
                  data.company_name
                      .toLowerCase()
                      .contains(text.toLowerCase())))
                  .toList();
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue),
                  ),
                ),
                child: Icon(Icons.navigate_before),
                onPressed: () async {
                  //direct phone call
                  if(soTrang > 1){
                    soTrang=soTrang-1;
                    setState(() {
                      netWorkRequest.numberPage(soTrang);
                      netWorkRequest.fetchCompany().then((dataFromSever) {
                        setState(() {
                          listCompany = dataFromSever;
                          companyDisplay = listCompany;
                          print(listCompany.last.id);

                        });
                      });
                    });
                  }

                  //print(soTrang);

                }
            ),
            TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue),
                  ),
                ),
                child: Text('$soTrang'),


                onPressed: () async {
                  //direct phone call

                }
            ),
            TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue),
                  ),
                ),
                child: Icon(Icons.navigate_next),
                onPressed: () async {
                  //direct phone call
                    soTrang=soTrang+1;
                    setState(() {
                      netWorkRequest.numberPage(soTrang);
                      netWorkRequest.fetchCompany().then((dataFromSever) {
                        setState(() {
                          listCompany = dataFromSever;
                          companyDisplay = listCompany;
                          print(listCompany.last.id);

                        });
                      });
                    });
                  //print(soTrang);

                }
            ),
          ],
        )
      ]),
    );
  }

  listItem(index) {
    return ListTile(
      contentPadding: const EdgeInsets.all(12.0),
      title: Text(companyDisplay[index].ma_so_thue,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
          textAlign: TextAlign.justify),
      subtitle: Text(companyDisplay[index].company_name,
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto'),
          textAlign: TextAlign.justify),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailCompany(company: companyDisplay[index]))),
      trailing: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue),
          ),
        ),
        child: const Text('Call'),
        onPressed: () async {
          //direct phone call
          if (companyDisplay[index].company_phone != null) {
            await FlutterPhoneDirectCaller.callNumber(
                companyDisplay[index].company_phone!);
          }
        },
      ),
    );
  }

  _listItem(index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding:
          const EdgeInsets.only(top: 25, bottom: 25, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mã số thuế: " + companyDisplay[index].ma_so_thue,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                companyDisplay[index].company_name,
                textAlign: TextAlign.justify,
              ),
              Text(
                "Địa chỉ: " + companyDisplay[index].company_address,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailCompany(company: companyDisplay[index]))),
    );
  }
}
