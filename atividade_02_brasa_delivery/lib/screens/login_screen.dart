import 'package:flutter/material.dart';

import '../theme/brasa_theme.dart';

/// Tela de acesso demonstrativa.
/// Não realiza login, não salva credenciais e não chama serviços externos.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _senhaVisivel = false;

  void _mostrarAviso(String mensagem) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensagem)));
  }

  void _entrar() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      _mostrarAviso('Login demonstrativo: nenhum dado foi enviado ou armazenado.');
    }
  }

  void _visitarCardapio() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrasaCores.rosa,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight > 24
                          ? constraints.maxHeight - 24
                          : 0,
                    ),
                    padding: const EdgeInsets.fromLTRB(24, 26, 24, 22),
                    decoration: BoxDecoration(
                      color: BrasaCores.branco,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x141E1511),
                          blurRadius: 24,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const _MarcaBrasa(),
                          const SizedBox(height: 22),
                          const Text(
                            'Entrar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                              color: BrasaCores.texto,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Acesse sua conta para continuar.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: BrasaCores.secundario,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 28),
                          const _RotuloCampo('E-mail'),
                          const SizedBox(height: 8),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.email],
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.mail_outline_rounded),
                              hintText: 'Digite seu e-mail',
                            ),
                            validator: (valor) {
                              final email = (valor ?? '').trim();
                              if (email.isEmpty) return 'Informe seu e-mail.';
                              if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                                  .hasMatch(email)) {
                                return 'Digite um e-mail válido.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),
                          const _RotuloCampo('Senha'),
                          const SizedBox(height: 8),
                          TextFormField(
                            obscureText: !_senhaVisivel,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.password],
                            onFieldSubmitted: (_) => _entrar(),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline_rounded),
                              hintText: 'Digite sua senha',
                              suffixIcon: IconButton(
                                tooltip: _senhaVisivel
                                    ? 'Ocultar senha'
                                    : 'Mostrar senha',
                                onPressed: () => setState(
                                  () => _senhaVisivel = !_senhaVisivel,
                                ),
                                icon: Icon(
                                  _senhaVisivel
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),
                            validator: (valor) {
                              if (valor == null || valor.isEmpty) {
                                return 'Informe sua senha.';
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => _mostrarAviso(
                                'Recuperação de senha não disponível neste protótipo.',
                              ),
                              child: const Text(
                                'Esqueci minha senha',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            height: 52,
                            child: FilledButton(
                              onPressed: _entrar,
                              style: FilledButton.styleFrom(
                                backgroundColor: BrasaCores.vermelho,
                                foregroundColor: BrasaCores.branco,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                              ),
                              child: const Text(
                                'Entrar',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 23),
                          const Row(
                            children: [
                              Expanded(child: Divider(color: BrasaCores.borda)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  'ou',
                                  style: TextStyle(
                                    color: BrasaCores.secundario,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Expanded(child: Divider(color: BrasaCores.borda)),
                            ],
                          ),
                          const SizedBox(height: 21),
                          SizedBox(
                            height: 50,
                            child: OutlinedButton.icon(
                              onPressed: () => _mostrarAviso(
                                'Google: integração desativada nesta demonstração.',
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: BrasaCores.texto,
                                side: const BorderSide(
                                  color: BrasaCores.borda,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                              ),
                              icon: const Text(
                                'G',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 19,
                                  color: Color(0xFF4285F4),
                                ),
                              ),
                              label: const Text(
                                'Continuar com Google',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text(
                                'Não tem uma conta?',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: BrasaCores.secundario,
                                ),
                              ),
                              TextButton(
                                onPressed: () => _mostrarAviso(
                                  'Cadastro não disponível neste protótipo.',
                                ),
                                child: const Text(
                                  'Criar conta',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: TextButton.icon(
                              onPressed: _visitarCardapio,
                              icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                              label: const Text(
                                'Explorar como visitante',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Interface de demonstração • sem autenticação',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: BrasaCores.secundario,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RotuloCampo extends StatelessWidget {
  final String texto;
  const _RotuloCampo(this.texto);

  @override
  Widget build(BuildContext context) => Text(
        texto,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: BrasaCores.texto,
        ),
      );
}

class _MarcaBrasa extends StatelessWidget {
  const _MarcaBrasa();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            height: 106,
            width: 106,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 98,
                  width: 98,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    border: Border.all(color: BrasaCores.borda, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(21),
                    child: Image.asset(
                      'assets/images/burger.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 0,
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: BrasaCores.vermelho,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: BrasaCores.branco, width: 3),
                    ),
                    child: const Icon(
                      Icons.local_fire_department_rounded,
                      color: BrasaCores.branco,
                      size: 21,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 9),
        const Text(
          'brasa.',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: BrasaCores.vermelhoEscuro,
            letterSpacing: -0.9,
          ),
        ),
      ],
    );
  }
}
