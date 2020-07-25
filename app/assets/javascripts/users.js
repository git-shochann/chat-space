$(function(){

  function buildHTML(user){  //一致するユーザーがいるときのHTML
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${user.name}</p>
                  <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
                </div>`
    $("#user-search-result").append(html);
  }

  function buildHTML2(){ //ユーザーが該当しない場合のHTML
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">ユーザーが見つかりません</p>
                </div>`
    $("#user-search-result").append(html);
  }

  // インクリメンタルサーチ後の実装に置いて必要な関数！
  
  function UserAppend(id,name){ // チャットメンバー欄に新しく追加するHTML
    html = `
            <div class='chat-group-user'>
              <input name='group[user_ids][]' type='hidden' value=${id}>  
                <p class='chat-group-user__name'>${name}</p>
              <div class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</div>
            </div>
           `
    $(".js-add-user").append(html);

    // 23行目の記述のvalue=${id}により、パラメーターとして発生する！
    // input要素のvalue属性に関して => 送信ボタンを押したときに、どのような値が送られるのかを決めることができる。
    // このname属性はなんだっけ？
  }


  $("#user-search-field").on("keyup", function(){
    var input = $("#user-search-field").val()
    // console.log(input);
    $.ajax({
      type: "GET",
      url: "/users",
      data: {keyword: input}, // キー名とバリュー
      dataType: "json"
    })
    .done(function(users){
      $("#user-search-result").empty() // emptyメソッドで取得したDOM要素("#user-search-result")の小要素を削除する!
      if (users.length !== 0) {
        users.forEach(function(user) {
        buildHTML(user)
        });
      } else {
        buildHTML2()
      }
    })
    .fail(function(){
      alert("通信に失敗しました！");
    })
  })
  $(document).on("click",".user-search-add", function(){ // 画像などを除いてHTMLの読み込みが終わってからon以下が実行。
    var id = $(this).attr("data-user-id");  // clickイベントが起きた後attrで属性値を取得！ 取得する理由はこのidは更新ボタンを押したとき、ユーザーのIDをDBに送る為。
    var name = $(this).attr("data-user-name"); // ここの名前はappendで貼り付けるHTMLに必要な名前！
    $(this).parent().remove(); // 検索の一覧から削除する
    UserAppend(id,name) // ユーザー一覧にappendする（関数を呼び出す）
  })
  $(document).on("click", ".user-search-remove", function(){
    $(this).parent().remove() // クリックした要素の親要素を削除！
  })
});

// prefixを使用出来るのは限られていて、JSファイルでは使えない。

// インクリメンタルサーチ後の実装をやるにあたってポイントの流れ。

// 後から追加されたボタン"追加する"に関して、イベントを発火させるときどうすればいいのか？

// 1つのイベントに対して、
// ① 追加ボタンをクリックしたら検索結果一覧から消される。
// ② 追加ボタンをクリックしたら、チャットメンバーに追加される。

// parent()メソッド 親要素の取得！

// 47のif文 , else if  (input.length == 0)があると0のとき,0であるとき,それ以外で可読性が向上する。