From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Thu, 4 Feb 2016 14:50:44 -0800
Subject: [Cocci] [RFC v1 1/8] paravirt: rename paravirt_enabled to
	paravirt_legacy
In-Reply-To: <20160120193241.GA4769@char.us.oracle.com>
References: <1450217797-19295-1-git-send-email-mcgrof@do-not-panic.com>
 <1450217797-19295-2-git-send-email-mcgrof@do-not-panic.com>
 <20160120193241.GA4769@char.us.oracle.com>
Message-ID: <CAB=NE6V-oTV20=BeWvYDeb8m46F_OTU8HdSg7bC9EUXzK1HaHg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jan 20, 2016 at 11:32 AM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Tue, Dec 15, 2015 at 02:16:30PM -0800, Luis R. Rodriguez wrote:
>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> Hey Luis,
>
> Sorry for the long time to respond..
>>
>> paravirt_enabled conveys the idea that if this is set or if
>> paravirt_enabled() returns true you are in a paravirtualized
>> environment. This is not true, this is really only useful to
>> determine if you have a paravirtualization hypervisor that uses
>
> s/users//
>> supports legacy paravirtualized guests. At run time, this tells
>> us if we've booted into a Linux guest with support for legacy
>> paravirtualized guests.
>
> I know I suggested the name but when I look at the words
> 'paravirtualized legacy' immediately I thought about legacy PV
> drivers.. which we do not have in the code.

OK...

> The description:
>
>> + *   paravirtualized guests. Examples of features that
>> + *   characterize legacy paravirtualized guests are
>> + *   things such as the need for APM, PNP BIOS.
>
> Explains it very nicely.
>
> Perhaps (And sorry for that) it should be just called
>
> legacy_platform() ?
>
> Or
> ancient_platform() ?

No, we need to prefix this as its paravirt related, I've given this
silly little rename quite a bit of thought and have decided to stick
to paravirt_legacy() and just adding paravirt_legacy_free() as a
separate helper. The clarification can simply be placed through kdoc
form in documentation. More on this below.

> Since that would lead folks to immediately think of things
> that existed long time ago - such as APM or PNP BIOS.

Right.

> Other suggestions would be to piggyback on Microsoft pushing
> the option in the BIOS to have an "Legacy Free" option (PS/2,
> PnP, serial port, parallel port - all are disabled):
> https://en.wikipedia.org/wiki/Legacy-free_PC

Interesting, yes I like this as it has stronger semantics. I looked
further and it seems this concept of "legacy free" comes from the PC
system design guide [0] by both Microsoft and Intel. The latest of
such documents and the latest definitions of a PC 2001 contains the
concept of "legacy free" and defines it well on Page 50 [1] under the
"PC 2001 requirements". It notes:

----
The basic goal for the legacy-free system requirements is that the
operating system and devices do not use any of the following

  * ISA slots or devices
  * Legacy FDC
  *  PS/2, serial, parallel, and game ports

Revisions to the ACPI specification provide a mechanism that allows
the BIOS to report whether a system provides the services of these
components and interfaces. If the BIOS reports that the system is
legacy free, the system must meet the requirements provided in this
section.
----

[0] http://tech-insider.org/windows/research/2000/1102.html
[1] http://tech-insider.org/windows/research/acrobat/001102/03sys-2001.pdf

> Perhaps:
>
> legacy_free() ?

That's a negation of the question "is legacy?", so this would be a
separate call. Also this doesn't have a prefix.

Note that what is legacy on x86 today may be very legacy tomorrow and
later on there may be other notions of legacy... so sticking loosely
to at least the "PC 2001" definition seems to make sense here and
would limit scope and date the notion of "legacy" here for x86 and for
this paravirt hook. For now I don't see a need to include a date check
though as its a paravirt check anyway, but at least the definition
needs to limit the scope in its documentation for now.

This particular check is *if your hypervisor* supports legacy PC 2001
systems, so we do in the end need a prefix given the question as to
whether or not the kernel can determine you are on a legacy free
system or not is a separate possible question. The above definition
seems to indicate that ACPI should allow the BIOS to reoport if a
system is legacy free or not, so if such mechanisms exist, code that
currently has sprinkled paravirt_enabled() (we'll rename this soon)
could also have such checks for legacy free as well. Once, and if,
such system check is available perhaps we should prevent a legacy free
hypervisor from booting on a legacy system.

Likewise with such system check present if a PV legacy capable
hypervisor boots a legacy free system -- the code checks for
subsystems that are legacy would avoid running given that although
pavarit_supports_legacy() gives true, is_system_legacy() would give
false and avoid running.

Anyway, unless I hear of better suggestions I'm going to stick to
paravirt_legacy() and add paravirt_legacy_free(), and just expand on
the documentation to help clarify this is not for PV legacy drivers.

> Thank you!

 Luis
