import 'package:emart_app/consts/consts.dart';

Widget orderStatus({icon, color, title}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "$title".text.color(darkFontGrey).make(),
          const Icon(
            Icons.done,
            color: redColor,
          )
        ],
      ),
    ),
  );
}
