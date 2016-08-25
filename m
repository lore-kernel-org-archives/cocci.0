From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu, 25 Aug 2016 22:25:49 +0200
Subject: [Cocci] [PATCH v2 2/5] firmware: annotate thou shalt not
 request fw on init or probe
In-Reply-To: <CAKMK7uFGSKpwrz2gdG=AFiPkdrdtyxpVMkk6QbdVDy-q4G1ZrA@mail.gmail.com>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
 <CAKMK7uFGSKpwrz2gdG=AFiPkdrdtyxpVMkk6QbdVDy-q4G1ZrA@mail.gmail.com>
Message-ID: <20160825202549.GF3296@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Aug 25, 2016 at 10:10:52PM +0200, Daniel Vetter wrote:
> Cutting down since a lot of this is probably better discussed at
> ks/lpc. Aside, if you want to check out Chris Wilson's work on our new
> depency handling, it's called kfence.
> 
> https://lkml.org/lkml/2016/7/17/37

Thanks more reading.. :)

> On Thu, Aug 25, 2016 at 9:41 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> >> > So .. I agree, let's avoid the hacks. Patches welcomed.
> >>
> >> Hm, this is a definite change of tack - back when I discussed this
> >> with Greg about 2 ks ago it sounded like "don't do this". The only
> >> thing we need is some way to wait for rootfs before we do the
> >> request_firmware. Everything else we handle already in the kernel.
> >
> > OK so lets just get this userspace event done, and we're set.
> 
> Ah great. As long as that special wait-for-rootfs-pls firmware request
> is still allowed, i915&gfx folks will be happy. We will call it from
> probe though ;-) but all from our own workers.

We should strive for this to be transparent to drivers, ie, this safeguard of
looking for firmware should be something handled by the kernel as otherwise
we're just forcing a race condition given the review in the last thread.

  Luis
