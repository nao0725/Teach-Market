function markdownCode() {
  const codeInput = document.getElementById('user_answer_code');  // idが'user_answer_code'のもの(textarea)
  const codeMarkdown = document.getElementById('code_markdown');  // idが'code_markdown'のもの(空のdiv)
  if (codeInput == null || codeMarkdown == null) {
    return;  // 該当ページでない場合はアーリーリターン
  }

  codeInput.addEventListener('input', () => {
    const HTML = `${codeInput.value}`;
    codeMarkdown.innerHTML = marked(HTML);
    const pre_code_nodes = document.querySelectorAll("pre code");  // ここがポイント
    for(let i = 0; i < pre_code_nodes.length; ++i){                // ここがポイント
      hljs.highlightBlock(pre_code_nodes[i]);                      // ここがポイント
    }
  });
};

window.addEventListener("load", markdownCode);