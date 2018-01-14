From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 14 Jan 2018 11:20:24 +0100
Subject: [Cocci] Coccinelle: alloc_cast: Add more memory allocating
 functions to the list
In-Reply-To: <alpine.DEB.2.20.1801141056190.7902@hadrien>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
 <68dd2f4a-7921-922c-399d-284d3506415d@users.sourceforge.net>
 <alpine.DEB.2.20.1801141003270.7902@hadrien>
 <2fd51b6d-75d8-ee9a-b52f-beab2299d9b0@users.sourceforge.net>
 <alpine.DEB.2.20.1801141056190.7902@hadrien>
Message-ID: <0ca5933b-6973-8273-2646-3241157058cf@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Well, you didn't keep the semantic patch in the message.

You can take another look in other information systems (if desired).
https://systeme.lip6.fr/pipermail/cocci/2018-January/004848.html


>> How do you think about to avoid the extra initialisation
>> when only the operation mode ?context? or ?patch? would be active?
> 
> context and patch use the regular expression too.

Where?


> All forms of the rule need it, to keep the casts that contain sparse annotations.

How do ?annotations? matter here?


Is a specific variable used only by two SmPL rules?

?
> +m = re.compile(pattern)
?
> @script:python depends on report@
?
> +if m.search(t) != None:
?


Why are two underscores used as a search pattern in this use case?

Regards,
Markus
