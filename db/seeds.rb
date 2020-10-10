# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


root_category = Category.create(name: 'text padre')
value = 'Producto'
index = 1
array_str = ['Musica', 'Pelulas', 'Avengers', 'himan', 'radio', 'canción', 'Futbol', 'religión', 'hoTel']
price = [2000, 1520, 3000, 6000, 1000]
rng = RandomNameGenerator.new

1..100.times do
  last = array_str.sample(random: SecureRandom)
  name = rng.compose(3)
  p = Product.create(price: price.sample(random: SecureRandom),
                     description: "Este es un producto muy interezante #{last}",
                     title: "#{value} #{index} #{name}")

  p.category_products.create(category_id: root_category.id)
  index += 1
end

value = 'item'
index = 1
price = [200, 300, 400, 500, 600]
child_category = Category.create(name: 'text hija', parent_id: root_category.id)

1..50.times do
  name = rng.compose(3)
  last = array_str.sample(random: SecureRandom)
  p = Product.create(price: price.sample(random: SecureRandom),
                     description: "Este es un producto muy interezante #{last}",
                     title: "#{value} #{index} #{name}")

  p.category_products.create(category_id: child_category.id)
  index += 1
end
