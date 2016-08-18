From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 18 Aug 2016 09:06:35 +0200
Subject: [Cocci]
 =?utf-8?q?=E2=80=9Ccoccicheck_failed=E2=80=9D_during_para?=
 =?utf-8?q?llel_program_runs?=
In-Reply-To: <2821164A880A16429BC851319A6EBBC5741D0619@ORSMSX111.amr.corp.intel.com>
References: <2821164A880A16429BC851319A6EBBC5741D0619@ORSMSX111.amr.corp.intel.com>
Message-ID: <99082e9d-8047-eee3-68dd-9849868d4a96@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> With the 4.8-rc1 kernel, when I run Coccinelle check using the command ?make coccicheck MODE=report M=<path to directory>?,
> I get ?coccicheck failed? message. I get the same failure message even with ?MODE=patch?
> in the command.

I noticed this error message also.

There are further software possibilities.


> I didn?t see this error message with 4.7 kernel.

I guess that a change like "enable parmap support" (from 2016-07-22) will be relevant
for further considerations here.
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/scripts/coccicheck


> However, with the 4.8-rc1 kernel, if I turn off parallelization with J=1 option,
> I don?t see the error message. The check seem to be running successfully,
> even though it takes longer to run. I tried J=2, J=4,?  and I got error messages.
> So there seem to be a problem with J not equal to 1.

I imagine that the Coccinelle software can occasionally return inappropriate
status codes for its program implementations.
https://github.com/coccinelle/coccinelle/blob/958fcf8df0bd0e464a490b86e4f78ad4daf082d1/main.ml#L1517


> Can you please let me know how can I resolve the ?coccicheck failed? message?

* Would you like to try any related command variants out for a moment?

* How do you think about to help with any more software development resources?

Regards,
Markus
