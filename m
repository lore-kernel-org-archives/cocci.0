From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Wed, 21 Oct 2015 09:13:33 -0700
Subject: [Cocci] Wiki for automatic reports / fixes
In-Reply-To: <CAB=NE6WYUHTsD1vMTYPmECmDM1khu4M4C+GW+MAf7UCuJmdp0g@mail.gmail.com>
References: <CAB=NE6XOHLdmo3u2fV5LHkY9Y1kH9zXHubLmoFypD++gZ4p5qg@mail.gmail.com>
 <22034.43969.711116.77647@mariner.uk.xensource.com>
 <CAB=NE6UR2_SQTxTe2E50fEGDg49F_jtYpbtcz90YdeKiJO5Tmg@mail.gmail.com>
 <CAB=NE6WYUHTsD1vMTYPmECmDM1khu4M4C+GW+MAf7UCuJmdp0g@mail.gmail.com>
Message-ID: <CAB=NE6Xv6HCBA95uroRO3=u9huTsfdCanWB7XuLr_CXAdeSG8A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Oct 12, 2015 at 12:55 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> On Mon, Oct 5, 2015 at 10:03 AM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
>> On Mon, Oct 5, 2015 at 9:56 AM, Ian Jackson <Ian.Jackson@eu.citrix.com> wrote:
>>> Luis R. Rodriguez writes ("Wiki for automatic reports / fixes"):
>>> [...]
>>>>  While discussing expectations and information about
>>>> reports over these with Valentin it occurred to me information about
>>>> all these may be scattered separately and some developers may be
>>>> surprised when they first get reports / fixes from these sorts of
>>>> testing systems and that perhaps it may be useful if we had a single
>>>> wiki entry point where we could refer folks to the different ongoing
>>>> testing infrastructures out there working upstream.
>>>>
>>>> If we could piggy back off of an already existing wiki then great, but
>>>> if not I was thinking something off of wiki.kernel.org might be good.
>>>> How about tests.wiki.kernel.org ? If such projects don't have a wiki
>>>> they could perhaps use pages off of tests.wiki.kernel.org to elaborate
>>>> and set expectations straight. Thoughts?
>>>
>>> To clarify what I think you are suggesting, is to create a new wiki or
>>> wiki page which gives information about automatic tests that are
>>> performed on upstream (or going-upstream) Linux branches ?
>>
>> That's right, as it stands we have a slew of folks doing a series of
>> battery of tests on either linux-next or other branches, and
>> developers / maintainers get e-mails about this. Typically one becomes
>> aware of these tests through experience and in dealing with reports
>> but other times one may not even be aware of ongoing effort on this
>> front, such was the case of Valentin's dead code analysis with
>> undertaker. Knowing what existing work is being done can and could be
>> used can also save people from re-inventing the wheel, but also and
>> most importantly collaborate.
>>
>>> I think this is a good idea.  I'm not sure how much information we
>>> need for each tester, but a page for each would be about right.
>>
>> Sure, I figure if each tester framework has its own dedicated page we
>> can at least refer to it, but a basic page which describes general
>> coverage / mailing lists / contact info / and what to expect might be
>> useful. As it stands most of this is just tribal knowledge.
>
> OK I'll poke and see if we can get this created.

OK we have a page up now to help track and document (if no
documentation exists) or refer to existing testing efforts for Linux:

https://bottest.wiki.kernel.org/

I went ahead and provided references for those projects that I was
aware of that had a page, otherwise I added some boiler plate
documentation page for them with some initial documentation I just
wrote. Please feel free to use this for your own documentation of your
test suite or refer to your own project if you have one from the top
level page.

 Luis
