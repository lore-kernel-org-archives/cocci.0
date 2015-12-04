From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 4 Dec 2015 16:11:31 +0000
Subject: [Cocci] Using Coccinelle to add #include lines
In-Reply-To: <alpine.DEB.2.10.1512041701250.2768@hadrien>
References: <CAFEAcA-HKiMsz36SbfaGN3Oaz3Jn_h+f8McaHo48zmsngJtyRg@mail.gmail.com>
 <alpine.DEB.2.10.1512041701250.2768@hadrien>
Message-ID: <CAFEAcA-PnYAapj3tc5CiD4r5UROcbrO0x2=7xGTv+XqCjXWFKg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 4 December 2015 at 16:05, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Fri, 4 Dec 2015, Peter Maydell wrote:
>> So I tried:
>>
>> ===begin===
>> @ add2 @
>> @@
>>
>> + #include "qemu/osdep.h"
>> (
>>  #include "..."
>> |
>>  #include <...>
>> )
>
> Propagate the modification into the ( | ), ie duplicating the
> modification.

Do you mean like this:

===begin===
@ add4 @
@@

(
+ #include "qemu/osdep.h"
 #include "..."
|
+ #include "qemu/osdep.h"
 #include <...>
)

===endit===

?

That runs but has the same effect as having two separate
rules: a new #include line is added both before the first
#include "..." and before the first #include <...>, rather
than just once before the first incidence of any #include.

>> OK, plan B: have two rules like 'add1', one for each kind of include. This
>> might result in two includes per file, but we need to remove any
>> extra existing includes anyway, and that will delete the extras.
>> However my removal rule:
>>
>> ===begin===
>> @ delete @
>> @@
>>
>>  #include "qemu/osdep.h"
>>  ...
>> - #include "qemu/osdep.h"
>
> Coccinelle processes one top-level thing at a time.  The includes are in
> different top level units.
>
> The solution would be to take the position of each one, and then save only
> the position of the earliest one.  This would require using scripts and
> hash tables, and is kind of clunky.

Hmm. Maybe I'm better off just using sed or perl for this job?
#include lines are really pretty much line-based after all.

thanks
-- PMM
