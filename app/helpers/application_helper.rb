module ApplicationHelper
  require "redcarpet"
  require "coderay"

  class HTMLwithCoderay < Redcarpet::Render::HTML
    def block_code(code, language)
      if language.nil?
        language
      else
        language = language.split(':')[0]
      end

      case language.to_s
      when 'rb'
        lang = 'ruby'
      when 'yml'
        lang = 'yaml'
      when 'css'
        lang = 'css'
      when 'html'
        lang = 'html'
      when ''
        lang = 'md'
      else
        lang = language
      end

      CodeRay.scan(code, lang).div
    end
  end

  def markdown(text)
    html_render = HTMLwithCoderay.new(filter_html: true, hard_wrap: true)
    options = {
      filter_html: true, # 入力されたHTMLをエスケープする
      autolink: true,             # URLをリンクとして表示する
      space_after_headers: true,  # 見出しを作成する# と文字の間にスペースを要求
      no_intra_emphasis: true,    # foo_bar_bazのような文字列のとき強調しない
      fenced_code_blocks: true,   # コードブロックが使える
      disable_indented_code_blocks: true,
      tables: true,               # テーブルが記述できる
      hard_wrap: true,            # Markdown内の改行をHTMLの改行にする
      strikethrough: true,        # 2つの~で囲まれた箇所を取り消し線にできる
      highlight: true,            #==でハイライトを作成できる
      safe_links_only: true,      # 安全なリンクのみ生成する
      quote: true,                # 引用符を解析する
      lax_spacing: true,          # HTMLブロックはMarkdown標準のように空行で囲む必要はありません。
      superscript: true,          # 文字の後に上付き文字を解析する^
      underline: true,            # 下線の強調を強調する

    }
    markdown = Redcarpet::Markdown.new(html_render, options)
    markdown.render(text)
  end
end
