Member.delete_all
Driver.delete_all

Member.create({
  email: "member@gmail.com",
  username: "member",
  password: "member"
})

Driver.create({
  email: "driver@gmail.com",
  password: "driver"
})