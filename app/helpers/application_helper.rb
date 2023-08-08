module ApplicationHelper
  def age_options
    options = []
    options.push('選択してください')
    options.push('出産前')
    options += (0..18).to_a.map { |x| x.to_s + '才' }
  end

  def living_alone_funds_options
    options = []
    options.push('選択してください')
    options.push('仕送りの予定はない')
    options += (1..20).map { |x| x.to_s + '万円' }
  end
end
