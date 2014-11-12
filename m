From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 13 Nov 2014 01:08:40 +0300
Subject: [Cocci] [PATCH v2 1/2] staging: rtl8188eu: Deletion of
 unnecessary checks before three function calls
In-Reply-To: <5463D109.4020702@users.sourceforge.net>
References: <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <544954FD.8040607@users.sourceforge.net>
 <20141029084702.GA18675@kroah.com>
 <5453CD0D.9010206@users.sourceforge.net>
 <alpine.DEB.2.10.1410311900201.2481@hadrien>
 <5463C10D.6020409@users.sourceforge.net>
 <5463C22B.7060405@users.sourceforge.net>
 <20141112211815.GJ6749@mwanda>
 <5463D109.4020702@users.sourceforge.net>
Message-ID: <20141112220840.GL5351@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Nov 12, 2014 at 10:28:41PM +0100, SF Markus Elfring wrote:
> > This is especially true if you have trained yourself to know that
> > free_netdev() can't accept NULL pointers.
> 
> Do you need to adjust your concerns a bit over time when function variants
> provide a corresponding safety check in their implementations?

No.  Really, free_netdev vs rtw_free_netdev is just an example where it
is really bad, but I feel that all of these patches are misguided and
harmful.

We should have an if statement if the allocation is optional, we should
not have an if statement if the allocation is required.

regards,
dan carpenter
