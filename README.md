# FastLocation — FastDelivery

Aplicativo acadêmico em **Flutter/Dart** para consultar CEP e endereços brasileiros usando a API pública **ViaCEP**.

## Funcionalidades
- Consulta por CEP (8 dígitos)
- Busca por UF, cidade e logradouro (parcial ou completo)
- Histórico persistente de consultas via Hive
- Interface reativa usando MobX e flutter_mobx
- Splash screen animada, indicadores de carregamento, busca vazia e erros
- Rotas no aplicativo de mapas instalado, a partir da localização atual gerenciada pelo app de mapas
- Compatível com Android e iOS (após geração dos projetos nativos)

## Requisitos
- Flutter SDK instalado (Flutter 3.24+ recomendado)
- Dart SDK incluído no Flutter
- Android Studio / SDK Android para Android; macOS com Xcode para compilar iOS
- Internet para consultar o ViaCEP e geocodificar o endereço

## Como executar

Este pacote contém todo o código Dart e a configuração do aplicativo. Como o Flutter SDK não está disponível no ambiente em que o pacote foi gerado, os diretórios nativos Android e iOS precisam ser criados **uma vez** no computador que tenha Flutter:

```bash
flutter create --project-name fastlocation --platforms android,ios .
flutter pub get
flutter run
```

**Importante:** execute os comandos na pasta que contém `pubspec.yaml`. `flutter create` preserva o código existente e gera a estrutura nativa necessária.

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

## Publicação no GitHub

```bash
git init
git add .
git commit -m "Implementa aplicativo FastLocation"
git branch -M main
git remote add origin https://github.com/gcolomboo/fastlocation.git
git push -u origin main
```

Crie primeiro o repositório vazio `fastlocation` no GitHub do usuário `gcolomboo`. Envie o link do repositório na plataforma da faculdade.

## Antes de publicar

1. Execute `flutter create --project-name fastlocation --platforms android,ios .` para gerar os projetos nativos.
2. Confira em `android/app/src/main/AndroidManifest.xml` a permissão `<uses-permission android:name="android.permission.INTERNET" />` dentro de `<manifest>` e fora de `<application>`. Adicione-a se estiver ausente.
3. Execute `flutter pub get`, `flutter analyze`, `flutter test` e `flutter run`.
4. Só publique após corrigir eventuais erros do ambiente e testar as consultas e a abertura de mapas em um dispositivo.

## Nota sobre as versões

O enunciado cita versões antigas de Dio, MobX, Map Launcher e outras bibliotecas. Este projeto usa versões mais recentes para compatibilidade com Dart 3 e Flutter moderno, mantendo as tecnologias exigidas.
