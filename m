From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 14 Nov 2017 13:31:26 +0100
Subject: [Cocci] Coccinelle: fix parallel build with
	CHECK=scripts/coccicheck
In-Reply-To: <alpine.DEB.2.20.1711141210560.2874@hadrien>
References: <alpine.DEB.2.20.1711140735020.2332@hadrien>
 <e1d8885a-4e3f-a980-00d8-76515d02da17@users.sourceforge.net>
 <alpine.DEB.2.20.1711141009250.2874@hadrien>
 <533ab049-900c-fbb7-04e0-8dfaef492847@users.sourceforge.net>
 <alpine.DEB.2.20.1711141210560.2874@hadrien>
Message-ID: <1e9f0a42-7587-b3e9-c335-e6b490ce5871@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The goal is that the user can easily find the stdou and stderr information
> while the semantic patch is running.

It matters when the tool ?spatch? tries to apply its own parallelisation strategy.


> This is useful for long running semantic patches to see
> if things are going well or not.

Yes, of course.


> I decided on creating a directory that contains the name of the semantic
> patch, then the date, then the pid.

I imagine that time stamps and process identifiers can become fragile.


> It should be easy for the user to see which is the most recent,
> in the case that previous instances are remaining.

This is usually fine.


> The goal is to avoid getting a mysterious error from make coccicheck,
> not to meet the needs of advanced users.

* How advanced are they if they pass the parameter ?CHECK=scripts/coccicheck??

* The Linux make script will be improved so that extra parallelisation
  will be usually avoided by the Coccinelle software.

Regards,
Markus
