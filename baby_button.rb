require 'packetfu'
require 'sms-easy'
require 'gmail'
require_relative 'config_loader'
CONFIG = ConfigLoader.new.config_for("Baby button")
iface = ARGV[0] || CONFIG["network interface"]
@arp_source = CONFIG["arp source"]
@carrier = CONFIG["carrier"]
@phone_number = CONFIG["phone number"]
@message = CONFIG["message"]
@email = CONFIG["email"]
@password = CONFIG["password"]
@easy = SMSEasy::Client.new

def deliver_message
  receiver = SMSEasy::Client.sms_address(@phone_number, @carrier)
  Gmail.connect!(@email, @password) do |gmail|
    gmail.deliver do
      to receiver
      body @message
    end
  end
end

def notify_user packet
  if packet.arp_opcode == 1 && packet.arp_saddr_ip == '0.0.0.0'
    if packet.arp_saddr_mac == @arp_source
      deliver_message
    end
  end
end

puts "Baby button on!"
cap = PacketFu::Capture.new(:iface => iface, :start => true)
cap.stream.each do |packet|
  pkt = PacketFu::Packet.parse packet
  notify_user pkt if pkt.is_arp?
end

