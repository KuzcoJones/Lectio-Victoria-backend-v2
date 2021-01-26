class ReadingListBook < ApplicationRecord
  belongs_to :reading_list
  belongs_to :book
  validate :limit_currently_reading_list, on: :create

  def limit_currently_reading_list
   user = ReadingList.find(self.reading_list_id).user
   list = user.reading_list_books.filter {|l| l.type === 'CurrentBook' }
   if list.size >= 3 && self.type === 'CurrentBook'
    self.errors.add(:base, 'Only three books allowed in this list')
   end
  end

  def find_genre(desc)
    lower_desc = desc.downcase
    if lower_desc.include? "playbook"
     "Body"
    elsif lower_desc.include? "politic"
     "Reason"
    elsif lower_desc.include? "biograph"
     "People"
    elsif lower_desc.include? "phy"
     "Reason"
    else
     byebug
     "Default"
    end
   end

   def complete
    # this method creates a book from the external api
    @base = self.pages * 0.25
    byebug
   end
  
end
