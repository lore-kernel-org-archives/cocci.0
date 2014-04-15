From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Apr 2014 10:01:01 +0200 (CEST)
Subject: [Cocci] Road map after Coccinelle 1.0.0-rc21?
In-Reply-To: <534CE166.1050704@users.sourceforge.net>
References: <alpine.DEB.2.10.1404141356250.2601@hadrien>
 <534BDDD6.9070407@users.sourceforge.net>
 <alpine.DEB.2.10.1404141525370.2572@hadrien>
 <534BE66B.8060907@users.sourceforge.net>
 <alpine.DEB.2.10.1404141622020.2591@hadrien>
 <534BF121.40607@users.sourceforge.net>
 <alpine.DEB.2.10.1404141634180.2591@hadrien>
 <534BF3B3.90007@users.sourceforge.net>
 <alpine.DEB.2.10.1404141725420.2572@hadrien>
 <534C10AD.1080806@users.sourceforge.net>
 <alpine.DEB.2.10.1404150721500.2083@hadrien>
 <534CD225.1010207@users.sourceforge.net>
 <alpine.DEB.2.10.1404150909470.2587@hadrien>
 <534CE166.1050704@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1404151000060.2587@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 15 Apr 2014, SF Markus Elfring wrote:

> > Yu should use virtual identifiers, not huge regular expressions.
>
> Unfortunately, "big" regular expressions can not be passed by virtual
> identifiers to SmPL constraints so far.

Th eidea is to pass the collected information one by on, eg using a make
file.  Not to use a regular expression at all.

julia

>
> Regards,
> Markus
>
