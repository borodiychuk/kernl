a = Account.create! :name => "Testfirma", :email => "demo@example.com"
s1 = a.storages.create! :name => "Teststorage 1"
s2 = a.storages.create! :name => "Teststorage 2"
u = a.users.create! do |u|
  u.name = "Tester"
  u.email = "demo@example.com"
  u.password = "password"

Field::String.create! :storage => s1, :identifier => :name, :name => "Name"

end
