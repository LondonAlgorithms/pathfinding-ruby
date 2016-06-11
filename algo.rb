class Pathfinder
  def initialize(n,m,matrix,x1,y1,x2,y2)
    @n = n
    @m = m
    @matrix = matrix
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  attr_reader :x1,:y1,:x2,:y2, :matrix, :n, :m

  def solve
    # Define the possible direction combos to go (TRICK)
    dx = [ 0,  0, -1,  1]
    dy = [ 1, -1,  0 , 0]

    # Cells to visit
    to_visit = []

    # Add initial start point to the list of nodes to visit
    to_visit << [x1,y1]

    # Until we have reached the destination or an empty array
    while !to_visit.empty?

      current_node = to_visit[0]
      current_x = current_node[0]
      current_y = current_node[1]

      (0..3).each do |i|
        new_x = current_x + dx[i]
        new_y = current_y + dy[i]

        # If the new position can be visited
        if in_bounds(new_x,new_y) && matrix[new_x][new_y] != -1
          # Compute the distance from the previous node
          new_distance = matrix[current_x][current_y] + 1
          if matrix[new_x][new_y] == 0
            # Add the distance to the matrix
            matrix[new_x][new_y] = new_distance
            # Add the node to the to_visit array
            to_visit << [new_x,new_y]
          end
        end
      end
      to_visit.shift
    end

    matrix[x2][y2]
  end

  def in_bounds(x,y)
    0 <= x && 0 <= y && x < n && y < m
  end
end
