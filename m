From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 12 May 2016 09:20:09 +0200 (CEST)
Subject: [Cocci] Out of tree instrumentation with coccinelle demo
In-Reply-To: <20160511205541.GF14141@wotan.suse.de>
References: <CAB=NE6XrFxvTJrJVVLvT-4ii-UU-tgAqB=AgzgFH20prR1DoUA@mail.gmail.com>
 <572F27FF.7040301@oracle.com> <20160508192303.GB14141@wotan.suse.de>
 <20160511205541.GF14141@wotan.suse.de>
Message-ID: <alpine.DEB.2.10.1605120915460.3316@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 11 May 2016, Luis R. Rodriguez wrote:

> On Sun, May 08, 2016 at 09:23:03PM +0200, Luis R. Rodriguez wrote:
> > On Sun, May 08, 2016 at 07:50:23AM -0400, Sasha Levin wrote:
> > > On 05/06/2016 07:26 PM, Luis R. Rodriguez wrote:
> > > > Julia and I had discussed the possibility to instrument Linux code as
> > > > an alternative to complex debugging strategies (lockdep is one) that
> > > > often may be frowned upon due to how intrusive some changes may be or
> > > > how much extra stuff would be needed upstream. It has been hard to
> > > > explain the idea to folks who might make some use of it so I've gone
> > > > ahead and created a demo tree for userspace code that shows some basic
> > > > instrumentation ideas. You can fetch it here:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/cocci-tact.git
> > >
> > > Thanks Luis! I haven't reviewed it yet, just Cc'ing Quentin and Vegard
> > > who are also working on the lock poisoning patchset.
> >
> > Another strategy can be to do instrumentation internally in Coccinelle
> > with the help of its standard rule dependency or extending use by
> > using Python scripting for a replacement for internall book keeping.
> >
> > The patch below is a simple alternative to adding C instrumentation
> > code but instead it actually tries to fix the code given a certain
> > set of conditions and rules.
>
> <-- snip -->
>
> Lastly, it just occurred to me that if a set of Coccinelle scripts
> do not suffice (I mentioned two options for instrumentation), another
> alternative building off of the first Coccinelle approach I mentioned
> would be to complement that with *new code* and *regular patches* that
> would otherwise simply not be appropriate with just Coccinelle. For
> instance, take the addition of code which initializes the instrumentation,
> or helpers definitions which may be generic. This need not belong in
> each piece of kernel code but perhaps more in a generic place, and if
> not upstream, one alternative can be a kernel complement framework to
> enable both to co-exist. It took me a bit to realize that we already
> have this... but once I realized it, it became an obvious alternative:
> the Linux backports infrastructure [0] already enables:
>
>   a) serializing applying regular patches, and
>   b) if one finds generalization rules also serializes
>      applying series Coccinelle SmPL patches
>   c) adding custom code which any of the above can use
>      through its own module (compat)
>   d) enables for module replacements (using depmod.d updates/),
>      so your distro has iwlagn for v3.5, backports lets you get
>      iwlagn update from code as of v4.3 [1]
>   e) enables as an alternative kenrel integration [2]
>
> In a way, the backports infrastructure provides a framework to let
> you roll out your own customized Linux distribution but with utmost
> focus upstream. For backports this makes sense -- we just re-use
> upstream and port. We do this as backporting is not welcomed upstream
> as it would mean having to add tons of nasty #ifdefs, and helper code..
> sound familiar? Instrumentation code which may be considered
> "too intrusive to have upstream" is another possible candidate
> that can benefit from it given all the bells and whistles have been
> ironed out already -- we strive to automate backporting ;)
>
> Now granted, we didn't set out to write backports to make it a generic
> framework, but -- its there, and if you guys have such an interest
> I think we can both benefit from collaborations... that is unless
> you do find a reasonable way to just shove everything upstream.
>
> [0] https://backports.wiki.kernel.org
> [1] https://backports.wiki.kernel.org/index.php/Documentation/packaging
> [2] https://backports.wiki.kernel.org/index.php/Documentation/integration

I'm just throwing thi out there as another idea, but maybe what is wanted
is a domain-specific language (DSL) in which to express locking
requirements, ie the fields that a lock protects and the entry points at
which this protection is not needed, and then from the DSL one could
generate semanticpatches or something else to do the right thing.  The
downside of the approach is the need to learn yet another language.  The
upside is that the language would hopefully be very simple.

On the other hand, I think that this information would be really helpful
for developers.  So maybe some code pollution could be tolerable.  The
developer who is only interested in getting correct code and moving
forward might not care about backporting, but that person does need to
know about locking invariants.

julia
