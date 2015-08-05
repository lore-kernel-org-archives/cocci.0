From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 5 Aug 2015 23:15:54 +0200
Subject: [Cocci] [PATCH v3 0/2] coccinelle: add localversion information
In-Reply-To: <1438034612-10595-1-git-send-email-mcgrof@do-not-panic.com>
References: <1438034612-10595-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <20150805211554.GI30479@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Jul 27, 2015 at 03:03:30PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> This v3 makes use of the recommended strategy by Nikolay to avoid
> a local variable for the version.sh. It also clarifies in the commit
> log on patch 2 that PGP signed tags are not required by default. If
> Coccinelle switches over to using PGP tags the scripts/setlocalversion
> file can be modified to require them, but for now this is disabled.
> 
> Lastly, in order to try to help simplify the way release managers might make a
> release in a linear fashion with a git tree I modified autogen.sh to accept
> a new argument:
> 
> ./autogen --ignore_localversion
> 
> which can be used by release managers to skip the local version string
> when making a release. This is in contrast to my v2 series which would
> have otherwise required release managers to make temporary tags, delete
> them, and them finally add a new tag later. This is much simpler solution.
> 
> The default is to parse the localversion string then if available.
> 
> Luis R. Rodriguez (2):
>   autotools: simplify the way to determine version information
>   autotools: add localversion information

S?bastien, Nikolay, are you folks OK with this being merged?

  Luis
