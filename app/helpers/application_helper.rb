module ApplicationHelper
  def matches_made
    return nil unless user_signed_in?

    "<span class='label label-pill label-danger'>#{current_user.matches.made.count}</span>" if current_user.matches.made.any?
  end

  def markdownify(content)
    pipeline_context = { gfm: true, asset_root: "localhost:3000/images"}
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::RougeFilter,
      #HTML::Pipeline::EmojiFilter,
      HTML::Pipeline::SyntaxHighlightFilter,
      HTML::Pipeline::SanitizationFilter,
    ], pipeline_context
    pipeline.call(content)[:output].to_s.html_safe
  end
end
