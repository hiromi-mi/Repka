# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
root = User.create!(name:  "Example User",
             power: 5,
             password:              "foobar",
             password_confirmation: "foobar")

shiketai = []
3.times do |n|
  name  = Faker::Name.name
  password = "password"
  shiketai.push(User.create!(name:  name,
               power: 2,
               password:              password,
               password_confirmation: password))
end

5.times do |n|
  name  = Faker::Name.name
  password = "password"
  User.create!(name:  name,
               power: 1,
               password:              password,
               password_confirmation: password)
end

titles = ['地球科学', '天文学', '解析学基礎', '統計学基礎', '位相幾何学',
'古典力学', '電磁気学', '熱力学', '量子力学', '無機化学',
'有機化学', '生物学', '植物学', '農学', '生理学',
'解剖学', '神経解剖学', '組織学', '微生物学', '病理学',
'薬理学', '英語', 'エスペラント', '朝鮮語', 'デンマーク語',
'ドイツ語', '日本語', 'フランス語', 'ラテン語', '法学',
'経済学', '地理学', '心理学', '哲学', '日本史',
'中国史', '世界史', '漢詩', '神学','比較神話学']
kind = ['test', 'report', 'exam', 'note']
5.times do |i|
  root.pieces.create!(title: titles[rand(titles.size)],
                      teacher: Faker::Name.name,
                      year: rand(1950..2100),
                      kind: kind[rand(kind.size)],
                      data: Faker::Internet.url)
  shiketai.each do |user|
    user.pieces.create!(title: titles[rand(titles.size)],
                        teacher: Faker::Name.name,
                        year: rand(1950..2100),
                        kind: kind[rand(kind.size)],
                        data: Faker::Internet.url)
  end
end
