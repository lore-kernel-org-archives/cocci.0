From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Tue, 21 Apr 2015 14:14:53 -0700
Subject: [Cocci] [PATCH v3 2/3] IB/qib: use arch_phys_wc_add()
In-Reply-To: <CALCETrVOEkJ5kqSHRhK1bUQm=5k6oDex7eU5UtvZq_ik-H_KbQ@mail.gmail.com>
References: <1429648676-17755-1-git-send-email-mcgrof@do-not-panic.com>
 <1429648676-17755-3-git-send-email-mcgrof@do-not-panic.com>
 <20150421205716.GA474@obsidianresearch.com>
 <32E1700B9017364D9B60AED9960492BC256FB8E2@fmsmsx120.amr.corp.intel.com>
 <CAB=NE6U+xWZGmEo-k3XURnuqQP1HE3k7663w6XWD_i=GtqDR3w@mail.gmail.com>
 <CALCETrVOEkJ5kqSHRhK1bUQm=5k6oDex7eU5UtvZq_ik-H_KbQ@mail.gmail.com>
Message-ID: <CAB=NE6UZBv0PMhpXCO7ZdY2J5uGH4KkfkuviDrsZWM5gMNZb6w@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Apr 21, 2015 at 2:12 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Tue, Apr 21, 2015 at 2:09 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
>> On Tue, Apr 21, 2015 at 1:59 PM, Marciniszyn, Mike
>> <mike.marciniszyn@intel.com> wrote:
>>>> > This driver already makes use of ioremap_wc() on PIO buffers, so
>>>> > convert it to use arch_phys_wc_add().
>>>>
>>>> This is probably OK, but I think you should also remove the qib_wc_pat module
>>>> parameter.
>>>>
>>>> Jason
>>>
>>> Revise based on Jason's request and I will do some testing.
>>
>> I did thiink about this -- but removal of module parameters can often
>> times break users of the module parameter, I figured its best to leave
>> it to you guys to decide what to do with that, so this leaves it as a
>> no-op. Can this series be applied and then you can decide what to do
>> to not affect your users on top of this?
>
> As of a few kernel versions ago, unrecognized module parameters no
> longer cause the module to refuse to load.

Sexy, I'll respin the changes only to the qib driver. Can the changes
to ipath still be applied?

 Luis
