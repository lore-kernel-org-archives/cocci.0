From: thomas.adam22@gmail.com (Thomas Adam)
Date: Fri, 16 Dec 2016 14:12:44 +0000
Subject: [Cocci] malloc/calloc/strup adding missing NULL checks
In-Reply-To: <alpine.DEB.2.10.1612161453460.6500@hadrien>
References: <20161216113410.4vauxw4u2f364l7v@fbsd-laptop>
 <alpine.DEB.2.10.1612161242300.3566@hadrien>
 <20161216131350.5xc6awlrv2yu5xso@fbsd-laptop>
 <alpine.DEB.2.10.1612161453460.6500@hadrien>
Message-ID: <20161216141242.3tisfzykz5zxcdtu@fbsd-laptop>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Dec 16, 2016 at 02:54:42PM +0100, Julia Lawall wrote:
> Could you send me the original .c file, preferably cut down to show only
> the error?
> 
> For --parse-c, most of the interestingoutput is on stderr.

Hi Julia,

Yes -- stderr was redirected to those files anyway.

Please see the attached .c file which just contains a sample function which
isn't being matched.

Kindly,
Thomas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pkg.c
Type: text/x-csrc
Size: 5161 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20161216/03da7b10/attachment.bin>
