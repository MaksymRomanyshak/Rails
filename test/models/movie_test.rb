require 'test_helper'

class MovieTest < ActiveSupport::TestCase
    test 'should create movie with valid attributes' do
        movie = Movie.new(
            title: 'Test Movie',
            description: 'This is a test description.',
            year_of_creation: 2000,
            genres: ['action']
        )

        assert movie.save
    end

    test 'should not create movie without title' do
        movie = Movie.new(
            description: 'This is a test description.',
            year_of_creation: 2000,
            genres: ['action']
        )

        assert_not movie.save
        assert_includes movie.errors.full_messages, "Title can't be blank"
    end

    test 'should not create movie with duplicate title' do
        existing_movie = movies(:action_movie)
        movie = Movie.new(
            title: existing_movie.title,
            description: 'This is a test description.',
            year_of_creation: 2000,
            genres: ['action']
        )

        assert_not movie.save
        assert_includes movie.errors.full_messages, "Title has already been taken"
    end


      test "description can't be less than 10 characters long" do
        movie = Movie.new(
            title: 'Test Movie',
            description: 'Short',
            year_of_creation: 2000,
            genres: ['action']
        )
     
        assert_not movie.save
        assert_includes movie.errors.full_messages, "Description is too short (minimum is 10 characters)"
      end

      test 'should not create movie without year of creation' do
        movie = Movie.new(
            title: 'Test Movie',
            description: 'This is a test description.',
            genres: ['action']
        )

        assert_not movie.save
        assert_includes movie.errors.full_messages, "Year of creation can't be blank"
    end

      test 'should not create movie without a genre' do
        movie = Movie.new(
            title: 'Test Movie',
            description: 'This is a test description.',
            year_of_creation: 2000
        )

        assert_not movie.save
        assert_includes movie.errors.full_messages, "Genres At least one must be selected"
    end
end