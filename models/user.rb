class User
  attr_reader :id, :name
  
  def initialize(options)
    @id = options["id"]
    @name = options["name"]
  end
  
  # Returns a single User object.
  def self.find(u_id)
    result = DATABASE.execute("SELECT * FROM users WHERE id = #{u_id}")[0]
    
    self.new(result)
  end
  
  # Adds a 'like' from this user for a given post.
  def like_post(post_id)
    query = "INSERT INTO likes (user_id, post_id) VALUES (#{id}, #{post_id})"
    DATABASE.execute(query)
    return true
  end
  
  def liked_post?(post_id)
    query = "SELECT COUNT(*) AS num_likes FROM likes WHERE post_id = #{post_id} AND user_id = #{id}"
    result = DATABASE.execute(query)[0]
    result["num_likes"].to_i > 0
  end
end