# -*- coding: binary -*-
require 'rex/post/meeterpeter'

module Rex
module Post
module meeterpeter
module Ui

###
#
# Privilege escalation extension user interface.
#
###
class Console::CommandDispatcher::Priv

  require 'rex/post/meeterpeter/ui/console/command_dispatcher/priv/elevate'
  require 'rex/post/meeterpeter/ui/console/command_dispatcher/priv/passwd'
  require 'rex/post/meeterpeter/ui/console/command_dispatcher/priv/timestomp'

  Klass = Console::CommandDispatcher::Priv

  Dispatchers =
    [
      Klass::Elevate,
      Klass::Passwd,
      Klass::Timestomp,
    ]

  include Console::CommandDispatcher

  #
  # Initializes an instance of the priv command interaction.
  #
  def initialize(shell)
    super

    Dispatchers.each { |d|
      shell.enstack_dispatcher(d)
    }
  end

  #
  # List of supported commands.
  #
  def commands
    {
    }
  end

  #
  # Name for this dispatcher
  #
  def name
    "Privilege Escalation"
  end

end

end
end
end
end
