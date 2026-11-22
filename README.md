# FastLocation — FastDelivery

Aplicativo acadêmico em **Flutter/Dart** para consultar CEP e endereços brasileiros usando a API pública **ViaCEP**.

## Funcionalidades
- Consulta por CEP (8 dígitos)
- Busca por UF, cidade e logradouro (parcial ou completo)
- Histórico persistente de consultas via Hive
- Interface reativa usando MobX e flutter_mobx
- Splash screen animada, indicadores de carregamento, busca vazia e erros
- Rotas no aplicativo de mapas instalado, a partir da localização atual gerenciada pelo app de mapas
- Estrutura de projeto Android e iOS incluída (compilação Android validada; execução em dispositivo e compilação iOS ainda não validadas)

## Requisitos
- Flutter SDK instalado (Flutter 3.24+ recomendado)
- Dart SDK incluído no Flutter
- Android Studio / SDK Android para Android; macOS com Xcode para compilar iOS
- Internet para consultar o ViaCEP e geocodificar o endereço

## Como executar

O repositório já inclui os diretórios nativos `android/` e `ios/`. Com o Flutter SDK configurado e um dispositivo ou emulador disponível, execute na pasta que contém `pubspec.yaml`:

```bash
flutter pub get
flutter run
```

Para compilar Android pelo GitHub Actions, acesse a aba **Actions** do repositório e consulte o workflow de compilação Android. A compilação Android mais recente anterior à atualização deste README foi concluída com sucesso.

Para testar:

```bash
flutter test
flutter analyze
```

Se houver conflito de dependências com uma versão diferente do Flutter, ajuste as versões no `pubspec.yaml` e execute `flutter pub get` novamente.

## Estrutura

- `lib/main.dart`: inicialização Flutter e Hive
- `lib/src/app.dart`: tema e rotas
- `lib/src/http`: Dio e comunicação HTTP
- `lib/src/shared`: cores, componentes, métricas e armazenamento
- `lib/src/modules/initial`: abertura animada
- `lib/src/modules/home`: modelos, repositórios, serviço, controller MobX e tela
- `lib/src/modules/history`: controller MobX e tela de histórico
- `test`: teste básico do modelo

## API

ViaCEP: `https://viacep.com.br/ws/`

- CEP: `https://viacep.com.br/ws/01001000/json/`
- Endereço: `https://viacep.com.br/ws/SP/Sao%20Paulo/Praca%20da%20Se/json/`

A busca por endereço requer UF com duas letras e cidade/logradouro com pelo menos três caracteres.

## Observações

- O MobX é usado com observáveis e ações explícitas (`Observable`, `ObservableList` e `runInAction`), sem depender de arquivos `.g.dart` gerados. As dependências de codegen constam no projeto conforme o enunciado.
- O histórico é local, sem cadastro ou envio de dados pessoais a servidor próprio.
- Para traçar rota, o aplicativo geocodifica o endereço e abre um app de mapas instalado. A rota é calculada pelo app de mapas, que pode solicitar acesso à localização atual.
- Para Android, confirme permissão de internet no manifesto caso a geração nativa não a inclua. No iOS, testes e compilação exigem macOS/Xcode.
- A disponibilidade de mapas e a precisão da geocodificação dependem do dispositivo e dos serviços instalados.

## Repositório e verificação

Código-fonte: https://github.com/gcolomboo/fastlocation

A compilação Android é automatizada em `.github/workflows/`. O resultado bem-sucedido pode ser consultado em https://github.com/gcolomboo/fastlocation/actions/runs/45030211092.

Para validação local, execute `flutter pub get`, `flutter analyze`, `flutter test` e `flutter run` em um ambiente com Flutter e dispositivo/emulador configurado. A execução das consultas, o histórico e a abertura de mapas em dispositivo real ainda precisam ser testados. Para compilar e executar no iOS, é necessário macOS com Xcode.

## Nota sobre as versões

O enunciado cita versões antigas de Dio, MobX, Map Launcher e outras bibliotecas. Este projeto usa versões mais recentes para compatibilidade com Dart 3 e Flutter moderno, mantendo as tecnologias exigidas.
