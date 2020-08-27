#!/bin/bash -l

function get_jira_attch_files()
{
	if [ $# -ge 1 ];then
		local url=$1
		shift
	else
		local url=$(ds)
	fi
	local fn=$(echo ${url##*/})
	local jn=$(echo ${url%/*})
	jira_number=$(echo ${jn##*/})
	echo "${url} ${jira_number} ${fn}"
	fn="${jira_number}.${fn}"

	local prefix=$(echo ${url%%//*})
	local suffix=$(echo ${url##*//})

	local cmd="import urllib; print urllib.quote('${suffix}')"
	suffix=$(python -c "${cmd}")
	url="${prefix}//${suffix}"
	#echo "${url} ${fn}"

	echo curl "${url}" -XGET -H "Cookie: jira.editor.user.mode=wysiwyg; JSESSIONID=${JSESSIONID}; atlassian.xsrf.token=${atlassianxsrftoken}; mo.jira-oauth.baseurl=https://jira.anker-in.com; mo.jira-oauth.logoutcookie=e6ca6f41-b9b3-4e31-ac14-2da321db6a63; _ga=GA1.2.1710698958.1569467211" -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Host: jira.anker-in.com' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Safari/605.1.15' -H 'Accept-Language: zh-cn' -H 'Accept-Encoding: ""' -H 'Connection: keep-alive' -o "${fn}" "$@"
	curl "${url}" -XGET -H "Cookie: jira.editor.user.mode=wysiwyg; JSESSIONID=${JSESSIONID}; atlassian.xsrf.token=${atlassianxsrftoken}; mo.jira-oauth.baseurl=https://jira.anker-in.com; mo.jira-oauth.logoutcookie=e6ca6f41-b9b3-4e31-ac14-2da321db6a63; _ga=GA1.2.1710698958.1569467211" -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Host: jira.anker-in.com' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Safari/605.1.15' -H 'Accept-Language: zh-cn' -H 'Accept-Encoding: ""' -H 'Connection: keep-alive' -o "${fn}" "$@"
}

url=""
while [ $# -gt 0 ];
do
    case $1 in
	    -u)
            shift
            url="$1"
            ;;
        *)
            ;;
    esac
    shift
done

if [ "x${url}" != "x" ];then
	get_jira_attch_files "${url}"
else
	get_jira_attch_files
fi
