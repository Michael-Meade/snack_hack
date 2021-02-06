require 'resolv'
module SnackHack
    module IpInfo
        def self.get_address(domain)
            Resolv.getaddress(domain)
        end
        def self.get_dns(domain)
            Resolv::DNS.open do |dns|
                ress = dns.getresources domain, Resolv::DNS::Resource::IN::A
                puts ress.map(&:address)
            end
            puts ips
        end
        def self.run(domain)
            ip = get_address(domain)
            p get_dns(domain)
        end
    end
end