From: corbet@lwn.net (Jonathan Corbet)
Date: Tue, 2 Dec 2014 08:56:39 -0500
Subject: [Cocci] [patch] CodingStyle: add some more error handling
	guidelines
In-Reply-To: <alpine.DEB.2.10.1412021007560.2483@hadrien>
References: <20141202085950.GA13434@mwanda>
 <alpine.DEB.2.10.1412021007560.2483@hadrien>
Message-ID: <20141202085639.43080af0@lwn.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 2 Dec 2014 10:09:02 +0100 (CET)
Julia Lawall <julia.lawall@lip6.fr> wrote:

> kmalloc actually takes two arguments.  Perhaps it would be better to show
> something that looks like a valid call.

Agreed; I took the liberty of sticking in a GFP_KERNEL as I applied the
patch with Julia's ack.

Thanks,

jon
