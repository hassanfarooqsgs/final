class Camp < ApplicationRecord

  validates :title, :location, :start_date, :end_date, presence: true
  validate :end_date_greater_than_start_date    

  def active?
    status == 'active'
  end

  def inactive?
    status == 'inactive'
  end

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << ['ID','Title','Location','Status', 'Date']

      all.each do |camp|
        csv << [
          camp.id,
          camp.title,
          camp.location,
          camp.status,
          camp.start_date,
          camp.end_date
        ]
      end
    end
  end
  
  def end_date_greater_than_start_date
    return unless start_date && end_date
    if end_date <= start_date
      errors.add(:end_date, "must be greater than start date")
    end
  end

  def self.search(attribute)
    where(
      'title LIKE :search OR location LIKE :search OR id = :id',
      search: "%#{attribute}%",
      id: attribute.to_i
    )
  end  
  
  def self.sorted(column , direction)
    order("#{column} #{direction.upcase}")
  end
   
end
