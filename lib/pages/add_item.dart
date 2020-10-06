import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:onigiri/api/firebase/db/item.dart';
import 'package:onigiri/models/index.dart';

class AddItemPage extends StatefulWidget {
  AddItemPage({Key key}) : super(key: key);

  static final String routeName = '/item/add';

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();

  MoneyMaskedTextController _controller = MoneyMaskedTextController(
    leftSymbol: '\$',
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  Item _item = Item(
    name: "",
    price: 0,
  );
  bool _isLoading = false;

  Widget _renderHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "New Item",
          style: TextStyle(
            color: Colors.black,
            fontSize: 32.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _renderForm() {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter the item name',
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Item name cannot be empty";
                  }
                  return null;
                },
                onSaved: (String value) {
                  _item.name = value;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter the price',
                ),
                validator: (String value) {
                  return null;
                },
                onSaved: (_) {
                  _item.price = (_controller.numberValue * 100).toInt();
                },
              ),
              SizedBox(height: 20.0),
              ButtonTheme(
                minWidth: 200.0,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Submit"),
                  onPressed: () async {
                    if (_isLoading) return;
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      _formKey.currentState.save();
                      await ItemAPI.add(_item);
                      Navigator.of(context).pop(_item);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: screenWidth * 0.2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _renderHeader(),
                SizedBox(height: 10.0),
                _renderForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
