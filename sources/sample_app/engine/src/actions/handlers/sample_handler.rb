class SampleHandler < Fumoffu::Handler
    def initialize
      super
      @controller = SampleController.new
    end


    def handleAction evt, action, caller
      # sample of use
      if action == UIActions::SAMPLE_ACTION then
          component = component_by_name evt.getSource, "myPanel"
          label     = component_child_by_name component, "myLabel"
          label.setText @controller.say_hello
          return true
      end
      return false
    end
end
