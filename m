From: Jamal.Khashan@diasemi.com (Jamal Khashan)
Date: Fri, 23 Aug 2013 09:01:44 +0000
Subject: [Cocci] coccinelle-1.0.0-rc18
Message-ID: <54AA37D70A06414FB8288E4A5662904A01024F2DD4@NB-EX-MBX01.diasemi.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


Hello,

I am having difficulties enabling python scripting with coccinelle-1.0.0-rc18 as follows

running source package configure

# ./configure --enable-release --with-python=/usr/bin/python
.
.

configure: skipped the selection of a global pycaml module because --enable-python is given explicitly but --enable-pycaml is not.
checking for /usr/bin/python... /usr/bin/python
checking python version... 2.6 found
configure: python major version: 2
configure: looking for the corresponding python library
checking for PYTHON... no
configure: error: the python scripts feature is enabled but the pkg-config python library is not found
.
.
# dpkg -l |grep pkg-config
ii  pkg-config                                        0.22-1build2                                    manage compile and link flags for libraries
#<mailto:root@swsrvapps-01:~/conf/coccinelle-1.0.0-rc18/setup#>

# which spatch
/usr/local/bin/spatch
# spatch --version
spatch version 1.0.0-rc17 without Python support and with PCRE support
#


Thanks and best regards,

Jamal Khashan
Dialog Semiconductors IT Helpdesk
Direct Dial: +49 (0)7021 805 555
Jamal.Khashan at diasemi.com<mailto:Jamal.Khashan@diasemi.com> |  www.diasemi.com<http://www.diasemi.com/>
Dialog Semiconductor GmbH, Neue Strasse 95, 73230 Kirchheim /Teck, Germany



________________________________

Dialog Semiconductor GmbH
Neue Str. 95
D-73230 Kirchheim
Managing Directors: Dr. Jalal Bagherli, Jean-Michel Richard
Chairman of the Supervisory Board: Gregorio Reyes
Commercial register: Amtsgericht Stuttgart: HRB 231181
UST-ID-Nr. DE 811121668

Legal Disclaimer: This e-mail communication (and any attachment/s) is confidential and contains proprietary information, some or all of which may be legally privileged. It is intended solely for the use of the individual or entity to which it is addressed. Access to this email by anyone else is unauthorized. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited and may be unlawful.

Please consider the environment before printing this e-mail


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130823/2f0be3f4/attachment.html>
