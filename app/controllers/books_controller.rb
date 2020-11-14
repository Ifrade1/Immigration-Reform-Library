class BooksController < ApplicationController
    before_action :find_book, only: [:show, :edit, :update, :destroy]
	#before_action :authenticate_user!, only: [:new, :edit]
    #defines index page
    def index
        @books = Book.all.order("created_at DESC")
    end
    def new
        @book = Book.new
    end
    def show
        
    end


    
    
    def create #for creating a new book for the page
        @book = Book.new(book_params)
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
            params.require(:book).permit(:title, :description, :author, :links)
        end
        def find_book
            @book = Book.find(params[:id])
        end
end
