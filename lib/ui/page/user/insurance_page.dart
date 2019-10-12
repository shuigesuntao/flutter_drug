import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';

class InsurancePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView(
              children: <Widget>[
                Image.asset(
                  ImageHelper.wrapAssets('security_banner.png'),
                  width: double.infinity,
                  height: 140,
                  fit: BoxFit.fill
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15,10,15,5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      left: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 5,
                        style: BorderStyle.solid
                      )
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text('中医师执业保险', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor)),
                      SizedBox(height: 15),
                      Text('为充分保障注册中医师合法权益，一经通过本平台审核，本平台将为注册中医师的线下诊疗活动提供最高保额为【500】万元的医疗责任事故保险。并且，在必要时间向注册中医师提供法律咨询和法律援助信息，为本平台注册中医师提供全方位、多角度的协助与支持')
                    ],
                  ),
                ),
                _buildItem(context,'参保要求','凡符合保险人承包条件的医疗机构及其执业医师，可分别作为本保险合同的被保险机构和被保险医师。'),
                _buildItem(context,'保险范围','在保险期间或保险合同载明的追溯期内，被保险医师代表被保险医疗机构从事与其资格相符的医疗活动过程时，音职业过失行为导致意外事故，造成患者人身伤亡，由患者或其搭理人在保险期间内首次向被保险人提出损害赔偿请求，依照中华人民共和国法律（不包括港澳台地区法律）应由被保险人承担的经济赔偿责任，保险人按照本保险合同约定负责赔偿。'),
                _buildItem(context,'保障额度','50万-500万'),
                _buildItem(context,'保险期限','12个月')
              ],
            )
        ),
        SafeArea(
          child: Container(
              alignment: Alignment.center,
              color: Color(0xFFF2F2F2),
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: SizedBox(
                width: 300,
                child: FlatButton(
                  onPressed: null,
                  padding: EdgeInsets.all(10),
                  disabledColor: Colors.grey[350],
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    '无参保资格',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              )
          ),
          bottom: true,
        )
      ],
    );
  }

  Widget _buildItem(BuildContext context,String title,String content) {
    return Container(
      margin: EdgeInsets.fromLTRB(15,5,15,5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(
            color: Theme.of(context).primaryColor.withAlpha(150),
            width: 5,
            style: BorderStyle.solid
          )
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(fontSize: 18, color:  Theme.of(context).primaryColor)),
          SizedBox(height: 15),
          Text(content)
        ],
      ),
    );
  }
}
