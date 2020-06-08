Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6223AC433E0
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 10:28:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F8A2076A
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 10:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F8A2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058ARvXj014911;
	Mon, 8 Jun 2020 12:27:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2C81E7783;
	Mon,  8 Jun 2020 12:27:57 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0E78D44A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 12:27:55 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058ARsKf016655
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 12:27:54 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,487,1583190000"; d="scan'208";a="350899033"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Jun 2020 12:27:54 +0200
Date: Mon, 8 Jun 2020 12:27:53 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@ispras.ru>
In-Reply-To: <b273ce70-5527-6e79-9e1e-7a6c3f83eda4@ispras.ru>
Message-ID: <alpine.DEB.2.21.2006081224320.3136@hadrien>
References: <b273ce70-5527-6e79-9e1e-7a6c3f83eda4@ispras.ru>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 12:27:57 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 12:27:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Python interface
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Sun, 7 Jun 2020, Denis Efremov wrote:

> I've got a couple of questions about python interface.
> Let us suppose that I want to suppress a couple of matches because they are false-positives.
> However, I still want to check they exists in finalize block and print a warning otherwise.
> This is some kind of self-check for a rule.
>
> For example, there is "test.c" file with:
> extern int function1(void);
> extern int function2(void);
>
> int test(void)
> {
>         return function1();
> }
>
> And the rule test.cocci with:
>
> virtual context
> virtual org
> virtual patch
> virtual report
>
> @initialize:python@
> @@
> matches = [] # global list of all positions to check in finalize
> blacklist = frozenset(['test'])
>
> # Always prints []. Is it normal?
> #print(cocci.files())
>
> def relevant(p): # suppress functions from blacklist
> 	matches.extend(p) # It doesn't work in position script, so I do it here
> 	return False if blacklist & { el.current_element for el in p } else True # intersection
>
> @r depends on !patch@
> // It doesn't work. Is it normal?
> //position p: script:python() { matches.extend(p); relevant(p) };
> position p: script:python() { relevant(p) };
> @@
>
> * function1@p();
>
> @rp depends on patch@
> position p: script:python() { relevant(p) };
> @@
>
> - function1@p();
> + function2();
>
> // Self-check for the rule
> @finalize:python depends on !patch@
> @@
>
> # Always prints []. Is it normal?
> #print(cocci.files())
>
> if 'test.c' in cocci.files(): # I know that we should match test definition in test.c
> 	not_matched = blacklist - { el.current_element for el in matches }; # set difference
> 	if not_matched:
> 		print('SELF-CHECK: patterns no longer match definitions for: ' + ','.join(not_matched))
>
> I want to implement this kind of self-check for memdup_user function. I need check that the patterns
> match the function definition, but suppress these diagnostics. And print a warning about changed
> implementation if there is no matches for the patterns in mm/util.c

Is this self-check functionality planned for a patch in the Linux kernel,
or for some oher use?  Because the python script that I suggested for
collecting the names of all of the files will imply parsing all of those
files, which will have a major negative impact on performance.  Perhaps it
could be possible to have the complete list of files available in the
initialize rule, like you expected.  But I wonder if the difference
between "the file is not in the initial list" and "the file is in the
initial list but it is ignored" is important for you?

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
