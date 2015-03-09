class Api::V1::CoursesController < ApplicationController
  before_action :authenticate_user!, only: [:create,:update, :destroy]

  def index
    @courses = Course.all
    render json: @courses
  end

  def show
    @course = Course.find(params[:id])
    render json: @course
  end

  def create
    @organization = Organization.find(params[:organization_id])
    instructor = Instructor.find_by(id: current_user.id)
    if instructor.present?
      @course = instructor.courses.build(course_params)
      @course.organization_id = @organization.id

      respond_to do |format|
        if @course.save
          format.json { render json: @course, status: :created }
        else
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update(@course)
        format.json { render :show, status: :ok, location: @course }
      else
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course = Course.find(params[:id])

    respond_to do |format|
      if  @course.destroy
        format.json { render json: @course }
      else
        format.json { render json: @course.errors }
      end
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :organization_id, :instructor_id)
  end
end