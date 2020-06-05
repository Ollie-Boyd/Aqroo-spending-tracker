require_relative('./sql_runner')
require_relative('./transaction')
require_relative('./sql_runner')
require_relative('./category')
require_relative('./fake_today')
require_relative('./user')
require_relative('./merchant')


user_ollie = User.new({'first_name' => 'Ollie', 'last_name' => 'Boyd', 'savings_goal' => 40.00, 'monthly_income' =>1200.00, 'email' => 'ollie@boyd.co.uk' })


category_eating_out = Category.new({'name' => 'Eating out', 'icon' => 'eating_out.svg', 'css_colour' => {'1' => '#f5d451', '2' => '#40fff6'}})
category_entertainment = Category.new({'name' => 'Entertainment', 'icon' => 'entertainment.svg', 'css_colour' => {'1' => '#f5d451', '2' => '#40fff6'}})
category_general = Category.new({'name' => 'General', 'icon' => 'general.svg', 'css_colour' => {'1' => '#f5d451', '2' => '#40fff6'}})
category_shopping = Category.new({'name' => 'Shopping', 'icon' => 'shopping.svg', 'css_colour' => {'1' => '#f5d451', '2' => '#40fff6'}})
category_holidays = Category.new({'name' => 'Holidays', 'icon' => 'holidays.svg', 'css_colour' => {'1' => '#f5d451', '2' => '#40fff6'}})
category_groceries = Category.new({'name' => 'Groceries', 'icon' => 'groceries.svg', 'css_colour' => {'1' => '#f5d451', '2' => '#40fff6'}})
category_transport = Category.new({'name' => 'Transport', 'icon' => 'transport.svg', 'css_colour' => {'1' => '#f5d451', '2' => '#40fff6'}})
category_bills = Category.new({'name' => 'Bills', 'icon' => 'bills.svg', 'css_colour' => {'1' => '#f5d451', '2' => '#40fff6'}})


:name, :icon, :css_colour
