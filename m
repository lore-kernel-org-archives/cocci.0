From: jglisse@redhat.com (Jerome Glisse)
Date: Thu, 17 May 2018 17:04:01 -0400
Subject: [Cocci] [bug] exists do not work if file group is too big (>49)
In-Reply-To: <alpine.DEB.2.20.1805172227090.2273@hadrien>
References: <20180516191634.GB2994@redhat.com>
 <alpine.DEB.2.20.1805172219490.2273@hadrien>
 <alpine.DEB.2.20.1805172227090.2273@hadrien>
Message-ID: <20180517210401.GC15887@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, May 17, 2018 at 10:31:52PM +0200, Julia Lawall wrote:
> Concretely, the problem is with LOCK_REQ, which is used as a typedef name
> in cifs and as a enum constant in f2fs.
> 
> Would there be any chance of getting rid of the LOCK_REQ typedef?
> Typedefs for structure types are discouraged by the Linux kernel coding
> style.
> 
> julia

I will try to make patches for that, thought not anytime soon i am going
on PTO so not before i get back.

Thank you for debugging this further.

Cheers,
J?r?me
