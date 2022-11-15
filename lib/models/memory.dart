import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Memory {
  String _value = '0';
  String get value => _value;

  static const operations = ["%", "/", "x", "-", "+", "="];

  final List<double> _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String? _operation;
  bool _wipeValue = false;
  String? _lastCommand;

  void applyCommand(String command) {
    // Caso o usuário clique em uma operação e queira mudar para outra na hora, faremos o tratamento de
    // trocar de operação aqui, ou seja, se a tecla primeiramente clicada for uma operação, e logo depois a proxima tecla
    // também for uma operação que não seja = (igual) , será feito uma re-operação, sendo uma troca de operação.
    // Exemplo: Usuário apertou 10 *x* mas se esqueceu que era *+*, ele irá apertar o + e ficará 10 + e o proximo valor,
    // porem se ele teclar o =, a conta será calculada.
    if (_isReplacingOperation(command)) {
      _operation = command;
      return;
    }
    // Se o a tecla clicada for a AC, irá ser acionada a função de limpar os dados do Display, _allClear();
    if (command == 'AC') {
      _allClear();
    }
    //Se o usuário tiver clicado em algum botão que contém alguma das Strings definidas na
    //variavel *operations* ele irá passar o comando(String) da operação selecionada.
    else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }
    // Aqui pegaremos o valor da tecla clicada, antes de selecionar a proxima tecla, para conseguirmos
    //fazer a função isReplacingOperations.
    _lastCommand = command;
  }

  _isReplacingOperation(String command) {
    return operations.contains(_lastCommand) &&
        operations.contains(command) &&
        _lastCommand != "=" &&
        command != "=";
  }

  //Limpar todo display.
  _allClear() {
    //Deixar o valor em 0.
    _value = '0';
    //Deixar o buffer todo em 0.
    _buffer.setAll(0, [0.0, 0.0]);
    // Deixar o index do buffer de volta para o zero.
    _bufferIndex = 0;
    // Deixar sem nenhuma operação na memoria
    _operation = null;

    _wipeValue = false;
  }

  _setOperation(String newOperation) {
    // Aqui, caso estejamos no index 0 (primeiro) , do *_buffer* ou seja, na primeira parte da operação,
    // E clicamos para setar uma nova operação em alguns dos botoões de operação,
    // A ideia é que passemos para o index 1 (segundo), passando os novos digitos para finalizar a operação.
    bool isEqualSign = newOperation == '=';
    if (_bufferIndex == 0) {
      if (!isEqualSign) {
        _operation = newOperation;
        _bufferIndex = 1;
        _wipeValue = true;
      }
    } else {
      // Quando o calculo é feito, todo resultado é jogado para o index 0 do buffer, exemplo : 5 + 5 = 10 , [10.0, 0.0], e o index 1
      // Fica zerado para novos dígitos / operações.

      _buffer[0] = _calculate();
      _buffer[1] = 0.0;

      // Aqui estamos passando o valor final para o buffer.
      _value =
          NumberFormat.currency(locale: 'eu', symbol: "").format(_buffer[0]);

      // Como o resultado sempre será um double, o valor no Display ficara sempre com .0 no final, o que não
      // é interessante em numeros inteiros, então fiz uma variavel para trabalhar nisso.
      // se _value ( Valor) terminar em .0 significa que é um numero inteiro, então não tem necessidade, porém se
      //  _value tiver numeros quebrados no meio, exemplo : 123.45 ele irá aparecer normalmente.

      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;

      _operation = isEqualSign ? null : newOperation;
      _bufferIndex = isEqualSign ? 0 : 1;
      if (isEqualSign) debugPrint(_value);

      // Quando apertarmos o botão de operação, a intenção é que o display limpe os numeros
      // Digitados antes, e fique apenas os numeros do indice 1 (um) do *_buffer*, ou seja
      // O da proxima operação.
      // E faremos isso setando a *_wipeValue* para verdadeira (true).

      _wipeValue = !isEqualSign;
    }
  }

  _addDigit(String digit) {
    // Como o zero a esquerda não tem utilidade, substituiremos
    // ele caso for pressionado um novo dígito (pelo proprio digito pressionado) ou deixaremos
    // ele caso seja pressionado o ponto(.).

    final isDot = digit == ".";
    final wipeValue = (_value == '0' && !isDot) || _wipeValue == true;

    // Aqui é tratado caso já tenha ponto no *_buffer* para não adicionar mais pontos.
    if (isDot && _value.contains('.') && !wipeValue) {
      return;
    }

    // Logo aqui, se tiver sido pressionado algum botão de operação, a intenção é que o próximo
    // digito esteja apenas ele e não junto com os digitos do indice 0 do *_buffer*.
    // Por isso validaremos, *currentValue* retorna : se *wipeValue* for true, zera o *_buffer* e espera novo digito.
    // Se não,  continua o mesmo valor, pois não foi pressionado nenhum botão de operação.

    // O *emptyValue* serve para caso depois de pressionar o botão de alguma operação, se o usuário
    // digitar um ponto(.), o valor fique zero e ponto (0.), e não somento um ponto.

    final emptyValue = isDot ? '0' : '';
    final currentValue = wipeValue ? emptyValue : _value;
    _value = currentValue + digit;
    _wipeValue = false;

    // Aqui setaremos o buffer com os valores.

    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;

    debugPrint(_buffer.toString());
  }

// Função de calcular.
  _calculate() {
    switch (_operation) {
      case '%':
        return _buffer[0] * _buffer[1] / 100;
      case '/':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      default:
        return _buffer[0];
    }
  }
}
