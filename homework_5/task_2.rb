# frozen_string_literal: true

module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'

      if verb != 'GET' && verb != 'POST' && verb != 'PUT' && verb != 'DELETE'
        print "Wrong command! Please, try again \n"
      else
        action = nil

        if verb == 'GET'
          loop do
            print 'Choose action (index/show) / q to exit: '
            action = gets.chomp
            break if action == 'q' || action == 'index' || action == 'show'

            print "Wrong command! Please, try again \n" if action != 'index' && action != 'show'
          end
        end

        break if action == 'q' 
        action.nil? ? routes[verb].call : routes[verb][action].call
      end
    end
  end
end

class PostsController
  extend Resource

  def initialize
    @posts = ['Guten Morgen!', 'Guten Tag!', 'Guten Abend']
  end

  def index
    @posts.each_with_index do |post, index|
      puts "#{index}. #{post}\n"
    end
  end

  def show
    print "Enter post's id: "
    id = gets.chomp.to_i
    puts "#{id}. #{@posts[id]}\n"
  end

  def create
    print "Enter your new post: \n"
    text = gets.chomp
    @posts.push(text)
    last_id = @posts.size - 1
    puts "#{last_id}. #{@posts[last_id]}\n"
  end

  def update
    print "Enter post's id: "
    id = gets.chomp.to_i
    print "Enter new text: \n"
    text = gets.chomp
    @posts[id] = text
    puts "#{id}. #{@posts[id]}\n"
  end

  def destroy
    print "Enter post's id: "
    id = gets.chomp.to_i
    @posts.delete_at(id)
    print 'Your post has been deleted'
  end
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choice = gets.chomp

      case choice
      when '1'
        PostsController.connection(@routes['posts'])
      when 'q'
        break
      when '2'
        print "Unfortunately, this optionn is unavailable now. Try again later.\n"
      else
        print "Wrong option. Please, try again.\n"
      end
    end

    puts 'Goodbye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init
