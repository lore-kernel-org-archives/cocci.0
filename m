From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 24 Mar 2016 17:02:54 +0100
Subject: [Cocci] spatch temporary files issues
In-Reply-To: <02874ECE860811409154E81DA85FBB58579FDC4B@ORSMSX115.amr.corp.intel.com>
References: <02874ECE860811409154E81DA85FBB58579FCC13@ORSMSX115.amr.corp.intel.com>
 <56F3C301.8000000@users.sourceforge.net>
 <02874ECE860811409154E81DA85FBB58579FD84C@ORSMSX115.amr.corp.intel.com>
 <56F40AE6.9060308@users.sourceforge.net>
 <02874ECE860811409154E81DA85FBB58579FDC4B@ORSMSX115.amr.corp.intel.com>
Message-ID: <56F40FAE.5030700@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I would expect software to make temporary files and directories at other locations,
> such as how perl provides the mktemp interface, so that files are safe from invocation like this.

* Have you got any preferences for a corresponding directory selection?

* Would you like to specify any name pattern for the preferred output directory?

Regards,
Markus
