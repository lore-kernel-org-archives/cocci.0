Return-Path: <SRS0=mj88=UE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC33C28CC5
	for <cocci@archiver.kernel.org>; Wed,  5 Jun 2019 19:51:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22F02083E
	for <cocci@archiver.kernel.org>; Wed,  5 Jun 2019 19:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22F02083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x55JpV17025134;
	Wed, 5 Jun 2019 21:51:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5696E776A;
	Wed,  5 Jun 2019 21:51:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 803227767
 for <cocci@systeme.lip6.fr>; Wed,  5 Jun 2019 21:51:29 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x55JpT97009681
 for <cocci@systeme.lip6.fr>; Wed, 5 Jun 2019 21:51:29 +0200 (CEST)
Received: from [192.168.1.110] ([77.2.1.21]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M3UdI-1hZAAs1vfu-000cMb for <cocci@systeme.lip6.fr>; Wed, 05 Jun 2019
 21:51:28 +0200
To: cocci@systeme.lip6.fr
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <bd88dcf8-e3cb-4a63-8ebd-ce703506890e@metux.net>
Date: Wed, 5 Jun 2019 19:51:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:2kFYKHt6RVvCn2yXb3kbTLC1BhfqppaU07CSuYyNxbUx/MI3TWP
 R3tP2jhzBMHlfatUKemzIL4LkZC053Ic3NVcbQgtBGaw6gECbAgRkTQ9xOLEuqOAdmCsjjz
 ta1YJv/17Exw5ZTtJ+uhf1DN4AuXyK5ay58FPIvQ/SQ55UtzIZgtSlBwMRHgxx+KvZtGMI6
 Ks3k0VWePyAD6cFJPHKoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AoVLoIWu4aU=:NAt+i3Dc4gZlygJE1RktVW
 AGgdKgWEIvEmQEEbUnHnXC0AdkxqrRNDB6C2XT6KvUc7rmYStLVQH5kKkm61bTWZw1ZGFkL6x
 yNWQLQZc0W5tzxqfG2g/HVJ7b7AEoZikgVfXDzuTTrUEGDwFB8cTSx/SxxXMxydZ1Y2X7ACDs
 Ms/2jXAbZTmEevOz5OB+2J58Baci+TQmLIfyepiV40L0VD3P/RO4565dhCeOLcIM+lEgVDQDa
 DGzDmLeSfOj3SeBpRmFIOWPT4XoXhFd7WV2THkU0gfMz4/RbsYUv903aLM3ceYbsEp/1h2GgW
 aFN3WPDs7LceFCh8eR/m79fHj3dotrYsQmmbnsRdHxU4KguPsIzCmngRIjK+LTJlRano5eOXK
 UD9Y9tE4XwQBB+8NWLox6AZm3slfngDo11dEAWZVRqdT8W01MgIVc0j4H9cjj71wvYnQJ7ndY
 gc9e/fWcp1YyzE520XPcDbzhY65oUJyY1vTvKbyy9CD97Djqa+J4oZkKXNMIh8v2i7hQBsH7H
 /gkPljC+5o1SqFcCM+tTR0nlZdkTk4tdSHNIebRSQlnr5yUgNHXCIb8WjPk13H79Wb/N+uSUJ
 58rcIQUIZt3GBIwhC2Yx+J+WlR6X/cb+ymbm5ckrMuXlqAtzgv8M0BFXEsyVgQn3koxUZ2uEd
 nEueYA7baqWmMrgX+hr6GapDZwg+z4BuylZhoMjnlCpSCh/XrccGodAtXmPie9uMLPCT0K9KM
 MFnej6OWk5f9BJhd9TO+QhrdG/t2Y9tg8QobM/hoDtCqmV+gcfAtB0RLoxk=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Jun 2019 21:51:31 +0200 (CEST)
X-Greylist: Delayed for 03:20:42 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Wed, 05 Jun 2019 21:51:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] splitting and fingerprinting findings
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hi folks,


I'd like to hack up some scripts that automatically scan and report
findings on a daily basis, eg. on the linux-next tree. Obviously,
nobody can seriously read this all at once, especially not on a
daily basis.

Therefore I need to:

* split the findings (eg. by ruleset or affected files / subsystems)
* filter out findings that already have been reported.

The second part seems to be trickiest one, as the code might slightly
change in the meantime, laeding to different patch outputs. Ignoring
the @@ lines should at least drop a large portion of the duplicates,
but I'll yet have to see how well that works ...

Did anyone else already working on that topic ?


--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
