From: johannes@sipsolutions.net (Johannes Berg)
Date: Tue, 19 Dec 2017 10:41:56 +0100
Subject: [Cocci] Parse error with genl-const.cocci
In-Reply-To: <alpine.DEB.2.20.1712141614460.5502@hadrien>
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com>
 <1512116859.25588.4.camel@sipsolutions.net>
 <alpine.DEB.2.20.1712011015160.2865@hadrien>
 <1512120542.25588.7.camel@sipsolutions.net>
 <alpine.DEB.2.20.1712011059360.2865@hadrien>
 <e589e785-6e08-8b37-8017-09ffc8627de2@gmail.com>
 <alpine.DEB.2.20.1712141614460.5502@hadrien>
Message-ID: <1513676516.26145.4.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2017-12-14 at 16:16 +0100, Julia Lawall wrote:

> I updated the github version of Coccinelle such that
> patches/0027-genl-const/genl-const.cocci
> will almost parse correctly.  The only thing that remains is to change
> attribute into attribute name.

Ok, thanks, I'll keep that in mind when I update the version. It's a b
it unfortunate you couldn't get it to be completely backwards
compatible, but we'll deal with it :)

johannes
