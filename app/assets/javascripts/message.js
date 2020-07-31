$(function(){

  // 画像がある場合とない場合で条件分岐する。// 貼り付けるHTMLを作成の関数を定義する！
  function buildHTML(one_message){
    // もしメッセージに画像が含まれていたら、
    if (one_message.image) { // メッセージに画像が含まれる場合のHTMLを作る
    var html = `<div class="main-chat__message__box" data-message-id="${one_message.id}">
                  <div class="main-chat__message__box__info">
                    <p class="main-chat__message__box__info__talker">
                      ${one_message.user_name}
                    </p>
                    <p class="main-chat__message__box__info__date">
                      ${one_message.created_at}
                    </p>
                  </div>
                  <div class="main-chat__message__box__comment">
                    <p class="main-chat__message__box__comment__detail">
                      ${one_message.content}
                    </p>
                      <img class="main-chat__message__box__comment__image" src="${one_message.image}">
                  </div>
                </div>`
        return html;
    } else { // メッセージに画像が含まれない場合のHTMLを作る
    var html = `<div class="main-chat__message__box" data-message-id="${one_message.id}">
                  <div class="main-chat__message__box__info">
                    <p class="main-chat__message__box__info__talker">
                      ${one_message.user_name}
                    </p>
                    <p class="main-chat__message__box__info__date">
                      ${one_message.created_at}
                    </p>
                  </div>
                  <div class="main-chat__message__box__comment">
                    <p class="main-chat__message__box__comment__detail">
                      ${one_message.content}
                    </p>
                  </div>
                </div>`
        return html;
    };
  }

  $("#new_message").on("submit", function(e){
    e.preventDefault()
    // console.log("テスト完了！")
    var formData = new FormData(this) // JSのFormDataオブジェクトにする為にフォーム要素を引数にとる。
    var url = $(this).attr('action'); // rails routesでやってもいいけど。
    $.ajax({
      url: url,
      type: 'POST',
      data: formData, // JSのオブジェクトであるキーとバリュー形式でサーバーに送信する
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(one_message){
      var html = buildHTML(one_message);
      // まずは貼り付ける内容に関して、画像がある場合とない場合で貼り付ける内容は異なるので、引数を持たせて関数として定義する。
      // それからappendで追加！
      $(".main-chat__message").append(html);
      $(".main-chat__message").animate({
        scrollTop: $(".main-chat__message")[0].scrollHeight
      });
      $('form')[0].reset();
      $(".main-chat__form__new-message__submit-btn").prop('disabled', false);
    })
    .fail(function(){
      alert("メッセージ送信に失敗しました");
      $(".main-chat__form__new-message__submit-btn").prop('disabled', false);
    })
  });

  //// 自動更新機能 ////

  // $(function(){
  //   var last_message_id = $(".main-chat__message__box:last").data("message-id");
  //   console.log(last_message_id);
  // }) メッセージの最後の番号を取得する為に書いている記述。

  var reloadMessages = function(){
    var last_message_id = $(".main-chat__message__box:last").data("message-id");
    $.ajax({
      url: 'api/messages',
      type: 'GET',
      dataType: 'json',
      data: {id: last_message_id}
      // urlに関して現在のurlは"http://localhost:3000/groups/1/messages"である。
      // 相対パスで書くことで、自動的に現在ブラウザに表示されているURLの後に繋がる形になる
      // 例えば現在の見ているページのURLがgroups/3/messagesとして、urlに"hello"と指定すればリクエストのURLはgroups/3/helloとなる
      // 重要！ ルーティングのネストにより、Groupsコントローラー内に、2つMessagesコントローラーがネストされている為、相対パス(現在いる場所からの)は、groups/id/(これ以降)の指定になる。
    })
    .done(function(messages){
      if (messages.length !== 0 ) { // もし更新させるメッセージ(messages)があれば以下を実行する。
      var insertHTML = ''; // ただ変数を使いたいから空で変数に入れてる。buildHTMLの結果を変数化したいから！
      $.each(messages, function(i,message) { // 第一引数messages,第二引数function
        insertHTML += buildHTML(message) // 左辺と右辺を足して左辺に代入 insertHTML = insertHTML + buildHTML(message)
      });
      $(".main-chat__message").append(insertHTML);
      $(".main-chat__message").animate({scrollTop: $(".main-chat__message")[0].scrollHeight});
      // メッセージをまとめている箱をanimateメソッドで動かす。何を？ => まずはスクロールさせたい。=> メッセージをまとめている箱の高さ分スクロールさせる！
      // [0]番目の指定必要？ scrollHeightメソッドで全体的な高さを取得！
    }
    })
    .fail(function(){
      alert("エラーです！")
    })
  };

  if (document.location.href.match(/\/groups\/\d+\/messages/)) {
    // locationはプロパティやメソッドと組み合わせて使う。documentとする理由、画面上の情報を取得できる。
    // 正規表現は基本的には/と/で囲んだ部分で表す。/も含めたい場合、直前にバックスラッシュ(\)を付ける。\d+で1つ。
  
    setInterval(reloadMessages, 4000);
    
    }
});


// セレクタを指定した場合、該当するすべてのHTML要素が取得されます。
// そのため、idセレクタは1つしか要素が取得されませんが（id属性の値は被ることがないため）
// 他のセレクタでは複数の要素が取得される可能性がある為、クラスセレクタは今回使わない。
// 今回はどっちでもいい。

// new FormData(フォーム要素)とすることでFormDataを作成

// ポイントとしてdoneメソッドで受け取ったone_message、
// == jbulderで作成したJSONをそのままbuildHTMLメソッドに渡し、その返り値(return)として完成したHTMLの塊を58行目で受け取っていることです。

// prop()メソッドとattr()メソッドに関して

// reset()メソッド (JSのメソッド) == DOMを取得してから使えるメソッド
// 初期値に戻すメソッド

// 62行目フォームを空にする作業 => $(".main-chat__form__new-message__input-box__text").val("")でもOK

// animateメソッド
// メソッドを利用したオブジェクトが持つ、プロパティなどを指定した値まで持っていくアニメーションのメソッド。

// scrollTopメソッド！
// 指定した値の分だけanimateメソッドを利用した要素を''スクロール''

// scrollHeightメソッド (JSのメソッド) == DOMを取得してから使えるメソッド
// 全体の高さを取得

// $('main-chat__message')[0].scrollHeight == チャット履歴の全体の高さ分
// ここは、メッセージが入ったdiv要素のスクロールできる高さの数字を取得しています。
// ’’’つまりこのように書くことでスクロールすべき分メッセージが入ったdiv要素をスクロール出来る’’’

// ---------------------------------------------------------------------------------


// 自動更新機能 メモ！

// $('.message:last')で.messageというクラスがついている全てのノードのうち最後のノードという意味。

// setInterval()関数
// 一定時間が経過するごとに処理を実行することができる関数
// 第一引数に動かしたい関数名を、第二引数に動かす間隔をミリ秒単位で渡すことが可能！

// jQueryの正規表現にまつわるメソッド => match
// メッセージ以外のページでも自動更新の機能が発火してエラーが出て無駄なトラフィックが発生してしまうので、
// JSの文字列が利用できるメソッドであり、引数に正規表現を取り、メソッドを利用した文字列にその正規表現とマッチする部分があれば、それを含む配列を返り値を渡すメソッド。

// 最後のうまく自動更新ができなかったエラー
// last_message_idがうまく取得できてなかった =>　最後のメッセージを取得するクラスが.main-chat__message:lastと間違えていた。
// その後でも全部メッセージを取得している。 => 最後のメッセージの""だったりクラスの""が無かったので、whereメソッドを無視して最後のメッセージのみではなく全てのメッセージを読み込んでいた。
// jbuilderが読み込まないエラーをターミナルで確認 => views/api/index.json.jbuilderではなく、views/api/messages/index.json.jbuilderだから読み込んでいなかった。