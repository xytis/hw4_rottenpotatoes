require 'spec_helper'

describe MoviesController do
  describe 'find movies with the same director' do
    before :each do
      @movie1 = Movie.new(:title => "Movie1", :director => "Director")
      @movie2 = Movie.new(:title => "Movie2", :director => "Director")
      @movie3 = Movie.new(:title => "Movie3", :director => nil)
      @results = [@movie1, @movie2]
    end
    it 'should check if given movie has a director' do
      Movie.should_receive(:find).with("3").and_return(@movie3)
      get :similar, {:id => 3}
    end
    it 'should call the model method that performs similar movies search' do
      Movie.stub(:find).and_return(@movie1)
      Movie.should_receive(:find_similar).with("1", :director, "Director").and_return(@results)
      get :similar, {:id => 1}
    end
    it 'should select the similar template for rendering' do
      Movie.stub(:find).and_return(@movie1)
      Movie.stub(:find_similar).and_return(@results)
      get :similar, {:id => 1}
      response.should render_template('similar')
    end
    it 'should make the similar movies results available to that template' do
      Movie.stub(:find).and_return(@movie1)
      Movie.stub(:find_similar).and_return(@results)
      get :similar, {:id => 1}
      assigns(:movies).should == @results
    end
  end
end