require "spec_helper"

describe MoviesController do
  describe "Finding movies with the same director" do

    it "should call the movie method that searches by director" do
      movie = Movie.new
      movie.stub(:director).and_return('Ridley Scott')
      Movie.stub(:find).and_return(movie)
      Movie.should_receive(:find_all_by_director).with('Ridley Scott')
      get :find_similar, { :id => 1 }
    end

    it "should fill a list of movies and point out the director" do
      Movie.stub(:find).and_return(Movie.new)
      Movie.stub(:find_all_by_director).and_return(['Movie1', 'Movie2'])
      assigns(:movies)
      assigns(:director)
    end

    it "should render the find_similar view" do
      movie = Movie.new
      movie.stub(:director).and_return('Ridley Scott')
      Movie.stub(:find).and_return(movie)
      Movie.stub(:find_all_by_director).and_return(['Movie1', 'Movie2'])
      get :find_similar, {:id => 1}
      response.should render_template(:find_similar)
    end

    it "should return to the homepage when there's no director" do
      Movie.stub(:find).and_return(Movie.new)
      Movie.stub(:director).and_return(nil)
      Movie.stub(:title).and_return("My Movie")
      get :find_similar, {:id => 1}
      response.should redirect_to(movies_path)
    end
  end
end