Return-Path: <SRS0=jsWv=J2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CEBC43462
	for <cocci@archiver.kernel.org>; Thu, 29 Apr 2021 18:13:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B8F61441
	for <cocci@archiver.kernel.org>; Thu, 29 Apr 2021 18:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B8F61441
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13TIDrEL020814;
	Thu, 29 Apr 2021 20:13:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DC8F87813;
	Thu, 29 Apr 2021 20:13:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D38DA3CA1
 for <cocci@systeme.lip6.fr>; Thu, 29 Apr 2021 20:00:58 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13TI0wKP014957
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 29 Apr 2021 20:00:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1619719247;
 bh=yg/wCQBLr83rKid4ieb0etrjkX30tfgEsZhWGakzwtQ=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=ba85QmllxjU7+EDIZsGErgqrRA7omRgJBbginXMtenO/WsF0JsS/jZXMluzR1Qo03
 WsQEinLfaO3tFFMJcvn0f4dERh/YQS9/Wzo1lgi1iGAGkU8ooqQag8wX0pAYhDfqOO
 H/ns4440hvGLhTfXi4XQK8spOicqUAAhLa7wZvw8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.41.147]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M0yeJ-1lJ0Hg1rX5-00v6CK; Thu, 29
 Apr 2021 20:00:47 +0200
To: Julia Lawall <Julia.Lawall@inria.fr>, Johan Hovold <johan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix
 <nicolas.palix@imag.fr>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Qilong <zhangqilong3@huawei.com>
References: <20210427141946.2478411-1-Julia.Lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <1837dc90-9df3-c512-ff6a-8504aa51b3b2@web.de>
Date: Thu, 29 Apr 2021 20:00:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427141946.2478411-1-Julia.Lawall@inria.fr>
Content-Language: en-GB
X-Provags-ID: V03:K1:kJL8Qx4cr5/KJcnUAfY3YzfYe4CUt7J0ddR2Jpejs/jzpEx+fem
 DJ7L70VngIx42xqjQgK7O1TM/enEmAs+tDqlfzx91WPtXYvzlxKWfzh9TsOfI67CiTJm33n
 rpFCi4dHItGr3awyxoAKsDvsFsqugkUAP70jlGmgJMTQUxuNZ9NgvaNbFn06sdZcrKeyIoQ
 NeGmoAZBRyZhok22zLdhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8W6IxkE3OSE=:59CeSfCJH/O4ZkxDlkVp7a
 v+6AwuLDqIG9Gkel6gPw6wrtHbQeA99kkuQ/b7L6Jj/u8dOxidzv/Z3aAgZBgBpYgjnmTt+WO
 LhiuzZGDwTeK9HN1SxjxjaDvtgyryGUKZWUNxMO0HIhG/m60tCN1AjpVuY7dQEjRZhbdWDwJO
 HI7HQfXJJfeV/GRQQK4C6ECDxFin1LQLArVY28gFnwQerK1CgdODA6S/4BojYqBlt59ydAWGq
 YPekW9mN4na77iDpQRs1fCyRPu7P9Lt7qNP7AdHVR714GyIaKfwB0qxuMARQzWAwqOT1jxDn2
 R4TNnoHxq0imbxW1rz0ci2QDMZaqDWJJv3ksDKO4HedIkrIOrhnd8qicwss5W9l5wR+2ZZ532
 k34VZNi0QN3CNL01JgUVlEGzh0URuIGIuZL+9MnUc3jafjqE5apxovaBacaDYspxbiP168TC8
 vr+yTqfDQllQPpDARzm7RdWJaPUbqac9X7WI/R+hxi3sIKE1Iz6JvPipSZW6jEyVuAeWejzF7
 m63B5FpFD+aq98HrlMweZH4pKPPwcO4bR18vjBC8i/5uKM2Q/cJsvmuUXVzL9S0GpkNofYLtF
 djNF8YU4DOFlUgzN6AMJuZB2GZIGAeKYu/MfrjfyS/WFGhrjt8zR2q2HSCW10nuI3FYWdkZuW
 /hS1hEJeEsbQEBQKUhacQtHeb62FH7buAGjlrDjpp8XV912CrmHtiDT4a1mr10JyL9eeXfzDb
 i4PQhKTnwY+UmIulnSs4g43gizFU45HA8RWTqEEkXiF0FZ7dYPlafUBMHhCKRuaDfeczAdxzH
 N6f6rGZVGILZZ620Wj2Uo0ast0pOEjBntkpLvblo8HTOWwsJT6mwqH4JOwLQSYKhmzWV6MLfZ
 ko0vC+8dahaBzw3ipjVA7Ki1hRUxmWnyhp0+wYM2V8AYtzH0M3DkA4UlELFQpQ0I0W+cjwvX3
 s5jH2BGJlxtEXPyPZL2ZdtY67YvmQPSqKCXn7nCEJLZmldJTJKLOK/Cu+pFxdHhUg0lF+3hDW
 ebAeDWVqfyZQawHJpNK0T4AxREEX7VqoSnrfuvRZdhPlCvG/Yl8sOfB1zLCH9Got7C2Yrquto
 k86a7h0RG8Y/X25pAlyaVGLEOZi3svrzMc3etcUA0/RqHmTkypfqBm6aabREt+Y4esCp7l9mq
 OnIq2Q2IqI7EkJgticaVRizDsrEV50p2oDh9FIR2Ik7LRCmV0kRzv5mUEB+A1a1WM1l6DBbJ1
 0Dazyp0hKyVO+Ej0G
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 29 Apr 2021 20:13:53 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 29 Apr 2021 20:00:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 29 Apr 2021 20:13:50 +0200
Cc: kernel-janitors@vger.kernel.org, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v4] coccinelle: api: semantic patch to use
 pm_runtime_resume_and_get
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

4oCmCj4gK21zZyA9ICJXQVJOSU5HOiBvcHBvcnR1bml0eSBmb3IgcG1fcnVudGltZV9nZXRfc3lu
YyIKPiArY29jY2lsaWIub3JnLnByaW50X3RvZG8oajBbMF0sIG1zZykK4oCmCgpEbyB5b3UgZmlu
ZCB0aGUgZm9sbG93aW5nIG1lc3NhZ2UgdmFyaWFudCBtb3JlIGhlbHBmdWw/CgorY29jY2lsaWIu
b3JnLnByaW50X3RvZG8oajBbMF0sCisgICAgICAgICAgICAgICAgICAgICAgICAiV0FSTklORzog
b3Bwb3J0dW5pdHkgZm9yIHJlcGxhY2luZyBwbV9ydW50aW1lX2dldF9zeW5jKCkgYnkgcG1fcnVu
dGltZV9yZXN1bWVfYW5kX2dldCgpIikKCgpXaWxsIHRoZSBQeXRob24gY29kZSBiZSBhY2NvcmRp
bmdseSBhZGp1c3RlZCBmb3IgdGhlIFNtUEwgcmVwb3J0IHJ1bGU/CgpSZWdhcmRzLApNYXJrdXMK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFp
bGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9t
YWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
