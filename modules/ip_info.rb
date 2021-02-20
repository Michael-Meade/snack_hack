require 'resolv'
require './lib/reports'
module SnackHack
    module IpInfo
        def self.get_address(domain)
            Resolv.getaddress(domain)
        end
        def self.get_dns(domain)
            # GETS IPS 
            Resolv::DNS.open do |dns|
                ress = dns.getresources domain, Resolv::DNS::Resource::IN::A
                ress.each do |l|
                    Reports.new(domain, l.address.to_s + "\n", "ips.txt" ).save_txt("a+")
                end
            end
        end
        def self.run(domain)
            ip  = get_address(domain)
            get_dns(domain)
        end
    end
end