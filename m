From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 25 May 2016 09:18:11 +0200
Subject: [Cocci] Improvements for building the Coccinelle software
In-Reply-To: <20160524205926.GA15029@suse.de>
References: <alpine.DEB.2.02.1605232246310.2052@localhost6.localdomain6>
 <20160523211952.GY11948@wotan.suse.de>
 <alpine.DEB.2.02.1605232334130.2052@localhost6.localdomain6>
 <CAB=NE6Xt1iy2FtOq6DCvDnidh-r9Y+9KC1AFB=PccHVg4YXB1g@mail.gmail.com>
 <alpine.DEB.2.02.1605232343420.2052@localhost6.localdomain6>
 <20160523214931.GA11948@wotan.suse.de>
 <541922c4-84ae-cc7c-4baf-dbd7ace43961@suse.de>
 <1361a24e-9dc5-db4f-d347-370db8d126dc@users.sourceforge.net>
 <20160524200828.GA7425@suse.de>
 <81317386-8795-453e-713c-08911161c2b6@users.sourceforge.net>
 <20160524205926.GA15029@suse.de>
Message-ID: <1ad1bd94-7e35-e12e-c123-85c5700a659d@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The other usages of '[$]' (which seems to be some kind of escape) are fine.

Thanks for such a clarification.


> Its just the invocation of AC_COCCI_FINDTOOL with wrong arguments
> that needs fixing.

Will it be interesting to look at the circumstances under which this
update candidate was found?

I would appreciate if more corrections can be achieved for the build
scripts at other places. I am curious on further progress in this
software area.
https://github.com/coccinelle/coccinelle/issues

Regards,
Markus
