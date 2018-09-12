## SIMPLIFIED GO-RIDE WEB APPS

Aplikasi berbasis web yang merupakan versi simple dari aplikasi GO-RIDE pada GOJEK. Aplikasi ini memungkinkan orang untuk melakukan order dengan cara user menginput lokasi penjemputan dan lokasi tujuan yang ingin dituju, dan nanti aplikasi akan mencari driver terdekat yang akan menerima order. Jika driver menerima order tersebut, maka driver akan diassign ke order tersebut dan driver akan menjemput dan mengantar user yang mengorder tersebut sesuai dengan order yang dilakukan.

---

## GETTING STARTED

Untuk menjalankan project ini, akan dibutuhkan ruby dan framework rails

Ruby version: 2.5.1  
Rails version: 5.2.1

Setelah clone project ke local machine, kita perlu mendownload dependency yang dibutuhkan project agar dapat berjalan.

`bundle install`

Lalu lakukan database migration

`rails db:migrate`

Setelah database terbentuk, isi data ke database

`rails db:seed`

Lalu kita dapat menjalankan server rails di dengan

`rails server`

Atau untuk menjalankan server rails di port tertentu

`rails server -p <port>`

---

## RUNNING THE TEST

Untuk menjalankan testnya, dapat dengan meng execute command

`rspec --format documentation`

---