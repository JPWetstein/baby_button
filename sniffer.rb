require 'packetfu'
require_relative 'config_loader'

CONFIG = ConfigLoader.new.config_for("Baby button")
iface = ARGV[0] || CONFIG["network interface"]


def arp_display(packet)
  if packet.arp_opcode == 1
    if packet.arp_saddr_ip == '0.0.0.0'
      puts "ARP Probe from: #{packet.arp_saddr_mac}"
    end
  end
end

puts "Sniffer on!"

cap = PacketFu::Capture.new(:iface => iface, :start => true)

cap.stream.each do |packet|
  pkt = PacketFu::Packet.parse packet
  arp_display(pkt) if pkt.is_arp?
end