From: Jamal.Khashan@diasemi.com (Jamal Khashan)
Date: Tue, 3 Sep 2013 06:24:02 +0000
Subject: [Cocci] coccinelle-1.0.0-rc18
In-Reply-To: <alpine.DEB.2.02.1309021519440.2250@hadrien>
References: <54AA37D70A06414FB8288E4A5662904A01024F2DD4@NB-EX-MBX01.diasemi.com>
 <alpine.DEB.2.02.1308240806340.1996@localhost6.localdomain6>
 <54AA37D70A06414FB8288E4A5662904A01024F7392@NB-EX-MBX01.diasemi.com>
 <alpine.DEB.2.02.1309021519440.2250@hadrien>
Message-ID: <54AA37D70A06414FB8288E4A5662904A01024F7599@NB-EX-MBX01.diasemi.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

Thanks for your feedback.

I think this version is a bit old?  Do you have the possibility to upgrade?
Unfortunately I neither can upgrade Ubuntu nor python per feedback from my clients as follows
"
Hi Jamal,
I've spoken with several other engineers and it would be a big risk to update python. We are using Gitorious (python) which manages all our software version control, also other people in different teams use python for their development and I do not know how this would affect those people. I think that his update would be too risky for us at the moment.
Regards,
Stephen
"

Can I supply any info, logs, configuration files etc that might assist in resolving this issue without OS or application upgrade?


Thanks and best regards,

Jamal Khashan
Dialog Semiconductors IT Helpdesk
Direct Dial: +49 (0)7021 805 555
Jamal.Khashan at diasemi.com |  www.diasemi.com
Dialog Semiconductor GmbH, Neue Strasse 95, 73230 Kirchheim /Teck, Germany


-----Original Message-----
From: Julia Lawall [mailto:julia.lawall at lip6.fr]
Sent: Monday, September 02, 2013 3:22 PM
To: Jamal Khashan
Cc: 'cocci at systeme.lip6.fr'
Subject: RE: [Cocci] coccinelle-1.0.0-rc18

On Mon, 2 Sep 2013, Jamal Khashan wrote:

> Hi Julia,
>
> Thanks for feedback, sorry for the late reply, I was on Vacation for a
> week, but here's the output requested
>
> # lsb_release -a
> No LSB modules are available.
> Distributor ID: Ubuntu
> Description:    Ubuntu 10.04.4 LTS
> Release:        10.04
> Codename:       lucid
> #

I think this version is a bit old?  Do you have the possibility to upgrade.  On the other hand, it is the same version that I have at home, so I can try to reproduce the problem.

> # pkg-config --exists --print-errors python-2.6 Package python-2.6 was
> not found in the pkg-config search path.
> Perhaps you should add the directory containing `python-2.6.pc'
> to the PKG_CONFIG_PATH environment variable No package 'python-2.6'
> found #

Do you just need to install python 2.6?  Did you install it separately from ubuntu?

I don't know much about pkg-config.  Maybe someone else knows why you might have some software installed but pkg-config can't find it.

julia

> Thanks and best regards,
>
> Jamal Khashan
> Dialog Semiconductors IT Helpdesk
> Direct Dial: +49 (0)7021 805 555
> Jamal.Khashan at diasemi.com<mailto:Jamal.Khashan@diasemi.com> |  www.diasemi.com<http://www.diasemi.com> Dialog Semiconductor
> GmbH, Neue Strasse 95, 73230 Kirchheim /Teck, Germany
>
>
> -----Original Message-----
> From: Julia Lawall [mailto:julia.lawall at lip6.fr]
> Sent: Saturday, August 24, 2013 8:12 AM
> To: Jamal Khashan
> Cc: 'cocci at systeme.lip6.fr'
> Subject: Re: [Cocci] coccinelle-1.0.0-rc18
>
> > I am having difficulties enabling python scripting with
> > coccinelle-1.0.0-rc18 as follows
>
> What OS/distribution are you using?  Perhaps the problem could be that you have python 2.6?  I have 2.7.
>
> Maybe you should try something like
>
> pkg-config --exists --print-errors python-2.6
>
> julia
> ________________________________
>
> Dialog Semiconductor GmbH
> Neue Str. 95
> D-73230 Kirchheim
> Managing Directors: Dr. Jalal Bagherli, Jean-Michel Richard Chairman
> of the Supervisory Board: Gregorio Reyes Commercial register:
> Amtsgericht Stuttgart: HRB 231181 UST-ID-Nr. DE 811121668
>
> Legal Disclaimer: This e-mail communication (and any attachment/s) is confidential and contains proprietary information, some or all of which may be legally privileged. It is intended solely for the use of the individual or entity to which it is addressed. Access to this email by anyone else is unauthorized. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited and may be unlawful.
>
> Please consider the environment before printing this e-mail
>
>
>



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
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130903/c315db79/attachment-0001.html>
