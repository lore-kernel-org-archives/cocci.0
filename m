From: jean-sebastien.pedron@dumbbell.fr (=?UTF-8?B?SmVhbi1Tw6liYXN0aWVuIFDDqWRyb24=?=)
Date: Tue, 28 Oct 2014 19:24:28 +0100
Subject: [Cocci] Parsing errors in several headers
Message-ID: <544FDF5C.6040009@dumbbell.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!

I'm very new to Coccinelle and I don't understand why spatch(1) returns
parsing errors on some headers and what I can do about that.

== First example ==

Header to parse:
https://github.com/freebsd/freebsd/blob/master/sys/ofed/include/linux/bitops.h

Full spatch command line and output:
http://pastebin.com/DbNhBAF7

spatch(1) fails to parse the #define at the end of the header. This
#define starts a for() loop and uses functions declared ealier in the
same file.

== Second example ==

Header to parse:
https://github.com/freebsd/freebsd/blob/master/sys/ofed/include/linux/spinlock.h

Full spatch command line and output:
http://pastebin.com/C0h5ZN7r

Here, it doesn't like the last #define again. This #define calls other
macros defined in other headers.

FYI, I'm using Coccinelle 1.0.0rc19 on FreeBSD.

Can somebody help me understand what's wrong here?

Thanks!

-- 
Jean-S?bastien P?dron

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 949 bytes
Desc: OpenPGP digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141028/a7c088ee/attachment.asc>
