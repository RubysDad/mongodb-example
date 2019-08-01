class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  # include Mongoid::Versioning

  field :name, type: String
  field :price, type: BigDecimal
  field :released_on, type: Date
  field :_id, type: String, default: ->{ name.to_s.parameterize } # to have a slug name instead of long id number for show action

  validates_presence_of :name

  embeds_many :reviews # all the data is there with the one document(Product)
  # has_many :reviews # if you want to be able to create Reviews on their own
end

# include Mongoid::Timestamps gives created_at and updated_at attributes
# include Mongoid::Paranoia is for soft deletes, it won't actually delete the record in the database

# some basic queries
# Product.lte(price: 40)
# Product.lte(price: 40).first
# Product.lte(price: 40).gt(released_at: 1.month.ago)
#
# p = Product.first
# p.reviews.create! content: "Great Review!"
# p.reviews.size => 1
# Review.count => 0 because we are doing embeds_many
#
# To use Paranoia
# p = Product.first
# p.destroy
# Product.count => 2
# p.restore
# Product.count => 3

# because of the :_id attribute, you need to have the name attribute set and not blank when you create the object otherwise the _id is blank and you can't reset it
# ex.
#
# p = Product.new
# p.name = "foobar"
# p._id => ""
