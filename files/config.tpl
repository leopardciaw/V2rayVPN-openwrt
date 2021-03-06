{
  "log": {
    "access": "",
    "error": "",
    "loglevel": "warning"
  },
  "inbound": {
    "port": #socksProxy#,
    "listen": "0.0.0.0",
    "protocol": "socks",
    "settings": {
      "auth": "noauth",
      "udp": true,
      "ip": "127.0.0.1",
      "clients": null
    },
    "streamSettings": null
  },
  "inboundDetour": [
  	{
        "protocol": "dokodemo-door",
        "port": 1079,
        "settings": { 
		"network": "tcp,udp",
		"followRedirect": true
		}
    },
  	{
        "protocol": "dokodemo-door",
        "port": 7070,
        "settings": { 
		"address": "8.8.8.8",
		"port": 53,
		"network": "tcp,udp",
		"timeout": 0
		}
    },	
	{
        "protocol": "http",
        "port": #httpProxy#,
        "settings": {}
    }
  ],
  "outbound": {
    "tag": "agentout",
    "protocol": "vmess",
	"mux": {"enabled": true},
    "settings": {
      "vnext": [
        {
          "address": "#server#",
          "port": #port#,
          "users": [
            {
              "id": "#id#",
              "alterId": 16,
              "email": "t@t.tt",
              "security": "aes-128-gcm"
            }
          ]
        }
      ],
      "servers": null
    },
    "streamSettings": {
      "network": "ws",
      "security": "",
      "tlsSettings": {
        "allowInsecure": true,
        "serverName": null
      },
      "tcpSettings": null,
      "kcpSettings": null,
      "wsSettings": {
        "connectionReuse": true,
        "path": "#path#",
        "headers": null
      },
      "httpSettings": {
        "path": "#path#",
        "headers": null
      }
    }
  },
  "outboundDetour": [
    {
      "protocol": "freedom",
      "settings": {
        "response": null
      },
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      },
      "tag": "blockout"
    }
  ],
  "dns": {
    "servers": [
      "8.8.8.8",
      "8.8.4.4",
      "localhost"
    ]
  },
  "routing": {
    "strategy": "rules",
    "settings": {
      "domainStrategy": "IPIfNonMatch",
      "rules": [
        {
          "type": "field",
          "port": null,
          "outboundTag": "direct",
          "ip": [
            "0.0.0.0/8",
            "10.0.0.0/8",
            "100.64.0.0/10",
            "127.0.0.0/8",
            "169.254.0.0/16",
            "172.16.0.0/12",
            "192.0.0.0/24",
            "192.0.2.0/24",
            "192.168.0.0/16",
            "198.18.0.0/15",
            "198.51.100.0/24",
            "203.0.113.0/24",
            "::1/128",
            "fc00::/7",
            "fe80::/10"
          ],
          "domain": null
        }
      ]
    }
  }
}