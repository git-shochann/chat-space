$(function(){

  // 画像がある場合とない場合で条件分岐する。// 貼り付けるHTMLを作成の関数を定義する！
  function buildHTML(one_message){
    // もしメッセージに画像が含まれていたら、
    if (one_message.image) { // メッセージに画像が含まれる場合のHTMLを作る
    var html = `<div class="main-chat__message__box">
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
    var html = `<div class="main-chat__message__box">
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

// scrollTopメソッド
// 指定した値の分だけanimateメソッドを利用した要素をスクロール

// scrollHeightメソッド (JSのメソッド) == DOMを取得してから使えるメソッド
// 全体の高さを取得

// $('main-chat__message')[0].scrollHeight == チャット履歴の全体の高さ分
// ここは、メッセージが入ったdiv要素のスクロールできる高さの数字を取得しています。
// ’’’つまりこのように書くことでスクロールすべき分メッセージが入ったdiv要素をスクロール出来る’’’