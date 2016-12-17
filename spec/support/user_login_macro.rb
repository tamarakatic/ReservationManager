module UserLoginMacro
  def login_user(user_type)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[user_type]
      user = FactoryGirl.create(user_type)
      sign_in user
    end
  end
end
