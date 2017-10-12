From: me@tobin.cc (Tobin C. Harding)
Date: Thu, 12 Oct 2017 13:11:09 +1100
Subject: [Cocci] prinkt specifiers
In-Reply-To: <alpine.DEB.2.20.1710110726070.3833@hadrien>
References: <20171011000745.GD2049@eros>
 <alpine.DEB.2.20.1710110726070.3833@hadrien>
Message-ID: <20171012021109.GA30753@eros>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Oct 11, 2017 at 07:27:43AM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 11 Oct 2017, Tobin C. Harding wrote:
> 
> > Hi,
> >
> > Is it possible to craft a coccinelle script to find and replace calls (in the kernel) that are
> > printing pointers using %x.
> >
> > Perhaps we could easily catch the calls that are casting the pointer within argument list, for example
> >
> > 	pr_info("x: %llx\n", (unsigned long long int)ptr);
> >
> > I'm happy to try and work out how to do it, just chasing a 'yes that is exactly the type of thing
> > cocci is good at' or a 'no, you are dreaming, perhaps <this tool> can do that'
> 
> It's possible.  Look at coccinelle/demos/format.cocci
> 
> This may not be the most well tested part of Coccinelle, so if it is not
> doing what you expect, please feel free to complain.
> 
> julia

Thanks Julia
