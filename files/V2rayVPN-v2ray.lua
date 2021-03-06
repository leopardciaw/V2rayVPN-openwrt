local fs = require "nixio.fs"
local conffile = "/etc/V2rayVPN/v2ray" 

f = SimpleForm("V2rayVPN", translate("V2rayVPN - 下载v2ray程序"), translate("点击提交可以下载v2ray最新程序"))

t = f:field(TextValue, "conf")
t.rmempty = true
t.readonly = true
t.rows = 10
function t.cfgvalue()
	if not nixio.fs.access(conffile) then
        return "/etc/V2rayVPN/[v2ray,v2ctl] 文件不存在，请手动下载v2ray放到目录 /etc/V2rayVPN 否则无法正常运行"
	else
		return "/etc/V2rayVPN/[v2ray,v2ctl] 已经存在，可以正常运行"
    end
end

function f.handle(self, state, data)
	if state == FORM_VALID then
		if data.conf then
			luci.sys.call("/bin/sh  /etc/V2rayVPN/wget-v2ray")
		end
	end
	return true
end

return f
