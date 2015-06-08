From: johannes@sipsolutions.net (Johannes Berg)
Date: Mon, 08 Jun 2015 22:31:13 +0200
Subject: [Cocci] [PATCH] pycocci: sync pycocci with Coccinelle upstream
In-Reply-To: <1433793702-21322-1-git-send-email-mcgrof@do-not-panic.com>
 (sfid-20150608_220416_878803_1B3AED69)
References: <1433793702-21322-1-git-send-email-mcgrof@do-not-panic.com>
 (sfid-20150608_220416_878803_1B3AED69)
Message-ID: <1433795473.10172.3.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 2015-06-08 at 13:01 -0700, Luis R. Rodriguez wrote:
> pycocci is now part of Coccinelle upstream. Coccinelle has a plan
> to actually extend multithreaded support to enable us to not have
> to script this out. Until then pyccoci is used and I'll sync both
> solutions up as there is a bit of latency between a coccinelle release
> and what we may need from pycocci.

If it's upstream, do they ship it? If so it wouldn't be needed that we
have a copy, it seems?

johannes
