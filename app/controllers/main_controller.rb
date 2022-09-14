class MainController < ApplicationController
    skip_before_action :verify_authenticity_token
    $num = 0;
    $subject = []
    $score = []
    $isRoot = false
    $check = []
    $editID = -1
    def main
        $num = 0
        render "index"
    end
    def select
        $num = params[:number].to_i;
        $isRoot = true
        $check = []
        redirect_to "/main/test"
    end
    def test
        @r = $isRoot
        @n = $num;
        @c = $check
        if $num != 0
            render "main"
            $check = []
        else
            redirect_to "/"
        end
    end
    def submit
        $isRoot = false
        $subject  = []
        $subject = []
        if params[:num] == ""
            redirect_to "/"
        else
            $name = []
            $score = []
            @n = params[:num].to_i
            $global_num = @n
            @r = $isRoot
            nextp = true
            for i in 1..$num do
              if params["sub#{i}"].blank? or params["scr#{i}"].blank?
                nextp = false
                $check.append(false)
              else
                $check.append(true)
                $subject.append(params["sub#{i}"])
                $score.append(params["scr#{i}"].to_f)
              end
            end
            if(nextp == false)
                redirect_to "/main/test"
            else
                redirect_to "/result"
            end
        end
    end

    def result
        @max_sub = "none"
        @max_all = 0.0
        @sum = 0.0
        for i in 1..$num do
          student = Student.new
          student.name = $subject[i-1]
          student.score = $score[i-1]
          student.save
          @sum += $score[i-1]
          if(@max_all < $score[i-1])
            @max_all = $score[i-1]
            @max_sub = $subject[i-1]
          end
        end
        render "result"
    end

    def showAll
        $editID = -1
        redirect_to "/score/list"
    end

    def scoreList
        @allStudent = Student.all
        @max_subject = ""
        @max_score = 0.0
        @sum = 0.0
        for e in @allStudent do
            if @max_score < e.score
                @max_score = e.score
                @max_subject = e.name
            end
        @sum += e.score
        end
        render "scoreList"
    end

    def add
        redirect_to "/"
    end

    def delete
        Student.destroy_by(id: params[:id])
        redirect_to "/score/list"
    end
        
    def edit
        $editID = params[:id]
        redirect_to "/score/edit"
    end

    def editScore
        if($editID == -1)
            redirect_to "/score/list"
        else
            @id = $editID
            @name = Student.find(@id).name
            @score = Student.find(@id).score
            render "edit"
        end
    end

    def confirmEdit
        @s = Student.find($editID)
        @s.name = params[:name]
        @s.score = params[:score].to_f
        @s.save!
        redirect_to controller: 'main', action: 'showAll'
        $editID = -1
    end
end