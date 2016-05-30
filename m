From: iago.abal@gmail.com (Iago Abal)
Date: Mon, 30 May 2016 18:52:15 +0200
Subject: [Cocci] Linux scripts/coccinelle/locks/double_lock.cocci not
	working ?
Message-ID: <CAGbDTvoOPvqRYv9MeHst4Xp5oVGT-tRb9Mjnv3M5OhHh9rr+7Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

It seems that the script scripts/coccinelle/locks/double_lock.cocci
distributed with Linux 4.7-rc1 is broken. I'm using using Coccinelle 1.0.4:

Fatal error: exception Failure("False should not be in the final result.
Perhaps your rule doesn't contain any +/-/* code, or you have a failed
dependency.  If the problem is not clear, try the option
--debug-parse-cocci.")

See
https://github.com/torvalds/linux/blob/1a695a905c18548062509178b98bc91e67510864/scripts/coccinelle/locks/double_lock.cocci

Could you confirm if that's the case?

Thanks,

Iago
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160530/c7b28307/attachment.html>
