From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 18 Aug 2014 10:08:38 +0200
Subject: [Cocci] Conversion of some pointer arithmetic to array indexing
 style
In-Reply-To: <alpine.DEB.2.10.1408172154050.2392@hadrien>
References: <1408219616.2683.101.camel@joe-AO725>
 <1408222763.2683.107.camel@joe-AO725>
 <alpine.DEB.2.10.1408170510420.2599@hadrien>
 <1408280475.17489.4.camel@joe-AO725>
 <alpine.DEB.2.10.1408172154050.2392@hadrien>
Message-ID: <53F1B486.5080704@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @@
> expression e,x;
> identifier f;
> @@
> 
> + e->f[
> - *(
>    <+...
> (
> -  (e->f + x)
> +  x
> |
> +  x
> -  (x + e->f)
> )
>    ...+>
> -  )
> +  ]

Does the issue "isomorphism" matter in the shown addition?

Regards,
Markus
