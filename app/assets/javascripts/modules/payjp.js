document.addEventListener( //
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
      Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); //ここに公開鍵を直書き
      let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得されます
      btn.addEventListener("click", e => {
        e.preventDefault(); //ボタンを一旦無効化します
        let card = {
          number: document.getElementById("credit_card_card_number").value,
          cvc: document.getElementById("credit_card_cvc").value,
          exp_month: document.getElementById("credit_card_exp_month").value,
          exp_year: document.getElementById("credit_card_exp_year").value
        }; //入力されたデータを取得します。
        Payjp.createToken(card, (status, response) => {
          if (status === 200) {
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
            $("#card_token").append(
              $(`<input type="hidden" name="payjp-token">`).val(response.id)
            ); //取得したトークンを送信できる状態に
            document.inputForm.submit();
            alert("登録が完了しました");
          } else {
            alert("カード情報が正しくありません。");
          }
        });
      });
    }
  },
  false
);