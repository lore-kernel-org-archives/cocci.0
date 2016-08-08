From: klammerj@a1.net (Johann Klammer)
Date: Mon, 08 Aug 2016 12:48:12 +0200
Subject: [Cocci] [Solved] Q: stdint format specifiers
In-Reply-To: <alpine.DEB.2.10.1608080744490.3335@hadrien>
References: <57A36D97.9070402@a1.net>
 <alpine.DEB.2.10.1608041833290.7967@hadrien> <57A37175.7070801@a1.net>
 <alpine.DEB.2.10.1608041854360.7967@hadrien> <57A3ABD9.3090308@a1.net>
 <alpine.DEB.2.10.1608042306470.3488@hadrien> <57A7B7AF.208@a1.net>
 <alpine.DEB.2.10.1608080744490.3335@hadrien>
Message-ID: <57A8636C.4040003@a1.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 08/08/2016 07:46 AM, Julia Lawall wrote:
> On Mon, 8 Aug 2016, Johann Klammer wrote:
> 
>> //kinda works now ..kinda
> 
> It does rather lack elegance...
> 
> Does your software always use print variants for printing?  If there are
> some wrappers, you could see what happens without the constraint on f.
> 
> julia
> 
No, and I had to change that pattern a few times.
the thing is that scanf variants use different macros. 
and I can't really see what except for the func name 
would prevent me from matching those. 
