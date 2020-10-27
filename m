Return-Path: <SRS0=mBJ9=EC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16242C388F9
	for <cocci@archiver.kernel.org>; Tue, 27 Oct 2020 10:44:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E510220878
	for <cocci@archiver.kernel.org>; Tue, 27 Oct 2020 10:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="D75Z2do/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E510220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09RAhoWF024996;
	Tue, 27 Oct 2020 11:43:50 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7478D5C2F;
	Tue, 27 Oct 2020 11:43:50 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D343F5C18
 for <cocci@systeme.lip6.fr>; Tue, 27 Oct 2020 11:36:55 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09RAat8h023361;
 Tue, 27 Oct 2020 11:36:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603795013;
 bh=LCDEhvzOSwgaW9p7SAqsP4igd8WTJT4VbpS/jAas8rk=;
 h=X-UI-Sender-Class:From:To:Cc:References:Subject:Date:In-Reply-To;
 b=D75Z2do/rxf9jBH6wlW+qFTBVrrYdq6S04Mc/AfZAUtoUKVjEXRlPK+EuePOjaEuC
 MO0Qk8aGWQaDBU3VP6Qvr2u4rrIfDc3+KdHFD+4pIgG5em+1P2Jqz0IKGqUmkQAfUm
 yzgJlik19dSneL+W5tDGXJcSF0fS6u5wdUn29zag=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.4.127]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7WH-1kxvcg0dBf-00Ucyg; Tue, 27
 Oct 2020 11:36:53 +0100
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix
 <nicolas.palix@imag.fr>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>
References: <78f8b08754dde286adf7e11e1eeb3bb8ad500d8b.camel@web.de>
 <acaed49b9195d47e252a0b67551f87e96324d004.camel@web.de>
Message-ID: <45310257-201a-40ea-348f-b8e909c3775c@web.de>
Date: Tue, 27 Oct 2020 11:36:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <acaed49b9195d47e252a0b67551f87e96324d004.camel@web.de>
Content-Language: en-GB
X-Provags-ID: V03:K1:jVULiKWd1D/B7hWOQQxMhmAB+3v7v9b9w6uPMx0dKh7u622mCzo
 Fdre9kA6vA7WcPoONoh6/yump+rfH4T3NdrZrNUxfa7XO8pyvnKdaefY9fKeJBm9ovrnQNi
 x2E+t8VkJb4tI7cHfZlM7qFqXKAT7RMAGQBH4UTqfXYx2mpOLsA7SZ2u6giYNmGe9oVZqem
 35q6RqNHwwleRBc0UT2hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ZH2Vl5WHn8=:0dnx3GqlRNFMdPPCGbjMzz
 t3wxcXFzkRwRUdL+k1oWNLR4H160E5mGrOWSUobilc3ncO3urslwBNvp27vvJ1BsJ+fo/Lv+n
 ZpyivgpbZCS7BKhqIJYTAqafAt0okgNHSddqVQSUNPhNSaBAtjsQ8qzNtmdv8npuknvY4UpVF
 uKCcmW/hnTXc6pEHXxreSZ8Xz5n6inOHmRhr7hXr3NzaLnUgVJiBm2I/A01+AgGuaBprrhR/d
 W9zM8HVJ7gUhioFUaymZK3JW+U9OO4fIoiUr9jXVCtphNXaVFL4j0v5dK+UC19QzG6JDm+JjW
 Hi0vHyXH0g+2Y7XMP1dYMhXivajU61l2HlLPWJusYkazNDuP1EO5AslCVCZNZ9bK/HLFnV/ht
 SaITE/kKHAOQe23/cjoTK8GVV2faP+NY4yoZ4i6XPzMf7lcWAjvMzrZCCb+yINS6MonSdh+6j
 ayaXX5h0edDJQEV/v/FhvQAQ4HzwNmNTK6jinDbQDAjdiRLFUnA0fmJpSNWpv+q3dzg1BPlZb
 1o30rPHeu+Y/V65NfRQd5FaWmDCABZyCAEca30V/WnmYqcIdY96YjiPUNg4iFDhC/tlgjToMc
 Qnujauze/PeraPCcaOS5HP+U21efbIUcDg2N5zaagS2CGVJTztLP9bBw+vzhz4Lr+0vLK/3sE
 b3fj0Y6k9JOI3xaq3cIdyUEozug+8sHaGEru3l0z5o5m4/j3RMG5t5vBMJjIM+4U2Vi/mkWqI
 qnpmfZMD3EmQSaUFj72U6YqgEZsCCeAwJ5gHdfvjFpDCNyP08/iJKp5c9OznAPR4bjXiGQxKQ
 RIdobp0S7n29YVKuSFkDHKnWskmXR93t9z98oifT8em9ztBbKQyojrJ6eE0TFgdz3BF2NniFa
 /aREloFUV+VUnqnEwODQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 27 Oct 2020 11:43:50 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 27 Oct 2020 11:36:55 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 27 Oct 2020 11:43:49 +0100
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Cocci]
 =?utf-8?q?Coccinelle=3A_Checking_the_relevance_of_parenth?=
 =?utf-8?b?ZXNlcyBpbiDigJxnaXQgZ3JlcOKAnQ==?=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

PiBXaWxsIGFueSBhZGp1c3RtZW50cyBiZWNvbWUgcmVsZXZhbnQgdGhlbiBhY2NvcmRpbmdseT8K
CkkgaGF2ZSBmb3VuZCBvdXQgdGhhdCB0aGUgZnVuY3Rpb24g4oCcaW50ZXJwcmV04oCdIChPQ2Ft
bCBjb2RlKSBjb25zdHJ1Y3RzIGEgY29tbWFuZAphbmQgZXhlY3V0ZXMgaXQuCmh0dHBzOi8vZ2l0
aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxvYi8zYzAxZGMxNjk2ZGM1Y2NmYjMxOTY3
M2YyMDVlNDkxYjU3MmVlMGJlL3BhcnNpbmdfY29jY2kvZ2l0X2dyZXAubWwjTDkKCkkgaGF2ZSB0
cmllZCBhIGNvcnJlc3BvbmRpbmcgdGVzdCBkaXNwbGF5IG91dC4gVGh1cyBJIGhhdmUgZ290IHRo
ZSBpbXByZXNzaW9uCnRoYXQgZGVzaXJlZCBwYXR0ZXJucyBhcmUgcGFzc2VkIHdpdGggZXh0cmEg
cGFyZW50aGVzZXMuCgrigKYgZ2l0IGdyZXAgLWwgLXcgXCggLWUgZm9yX2VhY2hfbm9kZV9ieV90
eXBlIOKApiAtZSBmb3JfZWFjaF9ub2RlX3dpdGhfcHJvcGVydHkgXCkgLS0gJyouYycKCgpIb3cg
ZG8geW91IHRoaW5rIGFib3V0IHRvIG9taXQgdGhlc2UgcGFyZW50aGVzZXMgaGVyZT8KClJlZ2Fy
ZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVt
ZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
