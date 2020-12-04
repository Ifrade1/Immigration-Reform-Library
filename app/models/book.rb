#this is the model page for the books. A book has to belog to a user and category
#but the category does not need to have books
class Book < ApplicationRecord
    belongs_to :user
    belongs_to :category
end
