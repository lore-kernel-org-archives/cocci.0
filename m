From: coenen@gmail.com (Martijn Coenen)
Date: Fri, 12 Jan 2018 17:19:16 +0100
Subject: [Cocci] Support for macro expansion
Message-ID: <CALt5rJt=t1iHb42+hMPEoxqV12EMt+jge2e5AXaASAFGzpt_Ew@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I can't find a clear-cut answer on whether macro expansion is supported in
Coccinelle. There's a "--preprocess" option which says it runs the C
preprocessor before doing the match, but it didn't appear to do anything
when I tried it.

Background: I'm trying to do a semantic patch that is only applied when a
certain function is called or assigned. Unfortunately in some cases, the
function call is embedded in a macro, and so Coccinelle will not find it.
I'm aware I can manually define a macros file and have it expanded this
way, but I want to make this as generic as possible and have it work for
any function in the linux kernel - which means I'd have to put *lots* of
macros in there :)

Any suggestions?

Thanks,
Martijn
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180112/937efc44/attachment.html>
