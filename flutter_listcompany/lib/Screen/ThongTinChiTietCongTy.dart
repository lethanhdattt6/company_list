import 'package:flutter/material.dart';
import 'package:flutter_listcompany/model/company.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailCompany extends StatefulWidget {
  const DetailCompany({Key? key,required this.company}) : super(key: key);
  final Company company;

  @override
  State<DetailCompany> createState() => _DetailCompanyState();
}

class _DetailCompanyState extends State<DetailCompany> {
  @override  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company.ma_so_thue.toString()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                    title:
                    Text("Mã số thuế: " + widget.company.ma_so_thue.toString())),
                ListTile(
                  title: Text("Tên công ty: " + widget.company.company_name),
                ),
                ListTile(
                  title: Text("Người đại diện: " + widget.company.representative),
                ),
                ListTile(
                  title: Text("Địa chỉ: " + widget.company.company_address),
                ),
                ListTile(
                  title: Text(widget.company.company_phone == null
                      ? "Số điện thoại: Không có"
                      : "Số điện thoại: " + widget.company.company_phone!),
                ),
                ListTile(
                  title: Text(widget.company.managed_by == null
                      ? "Quản lý bởi: Không có"
                      : "Quản lý bởi: " + widget.company.managed_by!),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                    ),
                    child: const Text('Call'),
                    onPressed: ()  {
                      //direct phone call
                      launch('tel:0${widget.company.company_phone.toString()}');
                      Future.delayed(const Duration(seconds: 5), () {

                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
