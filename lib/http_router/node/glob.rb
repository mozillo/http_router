class HttpRouter
  class Node
    class Glob < Node
      def usuable?(other)
        other.class == self.class
      end

      def to_code
        "request.params << (globbed_params#{depth} = [])
          remaining_parts = request.path.dup
          until remaining_parts.empty?
            globbed_params#{depth} << URI.unescape(remaining_parts.shift)
            request.path = remaining_parts
            #{super}
          end
          request.path[0,0] = request.params.pop
          "
      end
    end
  end
end