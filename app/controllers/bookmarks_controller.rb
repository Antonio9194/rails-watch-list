class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

def create
  @list = List.find(params[:list_id])
  @bookmark = Bookmark.new(bookmark_params)
  @bookmark.list = @list

  if @bookmark.save
    redirect_to list_path(@list), notice: "Bookmark added!"
  else
    @bookmarks = @list.bookmarks.includes(:movie) # you need this line too
    render "lists/show", status: :unprocessable_entity
  end
end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    list = @bookmark.list
    @bookmark.destroy
    redirect_to list_path(list), notice: "Bookmark removed!"
  end

private 
  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
