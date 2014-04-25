From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 25 Apr 2014 14:32:55 +0200
Subject: [Cocci] semantic patch feasibility
Message-ID: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I'm a Linux kernel developer doing a big refactoring on the GPIO subsytem.

I was wondering if the change I'm doing manually could be automated by
using cocinelle but I've no experience neither writing semantic
patches nor the SmPL language grammar.

So I wanted to ask people familiar with cocinelle whether is feasible
or not to model my change as a semantic patch so I can start reading
cocinelle papers and looking at examples or if is too complex for
cocinelle then I'll continue grepping and manually change as I've been
doing so far.

I'm sending as an attachment a very incomplete patch so you can get an
idea of the type of refactoring that I'm ding.

Thanks a lot for your help and best regards,
Javier
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-gpio-add-struct-gpio_chip_ops-to-abstract-GPIO-contr.patch
Type: text/x-patch
Size: 55538 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140425/6da5b328/attachment-0001.bin>
