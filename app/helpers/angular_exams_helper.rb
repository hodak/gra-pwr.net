module AngularExamsHelper
  def exams_index_url
    "#{exams_url}#/"
  end

  def new_exam_url
    "#{exams_url}#/new"
  end

   def login_error_url
    "#{login_url}#/?error"
  end
end
