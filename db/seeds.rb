a = Account.create! :name => "Testfirma"
p1 = a.projects.create! :name => "Testprojekt 1"
p2 = a.projects.create! :name => "Testprojekt 2"
u = a.users.create! do |u|
  u.name = "Tester"
  u.email = "demo@example.com"
  u.password = "password"
end
