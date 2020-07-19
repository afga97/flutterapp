import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  String _nombre = '';
  String _email = '';
  String _fecha = '';
  String _poderSeleccionado = 'Correr';

  List<String> _poderes = ['Volar', 'Nadar', 'Correr'];

  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs text'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        children: <Widget>[
          _crearInput(),
          Divider(),
          _crearEmail(),
          Divider(),
          _crearPassword(),
          Divider(),
          _crearDate(context),
          Divider(),
          _crearDropdown(),
          Divider(),
          _crearPersona(),
        ],
      ),
    );
  }

  Widget _crearInput() {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        counter: Text('Letras ${_nombre.length}'),
        hintText: 'Nombre de la persona',
        labelText: 'Nombre',
        helperText: 'Solo es el nombre',
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon(Icons.account_circle)
      ),
      onChanged: (valor){
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  Widget _crearEmail() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Email de la persona',
        labelText: 'Email',
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email)
      ),
      onChanged: (valor) => setState(() { _email = valor; }),
    );
  }

  Widget _crearPassword() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Password',
        labelText: 'Password',
        suffixIcon: Icon(Icons.lock),
        icon: Icon(Icons.vpn_key)
      ),
      onChanged: (valor) => setState(() { _email = valor; }),
    );
  }


  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();

    _poderes.forEach( (poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder
      ));
    });

    return lista;
  }

  Widget _crearDropdown(){

    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: _poderSeleccionado,
            items: getOpcionesDropdown(),
            onChanged: (value) {
              setState(() {
                _poderSeleccionado = value;
              });
            }
          ),
        )
      ],
    );

  }

  Widget _crearDate(BuildContext context){
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Fecha nacimiento',
        labelText: 'Fecha nacimiento',
        suffixIcon: Icon(Icons.date_range),
        icon: Icon(Icons.calendar_view_day)
      ),
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate( context );
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime(2018), 
      lastDate: new DateTime(2025),
      locale: Locale('es', 'CO')
    );

    if ( picked != null ){
      setState(() {
        _fecha = picked.toString();
        _inputFieldDateController.text = _fecha;
      });
    }
  }


  Widget _crearPersona() {

    return ListTile(
      title: Text('Nombre es: $_nombre'),
      subtitle: Text('Email es: $_email'),
      trailing: Text(_poderSeleccionado),
    );

  }

}