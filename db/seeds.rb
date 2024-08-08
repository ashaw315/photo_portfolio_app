# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# db/seeds.rb

# Create Users
user1 = User.create!(
    name: 'Alice Smith',
    password: 'password123',
    password_confirmation: 'password123'
  )
  
  user2 = User.create!(
    name: 'Bob Johnson',
    password: 'password456',
    password_confirmation: 'password456'
  )
  
  # Create Portfolios
  portfolio1 = Portfolio.create!(
    title: 'Alice\'s Portfolio',
    description: 'A collection of Alice\'s best works',
    user: user1
  )
  
  portfolio2 = Portfolio.create!(
    title: 'Bob\'s Portfolio',
    description: 'A collection of Bob\'s best works',
    user: user2
  )
  
  # Create Articles
  article1 = Article.create!(
    title: 'The Rise of AI',
    content: 'An article about the impact of artificial intelligence on modern society.',
    user: user1,
    portfolio: portfolio1
  )
  
  article2 = Article.create!(
    title: 'The Future of Work',
    content: 'Exploring the future of work and how technology is changing our jobs.',
    user: user2,
    portfolio: portfolio2
  )
  
  # Create Photos
  photo1 = Photo.create!(
    title: 'Sunset in the Mountains',
    description: 'A beautiful sunset view from the mountains.',
    image_url: 'https://example.com/photo1.jpg',
    portfolio: portfolio1,
    article: article1,
    user: user1
  )
  
  photo2 = Photo.create!(
    title: 'City Skyline',
    description: 'A stunning city skyline at night.',
    image_url: 'https://example.com/photo2.jpg',
    portfolio: portfolio2,
    article: article2,
    user: user2
  )
  
  # Create Videos
  video1 = Video.create!(
    title: 'Introduction to Ruby on Rails',
    description: 'A comprehensive guide to getting started with Ruby on Rails.',
    video_url: 'https://example.com/video1.mp4',
    user: user1
  )
  
  video2 = Video.create!(
    title: 'Advanced React Techniques',
    description: 'A deep dive into advanced techniques for building React applications.',
    video_url: 'https://example.com/video2.mp4',
    user: user2
  )
  
  # Create Records
  record1 = Record.create!(
    content: 'Record related to the sunset photo.',
    user: user1,
    photo: photo1
  )
  
  record2 = Record.create!(
    content: 'Record related to the city skyline video.',
    user: user2,
    video: video2
  )
  
  # Create Comments
  comment1 = Comment.create!(
    content: 'Amazing photo! Thanks for sharing.',
    user: user2,
    commentable: photo1
  )
  
  comment2 = Comment.create!(
    content: 'Great article on AI. Very informative!',
    user: user1,
    commentable: article2
  )
  
  # Create Likes
  Like.create!(
    user: user1,
    likeable: photo2
  )
  
  Like.create!(
    user: user2,
    likeable: article1
  )

