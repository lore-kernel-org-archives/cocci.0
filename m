From: mmarek@suse.com (Michal Marek)
Date: Wed, 15 Jun 2016 09:50:11 +0200
Subject: [Cocci] [PATCH 2/4] scripts: add reqs python library
In-Reply-To: <1465942217-14452-3-git-send-email-mcgrof@kernel.org>
References: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
 <1465942217-14452-3-git-send-email-mcgrof@kernel.org>
Message-ID: <576108B3.30008@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 2016-06-15 00:10, Luis R. Rodriguez wrote:
> +        weight = (int(rel_specs['VERSION'])    << 32) + \
> +                 (int(rel_specs['PATCHLEVEL']) << 16) + \
> +                 (sublevel   		       << 8 ) + \
> +                 (extra * 60) + (relmod * 2)

This is going to silently break as soon as we have a version number with
e.g. a time stamp embedded. And there is actually no need to convert the
version string to an integer. You can convert them to arrays of
components and compare the components one by one.

Michal
