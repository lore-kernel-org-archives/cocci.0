From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 14 Jan 2018 11:46:34 +0100
Subject: [Cocci] Coccinelle: alloc_cast: Add more memory allocating
 functions to the list
In-Reply-To: <alpine.DEB.2.20.1801141126290.7902@hadrien>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
 <68dd2f4a-7921-922c-399d-284d3506415d@users.sourceforge.net>
 <alpine.DEB.2.20.1801141003270.7902@hadrien>
 <2fd51b6d-75d8-ee9a-b52f-beab2299d9b0@users.sourceforge.net>
 <alpine.DEB.2.20.1801141056190.7902@hadrien>
 <0ca5933b-6973-8273-2646-3241157058cf@users.sourceforge.net>
 <alpine.DEB.2.20.1801141126290.7902@hadrien>
Message-ID: <8649d987-c6f2-f36d-3a6f-cfda02557362@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Look at the script code just under the comment "For context mode" and just
> under the comment "For patch mode".  Both of them use m.

I would like to apologise that I overlooked these places somehow.


> __ are typically used in sparse annotations.

Is this search pattern worth for a corresponding comment in the Python code?


How do you think about to pass it to the method ?compile? directly (without the variable ?pattern?)?

Regards,
Markus
