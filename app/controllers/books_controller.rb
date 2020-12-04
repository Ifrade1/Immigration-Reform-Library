class BooksController < ApplicationController
    before_action :find_book, only: [:show, :edit, :update, :destroy]
	#before_action :authenticate_user!, only: [:new, :edit]
    #defines index page
    def index
        #index function.  #if no category is selected, then it dispalys all books, 
        #or all books that meet search parameters
		if params[:category].blank?
            @books = Book.all.order("created_at DESC")
             @q = Book.ransack(params[:q])
             @books = @q.result(distinct: true)
		else # if book category matches category selected, then it is displayed
			@category_id = Category.find_by(name: params[:category]).id
            @books = Book.where(:category_id => @category_id).order("created_at DESC")
        end
        
    end
    def search 
        @q = Book.ransack(params[:q])
        @books = @q.result(distinct: true)
    end
   def show
        
    end
   def new #creates a book, that belongs to a user and a category
		@book = current_user.books.build
		@categories = Category.all.map{ |c| [c.name, c.id] }
	end

	def create
		@book = current_user.books.build(book_params)
		@book.category_id = params[:category_id]

		if @book.save
			redirect_to root_path
		else
			render 'new'
		end
	end
    def destroy #for removing a particular book
		@book.destroy
		redirect_to root_path
    end
    
    def edit #categories have a name and id. so the book has the category id in a variables
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end
    def update
        if @book.update(book_params) #if book is updated successfully, show the books page
            redirect_to book_path(@book)
        
        else 
        render 'edit' #otherwise go to edit page again
        end
    end

    private
        def book_params #the book object can be created and added to database with just the title,
            # but can have other variables attached as well
            params.require(:book, :title).permit(:category_id,:description, :author, :links)
        end
        def find_book 
            @book = Book.find(params[:id])
        end

end
