class User < ApplicationRecord
     
    has_one_attached :image

  
  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << ['FirstName','MiddleName','LastName','Email', 'Country']  # Add column headers

      all.each do |user|  # Iterate over the users
        csv << [user.first_name, user.middle_name,user.last_name,user.email, user.country]  # Add user data to CSV
      end
    end
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end