class BooksController < ApplicationController
    before_action :find_book, only: [:show, :edit, :update, :destroy]
	#before_action :authenticate_user!, only: [:new, :edit]
    #defines index page
    def index
		if params[:category].blank?
            @books = Book.all.order("created_at DESC")
             @q = Book.ransack(params[:q])
             @books = @q.result(distinct: true)
		else
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
   def new
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
    
    def edit
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
        def book_params
            params.require(:book).permit(:category_id, :title, :description, :author, :links)
        end
        def find_book
            @book = Book.find(params[:id])
        end

end
