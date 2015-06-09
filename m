From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Tue, 9 Jun 2015 15:20:46 -0700
Subject: [Cocci] [PATCH] pycocci: sync pycocci with Coccinelle upstream
In-Reply-To: <1433831373.1892.0.camel@sipsolutions.net>
References: <1433793702-21322-1-git-send-email-mcgrof@do-not-panic.com>
 <1433795473.10172.3.camel@sipsolutions.net>
 <CAB=NE6W68eikvWE+YKKSUC3_S_pTLY-cJq5hGeRkKp2mx9dRMA@mail.gmail.com>
 <1433831373.1892.0.camel@sipsolutions.net>
Message-ID: <CAB=NE6VEd=tVfhWWheCWpOVd-kUNdQnivW-e8Jr=aPZq1iY7tg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Jun 8, 2015 at 11:29 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Mon, 2015-06-08 at 13:43 -0700, Luis R. Rodriguez wrote:
>> On Mon, Jun 8, 2015 at 1:31 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
>> > On Mon, 2015-06-08 at 13:01 -0700, Luis R. Rodriguez wrote:
>> >> pycocci is now part of Coccinelle upstream. Coccinelle has a plan
>> >> to actually extend multithreaded support to enable us to not have
>> >> to script this out. Until then pyccoci is used and I'll sync both
>> >> solutions up as there is a bit of latency between a coccinelle release
>> >> and what we may need from pycocci.
>> >
>> > If it's upstream, do they ship it? If so it wouldn't be needed that we
>> > have a copy, it seems?
>>
>> Indeed, Coccinelle 1.0 has pycocci except for this last patch I just
>> mentioned. I think it is important enough for our sake that the errors
>> are reported well, I think its fair to drop this in backports once
>> Coccinelle 1.1 is released and we can reasonably expect users to have
>> it installed.
>
> Not sure I see the point in applying it now - clearly we haven't had any
> issues here that required this change, so why bother?

Well, I had issues with it :P its why I fixed it.

 Luis
