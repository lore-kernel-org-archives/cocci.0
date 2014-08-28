From: francois.berenger@inria.fr (Francois BERENGER)
Date: Thu, 28 Aug 2014 17:12:37 +0200
Subject: [Cocci] patch for coccinelle's Makefile
In-Reply-To: <alpine.DEB.2.10.1408281616110.4009@hadrien>
References: <53FF35F5.9040903@inria.fr>
 <alpine.DEB.2.10.1408281616110.4009@hadrien>
Message-ID: <53FF46E5.4070804@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 08/28/2014 04:16 PM, Julia Lawall wrote:
> On Thu, 28 Aug 2014, Francois BERENGER wrote:
>
>> I think the uninstall target can be made much simpler and robust.
>
> Could you explain?  I am not at all familiar with the code.

Rather than removing things one by one in [...]/share/coccinelle/*
you can remove directly [...]/share/coccinelle .

This is more robust since some of the things in [...]/share/coccinelle/*
are not installed by all make targets but were nonetheless listed
by the uninstall target (which would fail with an exit 1, which is a 
problem when you package things for opam).

-- 
Regards,
Francois.
