require 'sinatra'
tasks = []
set bind:'0.0.0.0'
id=0
	class Task 

		attr_accessor :name,:completed,:id,:important,:urgent
		
		def initialize name,id

			@name=name
			@completed = false
			@important = true
			@urgent = true
			@id=id

		end

		def toggle_task
			@completed=!@completed
		end

		def importance_toggle
			@important=!@important
		end

		def urgent_toggle
			@urgent=!@urgent
		end

	end

get '/' do
	erb :tasks, locals: {:tasks =>tasks}
end

post '/add_task' do
	t=Task.new params[:task],id
	tasks << t
	id=id+1
	redirect '/'
end

post '/task_done' do
	temp=nil
	tasks.each do |task|
		if task.id==params[:id].to_i
			temp=task
			break
		end	
	end
	
	if 	temp
	    temp.toggle_task
	end
	redirect '/'
end

post '/toggle_important' do
	temp=nil
	tasks.each do |task|
		if task.id==params[:task_important].to_i
			temp=task
			break
		end	
	end
	
	if 	temp
	    temp.importance_toggle
	end
	redirect '/'
end

post '/toggle_urgent' do
	temp=nil
	tasks.each do |task|
		if task.id==params[:task_urgent].to_i
			temp=task
			break
		end	
	end
	
	if 	temp
	    temp.urgent_toggle
	end
	redirect '/'
end
