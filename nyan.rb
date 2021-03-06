require 'gosu'
class Window < Gosu::Window
  def initialize
    super(900, 550, false)
    self.caption = 'Nyan cat!'
    @background = Background.new(self)
    @cat = NyanCat.new(self)
    @avocado = Avocado.new(self)
    @score = 0
    @score_text = Gosu::Font.new(self, 'Arial', 72)
    @song = Gosu::Song.new(self, 'sounds/nyan.mp3')
    @song.play
  end

  def draw
    @background.draw
    @cat.draw
    @avocado.draw
    @score_text.draw("#{@score}", 0, 0, 1)
  end

  def update
    # @background.scroll
    @avocado.move

    @avocado.reset(self) if @avocado.x < 0

    if button_down? Gosu::KbUp
      @cat.move_up
    end

    if button_down? Gosu::KbDown
      @cat.move_down
    end

    if @cat.bumped_into? @avocado
      @score = @score + 1
      @avocado.reset(self)
    end
  end
end

class NyanCat
  def initialize(window)
    @sprites = Gosu::Image.new(window, 'images/teset.png', true)
    @x = 10
    @y = 200
    @width = @sprites.width
    @height = @sprites.height
  end

  def draw
    # sprite = @sprites[Gosu::milliseconds / 75 % @sprites.size]
    @sprites.draw(@x, @y, 1)
  end

  def bumped_into?(object)
    self_top = @y
    self_bottom = @y + @height
    self_left = @x
    self_right = @x + @width

    object_top = object.y
    object_bottom = object.y + object.height
    object_left = object.x
    object_right = object.x + object.width

    if self_top > object_bottom
      false
    elsif self_bottom < object_top
      false
    elsif self_left > object_right
      false
    elsif self_right < object_left
      false
    else
      true
    end
  end

  def move_up
    @y = @y - 5
  end

  def move_down
    @y = @y + 5
  end
end

class Avocado
  attr_accessor :x, :y, :width, :height
  def initialize(window)
    @sprite = Gosu::Image.new(window, 'images/margarita.png', true)
    @x = 100
    @y = 200
    @width = @sprite.width
    @height = @sprite.height
    reset(window)
  end

  def draw
    @sprite.draw(@x, @y, 1)
  end

  def reset(window)
    @y = Random.rand(window.height - @height)
    @x = window.width
  end

  def move
    @x = @x - 15
  end
end

class Background
	attr_accessor :x, :width
	def initialize(window)
    @background_image = Gosu::Image.new(window, "images/background.jpg", true)
    # @width = @first_image.width
    # @second_image = Gosu::Image.new(window, "images/background.jpg")
		# @first_x = 0
    # @second_x = @first_x + @width
    # @scroll_speed = 2
	end

	def draw
    @background_image.draw(0,0, 0)
    # @first_image.draw(@first_x, 0, 0)
    # @second_image.draw(@second_x, 0, 0)
	end

	# def scroll
  #   	@first_x = @first_x - @scroll_speed
  #   	@second_x = @second_x - @scroll_speed
  #   	if (@first_x < -@width)
  #     		@first_x = @width
  #     		@second_x = 0
  #   	elsif (@second_x < -@width)
  #     		@second_x = @width
  #     		@first_x = 0
  #   	end
	# end

end
Window.new.show
