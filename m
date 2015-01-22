From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 22 Jan 2015 09:29:19 +0100
Subject: [Cocci] Run time differences between SmPL disjunctions and
 regular expressions (in constraints)
In-Reply-To: <alpine.DEB.2.10.1501212342170.2599@hadrien>
References: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
 <54BFD099.8030002@users.sourceforge.net>
 <F6392E9E-0D22-4398-8173-DD84FFEBAB98@gmail.com>
 <alpine.DEB.2.10.1501212342170.2599@hadrien>
Message-ID: <54C0B4DF.9060203@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Only use regular expressions if you absolutely have to.  They are not
> interpreted when preselecting files, so they drasticaly hurt performance.

How is a file pre-selection involved here?


Would anybody like to compare the concrete run time consequences for the
specification
of a specific function name list in semantic patch scripts?
* Alternation for regular expressions in SmPL constraints
* SmPL disjunction variant

Regards,
Markus
