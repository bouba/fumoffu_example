# Fumoffu sample app

This is a sample app that use the fumoffu gem in development.  
I'll try to explain all the step required to setup your development environment based on my IDE.  

The following sample has been setup with [Netbeans][nb]

# Description

You can get sources of the framework [here](http://github.com/bouba/fumoffu) 

The following step will describe the step taken to setup a new application. 

## Step 1: Generate the application skeleton

Open a terminal and use the following command line to generate the skeleton 

      fumoffu -i your_app_name 

This will generate the skeleton and retrieve the bundle dependencies for packaging
of your application.

NB: All bundle gems are located in the ./engine/lib/ruby folder we need to download
them in order to be able to compile them in a jar when we package the application. Note
that not all gem will be able to compile with JRuby (some may require 'adjustement' so 
it may compile and be used).

## Step 2: Retrieving JRuby jar

In order to use JRuby when we package our application we need to retrieve the a JRuby jar
You may use the following command line in order to check if your application has the
dependency: 

        fumoffu -d 

You do not have it just follow the instruction given by the command line.

## Step 3: Setting up the Interface

In fumoffu, the default interface framework used is Java Swing. If you want to use other Java framework 
you may want to change the configuration information in the "build_configuration" file. To import your
framework JAR when packaging the application. 

This step mainly depends on the IDE you use to create your application interface. 
When you setup your interface project just make sure that your files are references are: 

* sources   => *your_project_path/interface/src* 
* test      => *your_project_path/interface/test*
* lib       => *your_project_path/interface/lib*
* resources => *your_project_path/interface/resources*

*resources* may be media, video anything resources needed by your interface.


## Step 4: Implementing the interface

In your interface MainView.

Make sure to add a constructor that takes an ActionManager:

      private ActionManager am;
      
      public MainView(ActionManager am) {
          this();
          this.am = am;
      }

The ActionManager is what enables the interaction between JRuby and Java. To delegate an action processed to the JRuby layer just use the following: 

      private void myButtonActionPerformed(java.awt.event.ActionEvent evt) {
          this.am.handleAction(evt, UIActions.SAMPLE_ACTION, this);
      }

_Make sure to generate the jar of your UI so we may import it in JRuby engine project._ 

## Step 5: Setting up the Engine

The JRuby layer contain the heart of your application. 

The key here is to generate a jar of your JAVA UI which will be used by the JRuby project part.  
Once Java UI jar is generated,include the jar in the classpath (and dependencies) to the JRuby project compiler in order to sync both project.

In order to use the Java class in your UI layer you need to declare the classes in the java\_classes file located in the 
config folder:

      # engine/config/initializers/java_classes.rb
      # ================================
      # IMPORT ALL JAVA CLASS USED IN THE PROJECT
      # This is the UI Jar
      # require  '/path/to/UI/MyApp.jar'

      # Mandatory Classes
      include_class 'org.github.bouba.fumoffu.UIActions'
      include_class 'org.github.bouba.fumoffu.ActionManager'

      include_class 'com.sample.app.MainView'


Then in order to process the actions create a handler and a controller.  

* * *
In Fumoffu there is 2 level to process the action:  

> 1) The handler layer is used to extract the incoming, delegate the processing to the controller and if required update the Java view. It is the only
> layer that interact directly with the Java layer.
> 
> 2) The controller layer is used to process actions
* * *

To create the controller and handler you may use the following rake task:

        rake fumoffu:generate:controller[controller_name]
        rake fumoffu:generate:handler[controller_name]

## Step 6: Implementing the Engine

In order to implement the engine you need to implement the handlers and the controllers:
      
      # FILE#1 engine/src/actions/controllers/sample_action_controller.rb 
      class SampleActionController < ApplicationController
        def say_hello
          "Hello JRuby !"
        end
      end
      
      # FILE#2 engine/src/actions/handlers/sample_action_handler.rb
      class SampleActionHandler < Fumoffu::Handler
        def initialize
          super
          @controller = SampleActionController.new
        end

        def handleAction evt, action, caller
          if action == UIActions::SAMPLE_ACTION then
            # first we get the main panel
            component = component_by_name evt.getSource, "mainPanel"
            label     = component_child_by_name component, "myLabel"

            label.setText @controller.say_hello
            return true
          end
          return false
        end
      end

      # FILE#3 engine/src/actions/handlers/application_handler.rb
      class ApplicationHandler < ActionManager
        def initialize
          @handlers = Array.new
          @handlers << SampleActionHandler.new
        end
        ....
      end
      
      
      # FILE#4 engine/config/initializers/app_classes
      ....
      def import_from_jar
        #  Example
        #  this is used to import java generated file from the jar 
        #  within the application which will be running in java
        #  you need to put the name of all the required class
        %w[
          controller
          handler
          application_controller
          sample_action_controller
          application_handler
          sample_action_handler
          ].each do |c|
              require c
          end

      end
      ....


*   File#1 is the controller that will process the action
*   File#2 is the handler that will interact with the Java UI, we associate the action with the controller in our sample
*   File#3 is the application handler that where we register our handler
*   File#4 in the declaration of our classes in the Java class path when the application jar is running (it is class path requirement that still need some work)

## Packaging

In order to package your application, the first step is to make a jar of all the rubygems dependencies (if you use ruby gems)
To do so use the following command line in your app (projects/sources/sampleapp in this example) folder:


      rake fumoffu:bundler:jar 
      fumoffu -b app 

[nb]: http://www.netbeans.com/downloads/index.html "[Netbeans][nb]"
[jruby]: http://jruby.org/download "[JRuby][jruby]"  