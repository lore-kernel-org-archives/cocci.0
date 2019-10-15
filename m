Return-Path: <SRS0=wUuY=YI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F141C10F14
	for <cocci@archiver.kernel.org>; Tue, 15 Oct 2019 06:55:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BF42086A
	for <cocci@archiver.kernel.org>; Tue, 15 Oct 2019 06:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="QRtVo6mX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BF42086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9F6t0Rh009939;
	Tue, 15 Oct 2019 08:55:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E381077B2;
	Tue, 15 Oct 2019 08:54:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DA08744B2
 for <cocci@systeme.lip6.fr>; Tue, 15 Oct 2019 08:54:58 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9F6swgL017710;
 Tue, 15 Oct 2019 08:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571122493;
 bh=rpnyLV+TA0/RMI3gVIoCb9uJbbHCi9D8AovYPC9xXm8=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=QRtVo6mX5mS1RsjKs5TrKh5mwZ8XpbzaWilxsS9HrKaLin47HCuQB/u6rZwbaN3bD
 BhFh23LaAt3i/KxFC9YIPkKLenjqbWNa6xGsQiKD5MHuJzMHEt1gS6F6/kvHtb7DB7
 KxgGTDeVeY23IVw6QNXoxZdUs8Rl6D1OkKd6/YnM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.79.11]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MFvnC-1iFIdf1IjG-00Eu8q; Tue, 15
 Oct 2019 08:54:53 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@lip6.fr>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>
References: <56e7bd73-5b50-ddeb-9a56-62daf93eb015@suse.com>
 <56102ab5-b633-7e14-1fd3-3f43fb0770b9@web.de>
 <alpine.DEB.2.21.1910141740580.2330@hadrien>
 <aa8de6c2-7baf-321a-2447-29f6b107eb9c@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <75528193-4637-600a-b3b2-cc08a118db35@web.de>
Date: Tue, 15 Oct 2019 08:54:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <aa8de6c2-7baf-321a-2447-29f6b107eb9c@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:bjDcRX8puEAO44YfDkU2WJT9KLB4eihojQ19ywN9FqBEGgjU2in
 gFUpL/4EPWT6DtY+g4oB7AJxEk/OUL8V6/KDo9RpTfPm0t+xQr9fkti0uNudcbAAbzC1wmd
 nXhKcfdGqEf9B/LhsDahEQyD1Tpxw2e/d2WJ3hVPbzKME3TJfLHejnHf6/59JPqMbg5u5Lt
 otctnAn04cP0fCLLsOUaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mJdA8zrHZtY=:HDMAL9SLxmWvLa4FK0GR7K
 U6K50RPdqZdJ4kbvSlYtJUc3x5BgqTNWpoYtVLRFEN2RHq62//Ez04WvfLkVwRwYE9IAaAI5z
 MBK27NlB3lG4uBIxIgsZmuId3UliOP40wEzGKl/SGxkdhJUey9sKRwPnVBMvkcHHTrq06sfRT
 tWyfNptZKvIRPRC67JQl7/i+U7brpclh7i+inOuXfql+LxJXguH8NuzRDBS3scbfN5xoJ5dyT
 J17qD+xOvkmG2HZRH5/y7YGFOFH7o7aug53KnvaH+uNHjgqiQ5z2qqnGFXBtr0YS6JCMteHce
 74N/YPYIe550iXEJQq7rPU7IcKwTsNwJoTm5sJJxDTO3esA0juUNYOprHTvE4whLhgExLunAZ
 yLT/o6lBJuz/JYbI0Q6kj/p1opyj6bW2IXxXydToLGfPb4dyRyRSZojDON94MFj17fl2iVrTu
 sjF8K86S1+7RRElMBWsavj9JKeJxwnh98RLfFRZjyDUGYW/9cb4mEzbsuKbV/UjjFWuFhR2O8
 wlsNqOf0057PvjDvMglKBo22pq6CvJ8sc3xenMyVFCFGgOTkcogVGwgO0AJ/Dx3/YfxfkJtGy
 jaJSy2iw1enhk6kz9yUE/4x7DDMLVXsaWLdnnSSAMqvdpqihl2vutzYwX6sbBV0sfue8SoF3N
 CT3JkeBTOX1N4IpFyZRwl5vm46msrNPtpauTUkk05DWjm0mohVc2ocypjRtqz1GCWcjKY9BaC
 +x4gDJ7rWWvpJc2dokp4q7ha8zjDe1pZmDOSI/ZZQSGe4GagAYf3ZzZUfhDG1oJvZM9ppSNLS
 /mNGhHZrJZc8yz0FQOGPgmylB0urxLi7VGgm/eyX2vFIyZlJKmWb4s0yUgBbZJpVoG7iZevR6
 lZUnngZeC5DUEer/Rx+mMe7lvKXeVLsXfsZoq6enHvh2ZexyKQwZ407O+ZlZvpTHRaU+PHmgG
 D+d/hL+EEopG+3ldXLzFu4NeEhj+0yFrYQR5q4UXXQhk678l4n9YEOpe2+CiHFOJT5QAszaDo
 g5bTQ62CU8yHTYkhHk20oT8xEjG1E3UzlNNiW16Iby6klYF1hi7xWpcPperoVpLM0Wi+R3b8R
 RDubcj+UQEd6WE4orjkqouuUUdRuYDHiTU14Elj1zW/QHoXa7TAJTEBvGkXtm7fxP9yNhyALC
 HbehjKGnlUg0ZFKLA0/Ckn8gvRW/ARlAesHZzRYs5byUz/UgHVt02w42yQewijDepCxSBwvWH
 YinBkjc7txhlICFBMRP8uG+GpVbKccn6g4IDMhWuzaZh+g5YIP+x4NSpGoOE=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 15 Oct 2019 08:55:00 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 15 Oct 2019 08:54:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] macro parameters and expressions?
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

> BAD:!!!!! #define MACRO(name)    snprintf(pg, PAGE_SIZE, %u\n", ptr->name)

I hope that a missing double quote character will not be overlooked again
for the specification of a format string.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
