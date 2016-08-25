From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 25 Aug 2016 13:30:51 -0700
Subject: [Cocci] [PATCH v2 2/5] firmware: annotate thou shalt not
 request fw on init or probe
In-Reply-To: <20160825194133.GC3296@wotan.suse.de>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
Message-ID: <CAKdAkRS+UT2LhC9OBdmzjjbcEX24tHusYuzwiBMEEFysNW6wBQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Aug 25, 2016 at 12:41 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Thu, Aug 25, 2016 at 01:05:44PM +0200, Daniel Vetter wrote:
>> On Wed, Aug 24, 2016 at 10:39 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:

>> > Can they use initramfs for this ?
>>
>> Apparently that's also uncool with the embedded folks.
>
> What's uncool with embedded folks? To use initramfs for firmware ?
> If so can you explain why ?

Because it is not needed? If you are embedded you have an option of
only compiling drivers and services that you need directly into the
kernel, then initramfs is just an extra piece that complicates your
boot process.

Thanks.

-- 
Dmitry
