From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 15 Feb 2013 07:53:03 +0100 (CET)
Subject: [Cocci] [PATCH 0/5] Remove redundant NULL checks.
In-Reply-To: <511D8A2C.3080204@gmail.com>
References: <1360641713-24895-1-git-send-email-tipecaml@gmail.com>
 <alpine.DEB.2.02.1302120731570.2264@localhost6.localdomain6>
 <511AB4C2.4010400@gmail.com>
 <alpine.DEB.2.02.1302122313050.2232@localhost6.localdomain6>
 <511D8A2C.3080204@gmail.com>
Message-ID: <alpine.DEB.2.02.1302150751250.2039@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 15 Feb 2013, Cyril Roelandt wrote:

> (Shouldn't we be discussing this on Coccinelle's mailing list ?)

Sure

> On 02/12/2013 11:15 PM, Julia Lawall wrote:
> > On Tue, 12 Feb 2013, Cyril Roelandt wrote:
> > 
> > > On 02/12/2013 07:32 AM, Julia Lawall wrote:
> > > > Why do you consider only void returning functions?
> > > > 
> > > 
> > > I was afraid to find cases like:
> > > 
> > > if (x)
> > >      ret = noop_func(x);
> > > /* Code where the value of "ret" matters */
> > > 
> > > In such cases, removing the NULL check might change the behaviour of the
> > > code.
> > > It is not a problem when the return value of noop_func is ignored, though
> > > (as
> > > in cpdma_ctlr_destroy() in
> > > drivers/net/ethernet/ti/davinci_cpdma.c).
> > 
> > OK, good point.  There are indeed two things happening in this case - the
> > call and the assignment.
> > 
> > > There are other issues with this semantic patch:
> > > 1) It only works if the noop_func is called in the file where it is
> > > defined,
> > > which means it cannot catch "if (x) kfree(x)", for instance. I think I
> > > could:
> > > - run Coccinelle on the whole kernel to find functions that are no-ops
> > > when
> > > given a NULL pointer as an argument;
> > > - generate a second semantic patch that looks for the "if (x)
> > > noop_func(x)"
> > > pattern with noop_func being one of the functions found by the first
> > > semantic
> > > patch.
> > 
> > You can use iteration for this.  There is an example in the demos
> > directory.  iteration.cocci, I believe.
> > 
> 
> I did that, and it seems to work well on small examples. I'm afraid it might
> take a long time on the Linux kernel, though. The patch is made of two parts:
> one that looks for functions that are no-ops if one of the parameters is
> NULL, and one that looks for redundant NULL checks. Will the second part of
> the semantic patch be run on every file in the kernel for every function
> found by the first part ? I found 340 functions that we might be interested
> in, which is a lot... I attached the semantic patch.

If you are using glimpse or idutils it should continue doing that for the 
iterations and complete in a reasonable amount of time.  

julia

> > > 2) It doesn't work with functions that take more than one argument.
> > 
> > That should be fixable.  You can use eg
> > 
> > expression list[n] es;
> > 
> 
> Indeed, works like a charm !
> 
> Cyril.
> 
