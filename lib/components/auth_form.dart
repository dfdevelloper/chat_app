import 'dart:io';

import 'package:chat_app/components/user_image_picker.dart';
import 'package:chat_app/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  AuthForm({required this.onSubmit});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showErrorMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

  void _submit() {
    bool? _isValid = _formKey.currentState?.validate() ?? false;
    if (!_isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showErrorMsg('Imagem de perfil não selecionada!');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              if (_formData.isSignup)
                UserImagePicker(
                  onImagePicked: _handleImagePick,
                ),
              if (_formData.isSignup)
                TextFormField(
                  key: ValueKey('Name'),
                  initialValue: _formData.name,
                  onChanged: (value) => _formData.name = value,
                  validator: (value) {
                    final _name = value ?? '';
                    if (_name.length < 5) {
                      return 'Nome precisa conter mais de cinco letras!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
              TextFormField(
                key: ValueKey('Email'),
                initialValue: _formData.email,
                onChanged: (value) => _formData.email = value,
                validator: (value) {
                  final _email = value ?? '';
                  if (!_email.contains('@')) {
                    return 'Escolha um e-mail válido';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                key: ValueKey('password'),
                obscureText: true,
                initialValue: _formData.password,
                onChanged: (value) => _formData.password = value,
                validator: (value) {
                  final _password = value ?? '';
                  if (_password.length < 6) {
                    return 'A senha deve ter no mínimo 6 caractéres';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: Text(_formData.isLogin
                    ? 'Criar nova conta'
                    : 'Já possui conta?'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
