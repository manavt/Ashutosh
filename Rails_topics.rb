Filter  - runs before, after and around to an action

before_action
after_action
around_action

Note : available only inside your controller.


Syntax :
  before_action do
    logc
  end


  or


  before_action :method_name


  def method_name
    logic
  end
