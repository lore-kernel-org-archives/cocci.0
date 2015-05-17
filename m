From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 May 2015 15:52:28 +0200 (CEST)
Subject: [Cocci] Fatal error: exception Failure("not supported")
In-Reply-To: <20150517132801.GA3881@opentech.at>
References: <20150517061803.GA32427@opentech.at> <20150517120807.GA13779@pema>
 <alpine.DEB.2.02.1505171511410.2077@localhost6.localdomain6>
 <20150517132801.GA3881@opentech.at>
Message-ID: <alpine.DEB.2.02.1505171541330.2077@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 17 May 2015, Nicholas Mc Guire wrote:

> On Sun, 17 May 2015, Julia Lawall wrote:
> 
> > do while is not supported.  Sorry.
> >
> 
> interesting - did this just not get done or
> is there a theoretical issue with do while constructs ? 

It just never got done...

How about

* x = read at p(...)
  ... when != x < 0
      when != x > 0
      when != x == -C
* x = read at p(...)

julia
