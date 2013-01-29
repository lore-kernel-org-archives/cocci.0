From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 29 Jan 2013 20:30:05 +0300
Subject: [Cocci] coccinelle and bitmask arithmetic (was: Re: [patch]
 TTY: synclink, small cleanup in dtr_rts())
In-Reply-To: <alpine.DEB.2.02.1301291717530.3339@hadrien>
References: <20130127194039.GA18787@elgon.mountain>
 <1359317078.14406.12.camel@joe-AO722>
 <20130127201947.GO16282@mwanda>
 <9561.1359474916@turing-police.cc.vt.edu>
 <1359475998.4196.26.camel@joe-AO722>
 <alpine.DEB.2.02.1301291717530.3339@hadrien>
Message-ID: <20130129173004.GP16282@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jan 29, 2013 at 05:19:43PM +0100, Julia Lawall wrote:
> If the definition of a bitmask is an identifier in all capital letters,
> that would be easy.  Another possibility is such an identifier that is
> defined to a value expressed beginning with 0x.  Another possibility is
> such an identifier that is sometimes used with & and | and sometimes used
> with an arithmetic operation.  I will give them a try.
> 

Oddly enough, this thread started because I wrote a script to do
this in Smatch.  It turns out not as useful as I had hoped, so I
wasn't planning to push it.

Anyway, I've gzipped it and attached it.  It's 350k because it has
a list of 50k macros which were used as bit masks.  Hopefully, it's
helpful.

It generates 350 warnings, but they are almost all false positives.
I have sent two patches based on the output.

regards,
dan carpenter

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-check_bit_masks-complain-if-bitmasks-are-used-for-ma.patch.gz
Type: application/octet-stream
Size: 353926 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130129/bbf83b14/attachment-0001.obj>
