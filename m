From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Fri, 3 Apr 2015 11:37:39 -0700
Subject: [Cocci] Linux backports statistics - Generation / Modules / patches
	/ SmPL usage
Message-ID: <CAB=NE6WkANzR+EJmuGgx-MSw1o-xmzZ=T2PgLqgWZceSxr3VwQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Folks,

Here are the stats on the latest backports release so far with
relation to patches and SmPL patches. When we first integrated
Coccinelle support we had tons of SmPL patches but after we dropped
support for older kernels we dropped quite a lot of SmPL patches
leaving us with only 5 for a while. This will change over time.

kernel          generation      patches SmPL    supported-kernels       Modules
v3.11           42.649          225     0       26                      661
v3.12           33.363          225     0       27                      656
v3.13           215.453         198     3       29                      657
v3.14           92.443          176     5       30                      687
v3.15           104.816         57      5       15                      687
v3.16.2         93.462          65      5       16                      774
v3.17-rc3       113.462         65      5       17                      727
v3.18.1         87.932          71      5       18                      735
v3.19-rc1       90.100          80      5       19                      717

Stefan's Ethernet SmPL patches will likely trickle in on the next
release and that should remove some patches and obviously increase the
number of SmPL patches. In the next release we likely won't see a huge
delta on number of drivers Vs SmPL patches other than perhaps the one
Ethernet driver that Stefan added but the value should start becoming
clearer as others try to add similar Ethernet drivers without having
to add new patches and instead can rely on the same SmPL patches. In a
specific release we don't necessarily just focus on SmPL patch tuning
and as such other things like dropping some drivers might happen, this
means we can't easily rely on driver count / patch count to make
assumptions on efficiency / productivity brought to us by SmPL. To get
a more effective productivity measure of SmPL patches we might instead
have to rely on the impact of each specific SmPL patch Vs the number
of patches it would otherwise replace. Technically SmPL also lets us
use multicores on a system more efficiently than when applying patches
linearly but in order to come up with a metric that helps use evaluate
the impact of that we'd also need to compute the patch-applicaiton
time of the linear series on the same target. To get the value-add of
SmPL patches for scope (number of patches it replaces in comparison to
the alternative of not having that SmPL patch) and time saved in
generation we'd need to generate a target twice for each patch so we
can do comparisons. This seems like something perhaps worth
considering adding on top of Coccinelle itself.

Statistics notes:

The generation time above is computed from the "real" time computed by
bash's time built-in, and since has to be relative to the system being
used the system used here is the backports build machine when idle.
The command used to extract the generation time comes from and using
the "real" value:

$ time ./gentree.py /home/mcgrof/linux-stable/
/home/mcgrof/build/backports-3.19-rc1

If minutes are expressed they are multiplied by 60 to add to the
seconds provided. The option to assume the linux-stable directory
already has checked out v3.19-rc1 is used here to reduce the search
for the contents from within git objects (for that we'd use
--git-revision on gentree.py). The number of supported modules comes
from building a backports release using the previous kernel, as that
is expected to backport the largest amount of drivers, so for instance
to see number of backported modules from v3.19-rc1 release we use a
v3.18 kernel to test compilation on that, and then find ./ -name
\*.ko.

In the future we may wish to include into a tag each of these stats so
we don't have to dig them out and it will be present on record on the
commit logs. Some of these stats are all relative to a machine so if a
different machine is used new stats would need to be generated.

More stats including historical stats are available at:

https://www.google.com/fusiontables/DataSource?docid=1wXnm0VFUHBpaMmxwjaZZD58B4o8K1iPFCCOx50Q

If you'd like to help upkeep this please let me know.

  Luis
