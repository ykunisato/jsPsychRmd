
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jsPsychRmd

<!-- badges: start -->

<!-- badges: end -->

jsPsychRmdは，jsPsychをRmarkdownを使って書くための準備をするためのRパッケージです。具体的には，jsPsychで行動課題を作る上で最小構成のスクリプトの入ったRmarkdownテンプレートを準備，jspsych-6.1.0をダウンロードしてフォルダを保存，刺激などをいれるstimuliフォルダを作成します。１行のコードでこれができます。

## インストール

インストールは以下の方法でお願いします（devtoolsが必要です）。

    # install.packages("devtools")
    devtools::install_github("ykunisato/jsPsychRmd")

## 使い方

jsPsychで行動課題を作りたいフォルダに移動して，以下を実行します。以下の場合だとstroopという名前のRmdファイルができるので，それを開いて，Knitを押すと，「こんにちは！」が表示されるHTMLファイルが作られます。後は，各種jsPsychのチュートリアルに従ってコードなどを追加していけば，課題が作れます。

    set_jsPsych(file_name = "stroop", pavlovia = FALSE)

現状では未完成ですが，jsPsychをPavloviaで行うための機能を追加予定です（pavlovia =
TRUEにすればできるようにしたい）。Pavloviaに詳しい方が，おられれば，コメントいただけたら嬉しいです。
