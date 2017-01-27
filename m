From: johannes@sipsolutions.net (Johannes Berg)
Date: Fri, 27 Jan 2017 09:55:05 +0100
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <alpine.DEB.2.20.1701270807230.1935@hadrien>
References: <1485433691.14760.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261415040.3109@hadrien>
 <1485437521.14760.5.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261518560.3109@hadrien>
 <1485440882.14760.8.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261644140.3109@hadrien>
 <1485445951.14760.16.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701270807230.1935@hadrien>
Message-ID: <1485507305.5851.1.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2017-01-27 at 08:09 +0100, Julia Lawall wrote:
> Partial progress:??The github version will no longer match {} against
> { 0, 1, 2 }, but it persists in matching {} against { .a = 1, .b = 2
> },
> and will still remove the outer braces without removing the rest.

Out of curiosity: will it require some form of "..." to match something
inside now?

We have a few things like this:

@@
identifier x;
identifer fn;
@@
my_time x = {
+#ifdef XYZ
 .this_method_needs_xyz = fn,
+#endif
 ...
 };

in backports etc. and I've always wondered why it didn't need (or even
accept, IIRC) ... before the +#ifdef line.

johannes
