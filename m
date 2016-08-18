From: harish.chegondi@intel.com (Chegondi, Harish)
Date: Thu, 18 Aug 2016 00:34:17 +0000
Subject: [Cocci] Coccinelle issues with Linux kernel 4.8-rc1
Message-ID: <2821164A880A16429BC851319A6EBBC5741D0619@ORSMSX111.amr.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

With the 4.8-rc1 kernel, when I run Coccinelle check using the command "make coccicheck MODE=report M=<path to directory>", I get "coccicheck failed" message. I get the same failure message even with "MODE=patch" in the command. I didn't see this error message with 4.7 kernel.

However, with the 4.8-rc1 kernel, if I turn off parallelization with J=1 option, I don't see the error message. The check seem to be running successfully, even though it takes longer to run. I tried J=2, J=4,...  and I got error messages. So there seem to be a problem with J not equal to 1.

Below I have mentioned the spatch version and ocaml version.

-bash-4.2$ spatch --version
spatch version 1.0.4 with Python support and with PCRE support

-bash-4.2$ ocaml
        OCaml version 4.02.3



Can you please let me know how can I resolve the "coccicheck failed" message?

Thank You
Harish.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160818/32dfe62f/attachment.html>
