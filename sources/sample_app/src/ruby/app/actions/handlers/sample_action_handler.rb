class SampleActionHandler < Fumoffu::Handler
  def initialize
    super
    @controllers[UIActions::SAMPLE_ACTION] = SampleActionController.new
  end

  def handleAction evt, action, caller
    if action == UIActions::SAMPLE_ACTION then
      # first we get the main panel
      component = component_by_name evt.getSource, "mainPanel"
      label     = component_child_by_name component, "myLabel"

      label.setText @controllers[UIActions::SAMPLE_ACTION].say_hello
    end
  end
end
