Return-Path: <SRS0=bRnq=UR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0A0C31E51
	for <cocci@archiver.kernel.org>; Tue, 18 Jun 2019 06:34:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2441021783
	for <cocci@archiver.kernel.org>; Tue, 18 Jun 2019 06:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="UvhuDWXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2441021783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5I6XwMR019422;
	Tue, 18 Jun 2019 08:33:58 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8F4577779;
	Tue, 18 Jun 2019 08:33:58 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 252917767
 for <cocci@systeme.lip6.fr>; Tue, 18 Jun 2019 08:33:57 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5I6XuN8021196;
 Tue, 18 Jun 2019 08:33:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1560839636;
 bh=7Dq+Ajm7jAwZXb3zni5wO9/JSl40jeed5vZmpobPbOs=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=UvhuDWXrpINffv2j91m/aYAWnKEjm3DojQzxlK2gBbMbV9mY0W+njSF7AMKRx9Zg5
 NGWLpmcKui15WFta2lmLSAKkoh7sjgVhtwuLbl4Y434j2VtpoP6bmt/DeTlieGpf3y
 DFESaLjKTnoBL9LkcGd1uMFrYk1DIc+IkCfQ18ro=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.86.175]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M09z2-1iSkq816mS-00uLq6; Tue, 18
 Jun 2019 08:33:56 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <f9e28910-d42b-cdea-31f4-1b084db33023@web.de>
 <alpine.DEB.2.21.1906162214390.2537@hadrien>
 <bbf7e602-0a78-9595-31b1-b4dc70195df2@web.de>
 <alpine.DEB.2.21.1906170747030.2965@hadrien>
 <20258ea9-f69b-a0c2-01ed-e3ee8681bdf0@web.de>
 <alpine.DEB.2.21.1906170807290.2965@hadrien>
 <f66261cf-b6d1-5b2c-7756-a17585cc0ce6@web.de>
 <alpine.DEB.2.21.1906170830240.2965@hadrien>
 <c5a19a87-4948-196c-4f74-872c207061ed@web.de>
 <alpine.DEB.2.20.1906170938530.3699@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <edbc59ca-2c16-bd0c-df27-ec2b9983d0e7@web.de>
Date: Tue, 18 Jun 2019 08:33:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1906170938530.3699@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:Agiau75aK2Up5Q7WBtHEi7PE6Uto+dnsmmsIvn4bY7aWb2hWl8w
 72DHLkVOq4HIwkxIYX4TMtpWzmOTwh1cOq1vthGYmIemkoT8jJTvE6RPEiYPJXNmcBZsq4o
 qlfmwDdHJHCa4VzcKqMx9CYNjemhoo4fmn9d6Gs0HEZBhTUhDnHAlHQno8uvWRj8wllrbAa
 7uLfEHjC3HOrdEzV21LAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bKwSPxVYjIQ=:wYelPRKewhfyJqvA3EhJ8C
 5oxY88Dlr0BxiKySLXM0YhZ2BuBPhzuifnBZLk9itwDRoHHJkvXz4210V9/2bBkUVl8WtF97V
 HtXmaP9WDevl4Ajf0rMRo0AYLe63Vw9HroF+Af3oq8uHK6rVQc9bQ2c7BS0DSfU4z0jbc3oEN
 eKY4ihusefJOdD2a3b3C1jmCsdvSCDKnkR1hrFC5HWtFaAr/C50CsWrW29Zr4oDEs8jPqw52q
 JzCxiAYbc2Nb+bYI60AN4Dp7nDQZvUQ9hWPJi1tzCnhOu5U6UuKid6UCHiST2Zib/zuEZ6dDM
 ZGbzcHCBoUPc7rr4WsIkP+w694uHyyuXzv+iiARPK0dFR2hHjf4lTd+SgoTE8PSmXkn3t77Sc
 48gy1DYLGOD6BzOgCj/Y0XX3vkr3oF86fImwBY5Nvg3xfeJpnK3ohbk5ZVIJljpF8HiMDXtC6
 X2OMvL6djEYZ0kI8U3p0+EHFaDXwySrZZFRoh4AE1HxYql7+i9Iq9mb95VSQf5/Klu+J0W/X+
 rw1oZlbq97HmgCbnu0GyWOC5X1L/1CBFyo3G+dFBkftMgP8ghoY0BgWDHpLYk6DEmV+U4BbZC
 nf3pyyAIY4U0pm96GUylBbUULAzbh1UI8hTvCz84CEpE9IA5tPE6/5dX3nqBeE6QK/xO2xwY5
 mAOJxSVwtS9Oa+JkX97UXYKBZ1YFxTEunvp/+iWGDSsrjygmJ7ezzl/jaI7ugy0VBWEp5OK65
 kCor8hXfiv6gVb/kIErBkfj4aBAB1+f3/XLXv15gIqtlq0Qb56Fgc6ChSodky2UB1pUuFswQM
 Fw/zTVO2KrT9dDNmhb1A+WUwCXxEhXXCmDTI3z1xyZ8mJqKLsWwia962bPBlbPLBl4rH3c+1R
 Rju78IKv9sO/QTDKvR+cuhP6o47X0b3gKzRByZHj3GWZwXNNW6rg70D7ihunPpjpUJHvBa+G2
 45lzyjZhfFwQ+WrNVJPrwF33GzoFYIqcLJYjDXxT5+QKwvtPSuqy6
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Jun 2019 08:33:59 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 18 Jun 2019 08:33:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking for a null pointer with SmPL
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

PiBBcyBJIGFscmVhZHkgdG9sZCB5b3UsIHRoZSBpc29tb3JwaGlzbXMgYXJlIGFwcGxpZWQgYmVm
b3JlIG1hdGNoaW5nCj4gYWdhaW5zdCB0aGUgQyBjb2RlLiAgQXQgdGhhdCB0aW1lLCB0aGlzIGlu
Zm9ybWF0aW9uIGlzIG5vdCBhdmFpbGFibGUuCgpDYW4gdGhlIHNvZnR3YXJlIHNpdHVhdGlvbiBi
ZSBjbGFyaWZpZWQgYWxzbyBieSBvbWl0dGluZyBDb2NjaW5lbGxlJ3MgaXNvbW9ycGhpc21zPwoo
Q2FuIHRoaXMgZnVuY3Rpb25hbGl0eSBiZSB0ZW1wb3JhcmlseSBzd2l0Y2hlZCBvZmYgZm9yIGEg
c3BlY2lmaWMgU21QTCBydWxlPykKaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2lu
ZWxsZS9ibG9iL2M2ZDc1NTRlZGY3YzQ2NTRhZWFlNGQzM2MzZjA0MGUzMDA2ODJmMjMvZG9jcy9t
YW51YWwvY29jY2lfc3ludGF4LnRleCNMMTI1CgpIb3cgcmVsZXZhbnQgaXMgaXQgZm9yIHRoZSBo
YW5kbGluZyBvZiBhIHNvdXJjZSBjb2RlIHNlYXJjaCBzcGVjaWZpY2F0aW9uCmxpa2Ug4oCcaWYg
KGV4KSBpcyBlbHNlIGVz4oCdIGJ5IHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZQooaWYgeW91
IHdvdWxkIGxpa2UgdG8gc3VwcG9ydCB0aGUgb21pc3Npb24gb2YgdGhlIGNvZGUgcGFydCDigJw9
PSBOVUxM4oCdIGF0IGFsbCk/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3Rl
bWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2Np
Cg==
