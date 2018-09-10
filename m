From: johannes@sipsolutions.net (Johannes Berg)
Date: Mon, 10 Sep 2018 09:24:37 +0200
Subject: [Cocci] New release after 1.0.7?
In-Reply-To: <alpine.DEB.2.20.1808141515280.3371@hadrien>
 (sfid-20180814_152007_774372_35ED45D6)
References: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
 <alpine.DEB.2.20.1808141515280.3371@hadrien>
 (sfid-20180814_152007_774372_35ED45D6)
Message-ID: <1536564277.3224.7.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia,

On Tue, 2018-08-14 at 15:19 +0200, Julia Lawall wrote:

> Sorry, I'm not sure where 1.0.7 came from. [...]

> I would indeed like to make a release now that the compiations issues are
> resolved and things seem more stable.

Were you able to clear this up?

I see now that the website advertises the 1.0.7 release, however

 * it's not tagged in git(hub) - all previous releases have a tag
 * commit c1522bde ("Release 1.0.7") is NOT what's released as 1.0.7 on
   the website
 * it *looks* like the actual 1.0.7 release was cut from a much newer
   git commit, likely with the fix?

johannes
