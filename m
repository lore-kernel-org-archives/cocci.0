From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 16 Aug 2017 08:10:11 +0200
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <alpine.DEB.2.20.1708151930140.4600@hadrien>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
 <alpine.DEB.2.20.1708151930140.4600@hadrien>
Message-ID: <26694395-e366-a049-b30d-8b27a925dc56@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> However they can only be bound to the complete sequence of statements in a block.  So
> 
> @@
> statement list sl;
> @@
> if (x) {
>   sl
> }
> 
> is ok, but
> 
> @@
> statement list sl;
> @@
> if (x) {
>   one();
>   sl
>   two();
> }
> 
> is not.

How do you think about the usage of a similar SmPL specification?

@display@
statement list sl;
@@
 if (...)
 {
    header();
    { // Extra block
*   sl
    }
    footer();
 }

Regards,
Markus
