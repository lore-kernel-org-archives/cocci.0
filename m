From: sasha.levin@oracle.com (Sasha Levin)
Date: Sun, 8 May 2016 07:50:23 -0400
Subject: [Cocci] Out of tree instrumentation with coccinelle demo
In-Reply-To: <CAB=NE6XrFxvTJrJVVLvT-4ii-UU-tgAqB=AgzgFH20prR1DoUA@mail.gmail.com>
References: <CAB=NE6XrFxvTJrJVVLvT-4ii-UU-tgAqB=AgzgFH20prR1DoUA@mail.gmail.com>
Message-ID: <572F27FF.7040301@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 05/06/2016 07:26 PM, Luis R. Rodriguez wrote:
> Julia and I had discussed the possibility to instrument Linux code as
> an alternative to complex debugging strategies (lockdep is one) that
> often may be frowned upon due to how intrusive some changes may be or
> how much extra stuff would be needed upstream. It has been hard to
> explain the idea to folks who might make some use of it so I've gone
> ahead and created a demo tree for userspace code that shows some basic
> instrumentation ideas. You can fetch it here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/cocci-tact.git

Thanks Luis! I haven't reviewed it yet, just Cc'ing Quentin and Vegard
who are also working on the lock poisoning patchset.


Thanks,
Sasha
