import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  final String initialValue;

  const CalculatorScreen({super.key, required this.initialValue});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _expression = '';
  double _firstOperand = 0;
  String _operator = '';
  bool _shouldResetDisplay = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialValue;
    if (initial.isNotEmpty && double.tryParse(initial) != null && double.parse(initial) != 0) {
      _display = initial;
      _expression = initial;
      _firstOperand = double.parse(initial);
    }
  }

  void _onDigitPressed(String digit) {
    setState(() {
      if (_hasError) {
        _clear();
      }
      if (_shouldResetDisplay) {
        _display = '';
        _shouldResetDisplay = false;
      }
      // 소수점 중복 방지
      if (digit == '.' && _display.contains('.')) return;
      // 앞자리 0 처리
      if (_display == '0' && digit != '.') {
        _display = digit;
      } else {
        // 최대 15자리 제한
        if (_display.length >= 15) return;
        _display += digit;
      }
    });
  }

  void _onOperatorPressed(String op) {
    if (_hasError) return;
    setState(() {
      if (_operator.isNotEmpty && !_shouldResetDisplay) {
        // 이전 연산 수행
        _calculate();
        if (_hasError) return;
      }
      _firstOperand = double.tryParse(_display) ?? 0;
      _operator = op;
      _expression = '${_formatDisplay(_firstOperand)} $op';
      _shouldResetDisplay = true;
    });
  }

  void _onEqualsPressed() {
    if (_hasError || _operator.isEmpty) return;
    setState(() {
      final secondOperand = double.tryParse(_display) ?? 0;
      _expression = '${_formatDisplay(_firstOperand)} $_operator ${_formatDisplay(secondOperand)} =';
      _calculate();
      _operator = '';
      if (!_hasError) {
        _firstOperand = double.tryParse(_display) ?? 0;
      }
    });
  }

  void _calculate() {
    final secondOperand = double.tryParse(_display) ?? 0;
    double result;

    switch (_operator) {
      case '+':
        result = _firstOperand + secondOperand;
        break;
      case '-':
        result = _firstOperand - secondOperand;
        break;
      case '×':
        result = _firstOperand * secondOperand;
        break;
      case '÷':
        if (secondOperand == 0) {
          _hasError = true;
          _display = 'Error';
          return;
        }
        result = _firstOperand / secondOperand;
        break;
      default:
        return;
    }

    // 999,999,999 제한
    if (result.abs() > 999999999) {
      _hasError = true;
      _display = 'Error';
      return;
    }

    _display = _formatResult(result);
    _firstOperand = result;
    _shouldResetDisplay = true;
  }

  String _formatResult(double value) {
    // 정수인 경우 소수점 제거
    if (value == value.truncateToDouble() && !value.isInfinite && !value.isNaN) {
      return value.toInt().toString();
    }
    // 소수점 6자리까지 반올림 후 불필요한 0 제거
    String result = value.toStringAsFixed(6);
    // 뒤쪽 0 제거
    result = result.replaceAll(RegExp(r'0+$'), '');
    result = result.replaceAll(RegExp(r'\.$'), '');
    return result;
  }

  String _formatDisplay(double value) {
    if (value == value.truncateToDouble() && !value.isInfinite && !value.isNaN) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  void _clear() {
    setState(() {
      _display = '0';
      _expression = '';
      _firstOperand = 0;
      _operator = '';
      _shouldResetDisplay = false;
      _hasError = false;
    });
  }

  void _onBackspace() {
    if (_hasError) {
      _clear();
      return;
    }
    setState(() {
      if (_display.length > 1) {
        _display = _display.substring(0, _display.length - 1);
      } else {
        _display = '0';
      }
    });
  }

  void _onDone() {
    if (_hasError) return;
    // 아직 연산이 남아있으면 계산 후 반환
    if (_operator.isNotEmpty && !_shouldResetDisplay) {
      _onEqualsPressed();
      if (_hasError) return;
    }
    Navigator.pop(context, _display);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('계산기'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            // 디스플레이 영역
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // 수식
                    Text(
                      _expression,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // 현재 값/결과
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        _display,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: _hasError
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 키패드 영역
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                  ),
                ),
              ),
              child: Column(
                children: [
                  _buildRow(['C', '(', ')', '÷']),
                  _buildRow(['7', '8', '9', '×']),
                  _buildRow(['4', '5', '6', '-']),
                  _buildRow(['1', '2', '3', '+']),
                  _buildRow(['0', '.', '⌫', '=']),
                ],
              ),
            ),
            // 환율계산기로 돌아가기 버튼
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _hasError ? null : _onDone,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    disabledBackgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 1,
                  ),
                  child: const Text(
                    '환율계산기로 돌아가기',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(List<String> keys) {
    return Row(
      children: keys.map((key) => _buildKey(key)).toList(),
    );
  }

  Widget _buildKey(String text) {
    final isOperator = ['+', '-', '×', '÷'].contains(text);
    final isEquals = text == '=';
    final isClear = text == 'C';
    final isParenthesis = text == '(' || text == ')';
    final isBackspace = text == '⌫';
    final isSpecial = isOperator || isEquals || isClear || isParenthesis || isBackspace;

    Color bgColor;
    Color fgColor;

    if (isEquals) {
      bgColor = Theme.of(context).colorScheme.primary;
      fgColor = Theme.of(context).colorScheme.onPrimary;
    } else if (isSpecial) {
      bgColor = Theme.of(context).colorScheme.primaryContainer;
      fgColor = Theme.of(context).colorScheme.onPrimaryContainer;
    } else {
      bgColor = Theme.of(context).colorScheme.surface;
      fgColor = Theme.of(context).colorScheme.onSurface;
    }

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(2),
        height: 56,
        child: ElevatedButton(
          onPressed: () => _onKeyPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: fgColor,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: isOperator || isEquals ? 22 : 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _onKeyPressed(String key) {
    switch (key) {
      case 'C':
        _clear();
        break;
      case '(':
      case ')':
        // 괄호는 현재 미지원 (향후 확장 가능)
        break;
      case '⌫':
        _onBackspace();
        break;
      case '+':
      case '-':
      case '×':
      case '÷':
        _onOperatorPressed(key);
        break;
      case '=':
        _onEqualsPressed();
        break;
      default:
        _onDigitPressed(key);
        break;
    }
  }
}
