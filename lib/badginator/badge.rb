class Badginator
  class Badge

    def self.setters(*method_names)
      method_names.each do |name|
        send :define_method, name do |*data|
          if data.length > 0
            instance_variable_set "@#{name}", data.first
          else
            instance_variable_get "@#{name}"
          end

        end
      end
    end

    setters :code, :name, :description, :condition, :disabled, :level, :image, :reward


    def build_badge(&block)
      instance_eval &block
      @code = @code.to_sym if @code
    end


  end
end
