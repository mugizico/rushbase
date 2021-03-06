class Meetup < ActiveRecord::Base
  include HTTParty

  base_uri 'www.udacity.com'
  belongs_to :user
  has_many :meetup_members
  has_many :meetup_posts
  has_many :users, through: :meetup_members

  def member?(user)
    self.users.include?(user)
  end

  def self.create_meetups
    response = HTTParty.get("https://www.udacity.com/public-api/v0/courses")
    courses = response["courses"]

    courses.each do |course|
      self.find_or_create_by(
        name: course['title'],
        provider: "Udacity",
        bannmeeer_image: course['banner_image'],
        course_link: course['course_link']
        )
    end
  end
  def self.create_coursera_meetups
    coursera_res = HTTParty.get("https://api.coursera.org/api/catalog.v1/courses")
    courses = coursera_res["elements"]

    courses.each do |course|
      self.find_or_create_by(
        name: course['name'],
        provider: "Coursera"
      )
    end
  end

end
