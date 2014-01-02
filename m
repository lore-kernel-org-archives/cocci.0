From: linjia@ruijie.com.cn (=?gb2312?B?wda8ziizzLb+ILij1t0p?=)
Date: Thu, 2 Jan 2014 08:27:35 +0000
Subject: [Cocci] hi all, how to match the args in function
Message-ID: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I just began to learn cocci recently.
How to write a patch match the following?

Void func1(int s, bri_vlan_set_t t, char x)  yes
Void func2(int s,  char x)  no
Void func3(int s, bri_vlan_set_t t) yes

bri_vlan_set_t is defined type

I wrote:

@@
identifier fn, vp;
typedef bri_vlan_set_t;
@@
-fn(...bri_vlan_set_t vp...)

But it reports

Fatal error: exception Failure("minus: parse error:
 = File "r.cocci", line 5, column 7,  charpos = 60
    around = 'bri_vlan_set_t', whole content = -fn(...bri_vlan_set_t vp...)
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140102/cfded7ef/attachment.html>
