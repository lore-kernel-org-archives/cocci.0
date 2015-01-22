From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 22 Jan 2015 09:45:42 +0100
Subject: [Cocci] Matching functions with attributes
In-Reply-To: <02347CD6-6A31-41A9-B4EE-58163C49368C@gmail.com>
References: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
 <54BFD099.8030002@users.sourceforge.net>
 <F6392E9E-0D22-4398-8173-DD84FFEBAB98@gmail.com>
 <alpine.DEB.2.10.1501212342170.2599@hadrien>
 <02347CD6-6A31-41A9-B4EE-58163C49368C@gmail.com>
Message-ID: <54C0B8B6.3030508@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> I have a list of functions that I know can?t return NULL.

Such a function property can also be automatically determined
with semantic filter scripts to some degree (if you have got
access to corresponding source files).
How do you manage the knowledge for your function name list?

Regards,
Markus
