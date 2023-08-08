module LoginSupport
  def login(user)
    visit login_path
    fill_in 'ユーザー名', with: user.name
    fill_in 'パスワード', with: 'password'
    check 'ログイン情報を保持する'
    click_button 'ログイン'
  end
end
