function markdownCode() {
  const codeInput = document.getElementById('user_answer_code');
  const codeMarkdown = document.getElementById('code_markdown');
  if (codeInput == null || codeMarkdown == null) {
    return;
  }

  codeInput.addEventListener('input', () => {
    const HTML = `${codeInput.value}`;
    codeMarkdown.innerHTML = marked(HTML);
    const pre_code_nodes = document.querySelectorAll("pre code");
    for(let i = 0; i < pre_code_nodes.length; ++i){
      hljs.highlightBlock(pre_code_nodes[i]);
    }
  });
};

window.addEventListener("load", markdownCode);