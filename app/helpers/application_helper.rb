module ApplicationHelper
  def critic_score_to_icon(score)
    case score
    when 'Certified Fresh'
      'certified.png'
    when 'Fresh'
      'tomato.png'
    when 'Rotten'
      'rotten.png'
    end
  end

  def audience_score_to_icon(score)
    case score
    when 'Upright'
      'popcorn.png'
    when 'Spilled'
      'spilled-popcorn.png'
    end
  end
end
