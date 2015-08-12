From: mmarek@suse.cz (Michal Marek)
Date: Wed, 12 Aug 2015 16:12:10 +0200
Subject: [Cocci] [RFC] coccinelle: add style check for assignment in if
In-Reply-To: <1439387500-11183-1-git-send-email-kborer@gmail.com>
References: <1439387500-11183-1-git-send-email-kborer@gmail.com>
Message-ID: <55CB543A.70007@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 2015-08-12 15:51, Kris Borer wrote:
> Add a semantic patch for fixing some cases of checkpatch.pl error:
> 
> ERROR: do not use assignment in if condition

There is a gcc warning for this already.

Michal
