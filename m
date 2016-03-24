From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 24 Mar 2016 16:42:30 +0100
Subject: [Cocci] spatch temporary files issues
In-Reply-To: <02874ECE860811409154E81DA85FBB58579FD84C@ORSMSX115.amr.corp.intel.com>
References: <02874ECE860811409154E81DA85FBB58579FCC13@ORSMSX115.amr.corp.intel.com>
 <56F3C301.8000000@users.sourceforge.net>
 <02874ECE860811409154E81DA85FBB58579FD84C@ORSMSX115.amr.corp.intel.com>
Message-ID: <56F40AE6.9060308@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> That's essentially what I did as a work around. It just surprised me
> that there is no way to control how temporary files get created.

It seems that have got some control in such an use case already.
The user interface might not be as convenient as you would prefer.

Should a temporary directory be created that is stored at an other location
and separated from your SmPL scripts?

Regards,
Markus
