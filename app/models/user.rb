class User < ApplicationRecord

  validates :first_name, :middle_name, :last_name, presence: true
  validates :country, :phone_number, presence: true
       
  has_one_attached :image

  Country_options = ['USA', 'Canada', 'United Kingdom', 'Australia', 'Germany','Pakistan']   

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << ['FirstName','MiddleName','LastName','Email', 'Country']

      all.each do |user|
        csv << [
          user.first_name,
          user.middle_name,
          user.last_name,
          user.email,
          user.country
        ]
      end
    end
  end

  def self.search(attribute)
    where(
      'first_name LIKE :search OR last_name LIKE :search OR id = :id',
      search: "%#{attribute}%",
      id: attribute.to_i
    )
  end

  def self.sorted(column , direction)
    order("#{column} #{direction.upcase}")
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
