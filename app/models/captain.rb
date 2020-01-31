class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: { name: "Catamaran" })
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: { name: "Sailboat" }).distinct
    # This is pretty close to Ruby's .uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: { name: "Motorboat" })
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
    # The second half of this after the comma, is just what goes in place of the ?
    # self.sailors.pluck(:id) >> Give me an array of sailor IDs
    # So give me everything where the ID is not in this list
  end
end
