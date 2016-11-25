if Rails.env.production? || Rails.env.staging?
  cloudflare_ips = %w[
    https://www.cloudflare.com/ips-v4
    https://www.cloudflare.com/ips-v6
  ].map { |url| (open(url) rescue nil)&.read&.split("\n") }.flatten.compact

  env_ips = ENV['TRUSTED_PROXIES'].split(',')

  trusted_ips = [cloudflare_ips, env_ips].flatten.map { |ip| IPAddr.new(ip) }

  Rails.application.config.action_dispatch.trusted_proxies = trusted_ips
end