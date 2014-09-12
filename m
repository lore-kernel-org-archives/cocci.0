From: picca@synchrotron-soleil.fr (picca at synchrotron-soleil.fr)
Date: Fri, 12 Sep 2014 11:17:53 +0200
Subject: [Cocci] How to add a few declarations?
In-Reply-To: <alpine.DEB.2.10.1409121104520.2580@hadrien>
References: <20140911141340.GA7418@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111614550.2419@hadrien>
 <20140911142737.GA7480@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111634070.2419@hadrien>
 <20140911145145.GA8047@synchrotron-soleil.fr>
 <5412ACF0.8050408@users.sourceforge.net>
 <20140912084025.GA3099@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409121043310.2580@hadrien>
 <20140912085945.GE3099@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409121104520.2580@hadrien>
Message-ID: <20140912091753.GA4092@synchrotron-soleil.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @@
> expression x, y, z;
> expression list es;
> fresh identifier values, n_values;
> @@
> 
> - f(x, y, z, es);
> + { double values[] = { es };
> +   unsigned int n_values = ARRAY_SIZE(values);
> +   f2(x, values, n_values, y, z);
> + }

thanks a lot I will try.
I will keep you informed.

Cheers

Frederic
