# jsPsychRmd


jsPsychRmdは，jsPsychをRmarkdownを使って書くための準備をするためのRパッケージです。具体的には，jsPsychで行動課題を作る上で最小構成のスクリプトの入ったRmarkdownテンプレートを準備して，特定のバージョンのjspsychをダウンロードしてフォルダを保存，刺激などをいれるstimuliフォルダを作成します（その他も機能があります）。１行のコードでこれができます。

## インストール

インストールは以下の方法でお願いします（remotesが必要です）。

```
# install.packages("remotes")
remotes::install_github("ykunisato/jsPsychRmd")
```
## 使い方

jsPsychRmd::set_jsPsych(folder = FALSE, jsPsych_version = "6.3.1", psychophysics_version = FALSE, exclude_smartphone = FALSE, pavlovia = FALSE, rc = FALSE)は，以下の引数を持ちます。下の例も参考にしつつご利用ください。

- folder: folder = "stroop"のように名前を指定すると，名前をつけたフォルダを作って，そこに各種ファイルを配置します。デフォルトはFALSEなので，指定しなければ，カレントディレクトリーにファイルが置かれます（folerを指定して，フォルダを整理することを推奨します）。
- jsPsych_version:  デフォルトはjsPsychの6.3.1になっていますが，別のバージョン番号を指定すれば，それがダウンロードされ，Rmdファイルの設定も変わります。
- psychophysics_version: デフォルトはFALSEですが，TRUEにすると，九州大学の黒木先生の[jspsych-psychophysics](https://jspsychophysics.hes.kyushu-u.ac.jp/)の2.3.2がダウンロードされ，Rmdファイルの設定も変わります。別のバージョン番号を指定すれば，それがダウンロードされ，Rmdファイルの設定も変わります。
- exclude_smartphone: デフォルトはFALSEですが，TRUEにすると，スマートフォンからのアクセスの場合に警告メッセージを出して終了する設定をするかどうかをコードがRmdファイルの設定に追加されます。
- pavlovia: デフォルトはFALSEですが，TRUEにすると，Pavloviaで実験をする時に使えるコードがRmdファイルの設定に追加されます。
- rc: デフォルトはFALSEですが，TRUEにすると，[senshuRmd](https://github.com/ykunisato/senshuRmd )で作るResearch Compendium内のexercisesフォルダ内にjsPsychのフォルダ・ファイルを用意します。

### 1.フォルダ名を指定して，そのフォルダ内にRMarkdownとjsPsychで行動課題を作る場合

以下のように，folderに名前を指定すると，指定した名前でフォルダを作って（以下だとstroop），そのフォルダ内に，Rmdファイル(index.Rmdという名前になります)，刺激をいれるstimuliフォルダ（READMEファイルが入っています），jspsych-6.3.1が配置されます。まずは，Rmdファイルを開いて，Knitを押すと，「こんにちは！」が表示されるHTMLファイルが作られます。後は，各種jsPsychのチュートリアルに従ってコードなどを追加していけば，課題が作れます。

```
jsPsychRmd::set_jsPsych(folder = "stroop")
```


以下のようにすると，jsPsychのバージョンを変えることができますし(6.3.1 → 6.3.0)，九州大学の黒木先生の[jspsych-psychophysics](https://jspsychophysics.hes.kyushu-u.ac.jp/)も追加されます。

```
jsPsychRmd::set_jsPsych(folder = "stroop", jsPsych_version = "6.3.0", psychophysics_version = TRUE)
```


### 2.Research Compendiumのexercises内にRMarkdownとjsPsychで行動課題を作る場合


以下のようにすると，[senshuRmd](https://github.com/ykunisato/senshuRmd )で作るResearch Compendium内のexercisesフォルダ内に  jsPsychの課題用フォルダを作って，Rmdファイル(index.Rmdという名前になります)，刺激をいれるstimuliフォルダ（READMEファイルが入っています），jspsych-6.3.1が配置されます。Rmdファイルを開いて，Knitを押すと，「こんにちは！」が表示されるHTMLファイルが作られます。後は，各種jsPsychのチュートリアルに従ってコードなどを追加していけば，課題が作れます。

```
jsPsychRmd::set_jsPsych(folder = "task", rc = TRUE)
```

### 3.スマートフォンを使った場合に警告メッセージを出す場合

山形大学の小林正法先生の解説（https://www.notion.so/OS-5fc2cf5bc43c4af99bb0a9ee22d8fc7d ）を参考に,参加者がスマートフォンからアクセスしているかどうかの判別と警告メッセージの出すコードを追加したRmdファイルを作成しました。以下のように，exclude_smartphone = TRUEとしていただくと，自動的にスマートフォン使用の判別と警告メッセージを出すコードが追加されたRmdが用意されます。

```
jsPsychRmd::set_jsPsych(folder = "task", exclude_smartphone = TRUE)
```

### 4.用意したフォルダ内にRMarkdownとjsPsychで行動課題を作る場合

folder = "task"でフォルダを新規作成するのではなく，既にあるフォルダ内にファイルを配置したいこともあります。その場合は，以下を実行します(引数の指定は不要です)。用意したフォルダ内に，Rmdファイル(index.Rmdという名前になります)，刺激をいれるstimuliフォルダ（READMEファイルが入っています），jspsych-6.3.1が配置されます。

```
jsPsychRmd::set_jsPsych()
```


### 5.RMarkdownとjsPsychで行動課題を作って，pavloviaで実施する場合

RMarkdownとjsPsychで課題を作ってpavloviaで実施する場合，[pavlovia.orgの解説](https://pavlovia.org/docs/experiments/create-jsPsych)を参考に，Pavlovia's GitLab repositoryに新しいプロジェクトを作って，ご自身のRStudioで，File→New Project→Version ControlからGitプロジェクトを作ります（Version Controlでご自身のPavlovia's GitLab repositoryの設定情報を入れてください）。その上で，以下を実行してもらうと，そのプロジェクト内に，pavloviaに対応した配置のライブラリとRmdファイルを用意します。あとは課題を作って完成させて，pavloviaにアップしたら実行できます（課題の作成時はコメントアウトしているpavloviaとの連携に関する部分のコメントアウトを外す必要はあります）。

```
jsPsychRmd::set_jsPsych(pavlovia = TRUE)
```
