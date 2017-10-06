From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 6 Oct 2017 19:29:06 +0200
Subject: [Cocci] make install broken
In-Reply-To: <alpine.DEB.2.20.1710061604140.6420@hadrien>
References: <alpine.DEB.2.20.1710061604140.6420@hadrien>
Message-ID: <05d2c66a-66ac-6c18-2785-ae17a8f223e5@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The makefile issues are perhaps now resolved.

How much did you check it?


A few implementation details were improved.
Thanks for your software corrections so far.

I find that there are several aspects left over for further considerations.

Examples:
1. How would you like to fix dependencies like the following?

   elfring at Sonne:~/Projekte/Linux/next-patched> /usr/local/bin/spatch --timeout 23 ~/Projekte/Coccinelle/janitor/safer_size_determination2.cocci -dir arch/powerpc/platforms/powermac
   warning: Can't find macro file: /usr/local/bin/../lib/coccinelle/standard.h
   warning: Can't find default iso file: /usr/local/bin/../lib/coccinelle/standard.iso
   ?

2. Should specific commands be kept as mandatory?
   https://www.gnu.org/software/make/manual/html_node/Errors.html
   https://github.com/coccinelle/coccinelle/commit/08b0344695e27c021af1df847337bd0216f92510#diff-b67911656ef5d18c4ae36cb6741b7965R318

3. How do you think about to include additional build rules into
   the main make script?
   https://github.com/coccinelle/coccinelle/issues/110

4. Do you care for progress around the tool ?automake??
   https://github.com/coccinelle/coccinelle/issues/41

Regards,
Markus
