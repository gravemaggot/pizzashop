class AddProducts < ActiveRecord::Migration[6.0]
  def change
    Product.create(
      title: 'Peperoni',
      description: 'Пеперони',
      price: 14.88,
      size: 32,
      is_spicy: true,
      is_veg: false,
      is_best_offer: false,
      path_to_image: '/images/pep.jpg'
    )

    Product.create(
      title: 'Havaii',
      description: 'Гавайская',
      price: 14.88,
      size: 32,
      is_spicy: false,
      is_veg: false,
      is_best_offer: false,
      path_to_image: '/images/gav.jpg'
    )

    Product.create(
      title: 'Vegeterian',
      description: 'Веретерианская',
      price: 15,
      size: 28,
      is_spicy: false,
      is_veg: true,
      is_best_offer: false,
      path_to_image: '/images/pep.jpg'
    )
  end
end
