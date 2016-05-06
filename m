From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Fri, 6 May 2016 16:26:47 -0700
Subject: [Cocci] Out of tree instrumentation with coccinelle demo
Message-ID: <CAB=NE6XrFxvTJrJVVLvT-4ii-UU-tgAqB=AgzgFH20prR1DoUA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia and I had discussed the possibility to instrument Linux code as
an alternative to complex debugging strategies (lockdep is one) that
often may be frowned upon due to how intrusive some changes may be or
how much extra stuff would be needed upstream. It has been hard to
explain the idea to folks who might make some use of it so I've gone
ahead and created a demo tree for userspace code that shows some basic
instrumentation ideas. You can fetch it here:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/cocci-tact.git

  Luis
