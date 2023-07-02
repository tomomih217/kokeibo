module ApplicationHelper
  def age_options
    options = []
    options.push('選択してください')
    options.push('出産前')
    options += (0..18).to_a.map{ |x| x.to_s + '才' }
  end
end
