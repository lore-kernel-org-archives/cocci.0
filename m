From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 06 May 2015 15:45:23 +0200
Subject: [Cocci] [patch 119/197] scripts/coccinelle/free: Delete NULL
 test before freeing functions
In-Reply-To: <alpine.DEB.2.02.1408091028520.2016@localhost6.localdomain6>
References: <53e53fd1.zO3IbUqJ421c7VXf%akpm@linux-foundation.org>
 <53E5DA60.90902@users.sourceforge.net>
 <alpine.DEB.2.02.1408091028520.2016@localhost6.localdomain6>
Message-ID: <554A1AF3.9010802@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> + at r depends on context || report || org @
>>> +expression E;
>>> +position p;
>>> +@@
>>> +
>>> +* if (E)
>>> +*	\(kfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|usb_free_urb\)(E);
>>
>> How do you think about to add the construct "@p" also behind the function name
>> "usb_free_urb"?
> 
> Yes, that would be needed, thanks.  Also, it was recently suggested to add 
> of_node_put to the list of things that are checked for.

Would you like to achieve further improvements for this approach?
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/scripts/coccinelle/free/ifnullfree.cocci?id=refs/tags/v4.0.1#n34

Regards,
Markus
