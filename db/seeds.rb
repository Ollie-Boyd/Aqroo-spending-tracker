require_relative('../models/sql_runner')
require_relative('../models/transaction')
require_relative('../models/sql_runner')
require_relative('../models/category')
require_relative('../models/fake_today')
require_relative('../models/user')
require_relative('../models/merchant')


user_charlie = User.new({'first_name' => 'Charlie', 'last_name' => 'Watson', 'savings_goal' => 40.01, 'monthly_income' =>1500.50, 'email' => 'ollie@boyd.co.uk' })
user_charlie.save()

category_eating_out = Category.new({'name' => 'Eating out', 'icon' => 'eating-out.svg', 'css_colour_1' => '#39ECEC', 'css_colour_2' => '#40fff6'})
category_entertainment = Category.new({'name' => 'Entertainment', 'icon' => 'entertainment.svg', 'css_colour_1' => '#72DDF7', 'css_colour_2' => '#40fff6'})
category_general = Category.new({'name' => 'General', 'icon' => 'general.svg', 'css_colour_1' => '#FFF181', 'css_colour_2' => '#40fff6'})
category_shopping = Category.new({'name' => 'Shopping', 'icon' => 'shopping.svg', 'css_colour_1' => '#68EDC6', 'css_colour_2' => '#40fff6'})
category_holidays = Category.new({'name' => 'Holidays', 'icon' => 'holidays.svg', 'css_colour_1' => '#FF7C49', 'css_colour_2' => '#40fff6'})
category_groceries = Category.new({'name' => 'Groceries', 'icon' => 'groceries.svg', 'css_colour_1' => '#B0FF92', 'css_colour_2' => '#40fff6'})
category_transport = Category.new({'name' => 'Transport', 'icon' => 'transport.svg', 'css_colour_1' => '#F7579B', 'css_colour_2' => '#40fff6'})
category_bills = Category.new({'name' => 'Bills', 'icon' => 'bills.svg', 'css_colour_1' => '#CECAFF', 'css_colour_2' => '#40fff6'})

category_eating_out.save() #1
category_entertainment.save() #2
category_general.save() #3
category_shopping.save() #4
category_holidays.save() #5
category_groceries.save() #6
category_transport.save() #7
category_bills.save() #8

merchant_mcdonalds = Merchant.new({'name' => "McDonalds"})
merchant_easyjet = Merchant.new({'name' => "easyJet"})
merchant_cult_coffee = Merchant.new({'name' => "Cult Coffee"})
merchant_amazon = Merchant.new({'name' => "Amazon"})
merchant_asos = Merchant.new({'name' => "Asos"})
merchant_francos = Merchant.new({'name' => "Franco's Fish"})
merchant_esso = Merchant.new({'name' => "Esso"})
merchant_superdrug = Merchant.new({'name' => "Superdrug"})
merchant_lidl = Merchant.new({'name' => "Lidl"})
merchant_tesco = Merchant.new({'name' => "Tesco"})
merchant_booking = Merchant.new({'name' => "Booking.com"})
merchant_topshop = Merchant.new({'name' => "Topshop"})
merchant_hnm = Merchant.new({'name' => "H&M"})
merchant_tk_maxx = Merchant.new({'name' => "TK Maxx"})
merchant_gap = Merchant.new({'name' => "Gap"})
merchant_ebay = Merchant.new({'name' => "Ebay"})
merchant_spotify = Merchant.new({'name' => "Spotify"})
merchant_decathlon = Merchant.new({'name' => "Decathlon"})
merchant_netflix = Merchant.new({'name' => "Netflix"})
merchant_kfc = Merchant.new({'name' => "KFC"})
merchant_dishoom = Merchant.new({'name' => "Dishoom"})
merchant_southern_pub = Merchant.new({'name' => "Southern Pub"})
merchant_royal_dick = Merchant.new({'name' => "Royal Dick"})
merchant_lothian_buses = Merchant.new({'name' => "Lothian Buses"})
merchant_lner = Merchant.new({'name' => "LNER"})
merchant_homebase = Merchant.new({'name' => "Homebase"})
merchant_bnq = Merchant.new({'name' => "B&Q"})
merchant_dog_walker = Merchant.new({'name' => "Dog walker"})
merchant_charlie_miller= Merchant.new({'name' => "Charlie Miller"})
merchant_tanz = Merchant.new({'name' => "Tanz"})
merchant_parking_meter = Merchant.new({'name' => "Parking meter"})
merchant_car_wash = Merchant.new({'name' => "Car wash"})
merchant_landlord = Merchant.new({'name' => "Landlord"})
merchant_bulb = Merchant.new({'name' => "Bulb energy"})
merchant_vue = Merchant.new({'name' => "Vue cinema"})
merchant_alien = Merchant.new({'name' => "Alien Block"})
merchant_aliexpress = Merchant.new({'name' => "AliExpress"})

merchant_mcdonalds.save() #1
merchant_easyjet.save() #2
merchant_cult_coffee.save() #3
merchant_amazon.save() #4
merchant_asos.save() #5
merchant_francos.save() #6
merchant_esso.save() #7
merchant_superdrug.save() #8
merchant_lidl.save() #9
merchant_tesco.save() #10
merchant_booking.save() #11
merchant_topshop.save() #12
merchant_hnm.save() #13
merchant_tk_maxx.save() #14
merchant_gap.save() #15
merchant_ebay.save() #16
merchant_spotify.save() #17
merchant_decathlon.save() #18
merchant_netflix.save() #19
merchant_kfc.save() #20
merchant_dishoom.save() #21
merchant_southern_pub.save() #22
merchant_royal_dick.save() #23
merchant_lothian_buses.save() #24
merchant_lner.save() #25
merchant_homebase.save() #26
merchant_bnq.save() #27
merchant_dog_walker.save() #28
merchant_charlie_miller.save() #29
merchant_tanz.save() #30
merchant_parking_meter.save() #31
merchant_car_wash.save() #32
merchant_landlord.save() #33
merchant_bulb.save() #34
merchant_vue.save() #35
merchant_alien.save() #36
merchant_aliexpress.save() #37

# category_eating_out.save() #1
# category_entertainment.save() #2
# category_general.save() #3
# category_shopping.save() #4
# category_holidays.save() #5
# category_groceries.save() #6
# category_transport.save() #7
# category_bills.save() #8


transaction_month_5_day_1_landlord = Transaction.new({'user_id' => '1', 'transaction_date' => '1 May 2020', 'merchant_id' => '33', 'category_id' => '8', 'amount' => '350.00'})
transaction_month_5_day_1_bulb = Transaction.new({'user_id' => '1', 'transaction_date' => '1 May 2020', 'merchant_id' => '34', 'category_id' => '8', 'amount' => '40.12'})
transaction_month_5_day_2_spotify = Transaction.new({'user_id' => '1', 'transaction_date' => '2 May 2020', 'merchant_id' => '17', 'category_id' => '8', 'amount' => '15.00'})
transaction_month_5_day_3_topshop = Transaction.new({'user_id' => '1', 'transaction_date' => '3 May 2020', 'merchant_id' => '12', 'category_id' => '4', 'amount' => '33.27'})
transaction_month_5_day_4_lothian = Transaction.new({'user_id' => '1', 'transaction_date' => '4 May 2020', 'merchant_id' => '24', 'category_id' => '7', 'amount' => '2.40'})
transaction_month_5_day_5_charlie = Transaction.new({'user_id' => '1', 'transaction_date' => '5 May 2020', 'merchant_id' => '29', 'category_id' => '4', 'amount' => '56.00'})
transaction_month_5_day_5_dog = Transaction.new({'user_id' => '1', 'transaction_date' => '5 May 2020', 'merchant_id' => '28', 'category_id' => '8', 'amount' => '10.00'})
transaction_month_5_day_5_ebay = Transaction.new({'user_id' => '1', 'transaction_date' => '5 May 2020', 'merchant_id' => '16', 'category_id' => '4', 'amount' => '94.00'})
transaction_month_5_day_7_tanz = Transaction.new({'user_id' => '1', 'transaction_date' => '7 May 2020', 'merchant_id' => '30', 'category_id' => '3', 'amount' => '15.00'})
transaction_month_5_day_7_tk = Transaction.new({'user_id' => '1', 'transaction_date' => '7 May 2020', 'merchant_id' => '14', 'category_id' => '4', 'amount' => '22'})
transaction_month_5_day_8_esso = Transaction.new({'user_id' => '1', 'transaction_date' => '8 May 2020', 'merchant_id' => '7', 'category_id' => '7', 'amount' => '24.09'})
transaction_month_5_day_9_alien = Transaction.new({'user_id' => '1', 'transaction_date' => '9 May 2020', 'merchant_id' => '36', 'category_id' => '2', 'amount' => '12'})
transaction_month_5_day_9_tesco = Transaction.new({'user_id' => '1', 'transaction_date' => '9 May 2020', 'merchant_id' => '10', 'category_id' => '6', 'amount' => '54.72'})
transaction_month_5_day_9_vue = Transaction.new({'user_id' => '1', 'transaction_date' => '9 May 2020', 'merchant_id' => '35', 'category_id' => '2', 'amount' => '5'})
transaction_month_5_day_9_lidl = Transaction.new({'user_id' => '1', 'transaction_date' => '9 May 2020', 'merchant_id' => '9', 'category_id' => '6', 'amount' => '122,13'})
transaction_month_5_day_10_kfc = Transaction.new({'user_id' => '1', 'transaction_date' => '10 May 2020', 'merchant_id' => '20', 'category_id' => '1', 'amount' => '8.99'})
transaction_month_5_day_11_dick = Transaction.new({'user_id' => '1', 'transaction_date' => '11 May 2020', 'merchant_id' => '23', 'category_id' => '1', 'amount' => '14.30'})
transaction_month_5_day_24_lner = Transaction.new({'user_id' => '1', 'transaction_date' => '24 May 2020', 'merchant_id' => '25', 'category_id' => '7', 'amount' => '9.00'})
transaction_month_5_day_27_dishoom = Transaction.new({'user_id' => '1', 'transaction_date' => '27 May 2020', 'merchant_id' => '21', 'category_id' => '1', 'amount' => '32.55'})
transaction_month_5_day_30_easyjet = Transaction.new({'user_id' => '1', 'transaction_date' => '30 May 2020', 'merchant_id' => '2', 'category_id' => '5', 'amount' => '199.95'})


transaction_month_6_day_1_landlord = Transaction.new({'user_id' => '1', 'transaction_date' => '1 June 2020', 'merchant_id' => '33', 'category_id' => '8', 'amount' => '350.00'})
transaction_month_6_day_1_bulb = Transaction.new({'user_id' => '1', 'transaction_date' => '1 June 2020', 'merchant_id' => '34', 'category_id' => '8', 'amount' => '40.12'})
transaction_month_6_day_2_spotify = Transaction.new({'user_id' => '1', 'transaction_date' => '2 June 2020', 'merchant_id' => '17', 'category_id' => '8', 'amount' => '15.00'})
transaction_month_6_day_3_topshop = Transaction.new({'user_id' => '1', 'transaction_date' => '3 June 2020', 'merchant_id' => '12', 'category_id' => '4', 'amount' => '33.27'})
transaction_month_6_day_4_lothian = Transaction.new({'user_id' => '1', 'transaction_date' => '4 June 2020', 'merchant_id' => '24', 'category_id' => '7', 'amount' => '2.40'})
transaction_month_6_day_5_tesco = Transaction.new({'user_id' => '1', 'transaction_date' => '5 June 2020', 'merchant_id' => '10', 'category_id' => '6', 'amount' => '54.72'})
transaction_month_6_day_5_charlie = Transaction.new({'user_id' => '1', 'transaction_date' => '6 June 2020', 'merchant_id' => '29', 'category_id' => '4', 'amount' => '56.00'})
transaction_month_6_day_7_tanz = Transaction.new({'user_id' => '1', 'transaction_date' => '7 June 2020', 'merchant_id' => '30', 'category_id' => '3', 'amount' => '15.00'})
transaction_month_6_day_7_tk = Transaction.new({'user_id' => '1', 'transaction_date' => '7 June 2020', 'merchant_id' => '14', 'category_id' => '4', 'amount' => '22'})
transaction_month_6_day_8_esso = Transaction.new({'user_id' => '1', 'transaction_date' => '8 June 2020', 'merchant_id' => '7', 'category_id' => '7', 'amount' => '24.09'})
transaction_month_6_day_9_alien = Transaction.new({'user_id' => '1', 'transaction_date' => '9 June 2020', 'merchant_id' => '36', 'category_id' => '2', 'amount' => '12'})
transaction_month_6_day_9_vue = Transaction.new({'user_id' => '1', 'transaction_date' => '9 June 2020', 'merchant_id' => '35', 'category_id' => '2', 'amount' => '5'})
transaction_month_6_day_9_lidl = Transaction.new({'user_id' => '1', 'transaction_date' => '9 June 2020', 'merchant_id' => '9', 'category_id' => '6', 'amount' => '122,13'})

transaction_month_5_day_1_landlord.save()
transaction_month_5_day_1_bulb.save()
transaction_month_5_day_2_spotify.save()
transaction_month_5_day_3_topshop.save()
transaction_month_5_day_4_lothian.save()
transaction_month_5_day_5_charlie.save()
transaction_month_5_day_5_dog.save()
transaction_month_5_day_5_ebay.save()
transaction_month_5_day_7_tanz.save()
transaction_month_5_day_7_tk.save()
transaction_month_5_day_8_esso.save()
transaction_month_5_day_9_alien.save()
transaction_month_5_day_9_tesco.save()
transaction_month_5_day_9_vue.save()
transaction_month_5_day_9_lidl.save()
transaction_month_5_day_10_kfc.save()
transaction_month_5_day_11_dick.save()
transaction_month_5_day_24_lner.save()
transaction_month_5_day_27_dishoom.save()
transaction_month_5_day_30_easyjet.save() 


transaction_month_6_day_1_landlord.save()
transaction_month_6_day_1_bulb.save()
transaction_month_6_day_2_spotify.save()
transaction_month_6_day_3_topshop.save()
transaction_month_6_day_4_lothian.save()
transaction_month_6_day_5_tesco.save()
transaction_month_6_day_5_charlie.save()
transaction_month_6_day_7_tanz.save()
transaction_month_6_day_7_tk.save()
transaction_month_6_day_8_esso.save()
transaction_month_6_day_9_alien.save()
transaction_month_6_day_9_vue.save()
transaction_month_6_day_9_lidl.save()


