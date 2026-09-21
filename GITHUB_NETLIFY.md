# Publicar o Descubra RR pelo celular

## 1. GitHub
Crie um repositório no GitHub, por exemplo `descubra-rr`.

Envie **todos os arquivos desta pasta** para o repositório, mantendo:
- `lib/main.dart`
- `pubspec.yaml`
- `netlify.toml`
- `web/index.html`

## 2. Netlify
No Netlify:
1. Add new project / Import an existing project.
2. Escolha GitHub.
3. Selecione `descubra-rr`.
4. O Netlify deve ler o `netlify.toml` automaticamente.
5. Publique.

O build será:
`flutter pub get && flutter build web --release`

E a pasta publicada será:
`build/web`

## Observação
A configuração abaixo foi preparada para o Netlify fazer a compilação do Flutter Web na nuvem, sem exigir Flutter instalado no celular.
