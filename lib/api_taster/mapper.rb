module ApiTaster
  class Mapper
    class << self
      def get(path, params = {})
        map_method(:get, path, params)
      end

      def post(path, params = {})
        map_method(:post, path, params)
      end

      def put(path, params = {})
        map_method(:put, path, params)
      end

      def delete(path, params = {})
        map_method(:delete, path, params)
      end

      private

      def map_method(method, path, params)
        route = Route.find_by_verb_and_path(method, path)

        if route.nil?
          Route.obsolete_definitions << {
            :verb   => method,
            :path   => path,
            :params => params
          }
        else
          Route.supplied_params[route[:id]] ||= []
          Route.supplied_params[route[:id]] << ApiTaster.global_params.merge(params)
        end
      end
    end
  end
end
