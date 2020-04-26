module ApplicationHelper

  def pluralize_comments(comments)
    if comments.count == 1
      "#{comments.count} comment"
    else
      "#{comments.count} comments"
    end
    
  end

  def pluralize_tips(tips)
    if tips.count == 1
      "#{tips.count} tip"
    else
      "#{tips.count} tips"
    end
    
  end
end
