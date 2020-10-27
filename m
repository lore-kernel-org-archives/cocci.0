Return-Path: <SRS0=mBJ9=EC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87ABC5517A
	for <cocci@archiver.kernel.org>; Tue, 27 Oct 2020 12:04:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33B222264
	for <cocci@archiver.kernel.org>; Tue, 27 Oct 2020 12:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ElrrCTnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33B222264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09RC48xK029479;
	Tue, 27 Oct 2020 13:04:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B01C75C2F;
	Tue, 27 Oct 2020 13:04:08 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D63BC5C18
 for <cocci@systeme.lip6.fr>; Tue, 27 Oct 2020 13:00:40 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09RC0ddU029404;
 Tue, 27 Oct 2020 13:00:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603800037;
 bh=J31LrM6yzBxxKRZay9NE7rdT99qCgW0W8MSeWf2f+bY=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=ElrrCTnuwbwodhS05jc8Rlx/u0QeWMHCrxNfwa4wtQ7hdTVgefZuQBrhJ4mmDD0s4
 NK9Gr+BH7n44xCzOj9rob3GEjI3b+NJiAVKbzq7iuzSDlchrogWxzwVHnfbDJ9Znvc
 FY8Hk+f7bLFGlBGa5zNs5RZXIMuI+GyDUKSmrG0E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.4.127]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mb8sh-1knf3O33M3-00Keko; Tue, 27
 Oct 2020 13:00:37 +0100
To: Julia Lawall <julia.lawall@inria.fr>, Coccinelle <cocci@systeme.lip6.fr>
References: <78f8b08754dde286adf7e11e1eeb3bb8ad500d8b.camel@web.de>
 <acaed49b9195d47e252a0b67551f87e96324d004.camel@web.de>
 <45310257-201a-40ea-348f-b8e909c3775c@web.de>
 <alpine.DEB.2.22.394.2010271155330.2847@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <bfb3e786-a64f-ecaf-eb37-8bd6b53cf38a@web.de>
Date: Tue, 27 Oct 2020 13:00:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2010271155330.2847@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:5J3SNzjWdzb9dTpWNMWtgehkSdhYuKURYCwaIYLBHl+7auXQ9cR
 bBJ9pZO5hdLMOvT4Gjilwzv1oRm0zCW1gVQgkAPRkjSLMKW19VqRB9cQOT7YugYGs2atjLw
 o1jSvdgWtV7DAyejz432x/WIfbuJFotsAwZC5jXc99BNhg6J1VxWJQ+6MX7OHsN08pznRNJ
 tvsD+GyFqk51d6L12IgSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HgcVZQHqrCE=:WYiBozbI+BpgYzYfnTpPFn
 JT2U+VIRvKtvkdrsww7GyCZE831P4NQTAjsbLs+dCkI8RInT2/PxJT5ou7ysYaSKEs42XbRA6
 iVx099TxaPdqwLZvDkuFb1KArjrzbky2KPbcAa0qUD1q8cP1TI+N97SYfvUGG45y3Zeq0MBf1
 RXSKHT7kt1v1XuMTx8ia4BXyvQMQes0XNC8ZMkpP49B0sYLWC/mhHEdAHKcE37J8xmJhocqIM
 0cuddmUBdmhYwgUGB6reFEcnZLNWkMJMzFMNprf0DZ/OyxPHjawtZGr98FTatohDxcFNNS2ye
 UuF6CrEGSMfusgi75wYeQdk/fjJrka+vxnHMJqJ5barG+HuMugrouR0RjHdNFnFzNLOxPKqya
 yUzFrUDk82w0seWqMdQFN1vXeZytr04rhVvsAqOe2eA62oFisIw9M5oiQVTkpdAfR464F/XXE
 Ke7IGe+FPFxAvUcxyrUdq2Zwhanw9ctsO7O5W9FtbJar2JATTY+i/v3rTuwUopXPbtnj1PsMi
 a5nRvRtEVNRIc2UxF2l6dkOzSZxmKloPJtbPuqLfsFkohczdbUyUemuRAsk5bpEGzTITjcDQ8
 wsgzwMk3psJn26gbssMCkBuTaUgfmatuMBohCxekGXhtJSJewxXZ5t6ca/55191/cPom6JrbC
 GXG0JWkKSaZFQPcREx+Ux9xvpAzMcImGtFTW1f0JhP2W4H3Tr5Ag6aY8Xy4PMJ5zg6ssU5iQv
 Pj7BaZu7n3OIas0FZMjY0XzXPgRLmZgLfRvMNLprnyGorlCYby5q6ONYIMTnjqSA6I0LMFS8R
 i6lQewMcagi6ir3qJLAARcduRpv4PTpAkm141xnKNXjjkOF4eXPBssssTnEsnCI4Q6ub0Asim
 JtpQB9PIIfn/NuJY7VQA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 27 Oct 2020 13:04:08 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 27 Oct 2020 13:00:39 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 27 Oct 2020 13:04:07 +0100
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Pj4g4oCmIGdpdCBncmVwIC1sIC13IFwoIC1lIGZvcl9lYWNoX25vZGVfYnlfdHlwZSDigKYgLWUg
Zm9yX2VhY2hfbm9kZV93aXRoX3Byb3BlcnR5IFwpIC0tICcqLmMnCj4+Cj4+Cj4+IEhvdyBkbyB5
b3UgdGhpbmsgYWJvdXQgdG8gb21pdCB0aGVzZSBwYXJlbnRoZXNlcyBoZXJlPwo+Cj4gRG9lcyBp
dCBtYWtlIGEgZGlmZmVyZW5jZT8KCkkgZmluZCB0aGF0IGl0IGNhbiBiZSBuaWNlciB0byBhdm9p
ZCB0aGUgcGFzc2luZyBvZiB1bm5lY2Vzc2FyeSBjaGFyYWN0ZXJzLgoKKiBUaGUgY29tcGlsYXRp
b24gb2YgdGhlIGFmZmVjdGVkIE9DYW1sIHNvdXJjZSBmaWxlcyBjYW4gZXZlbnR1YWxseSBiZW5l
Zml0CiAgZnJvbSBhbm90aGVyIGJpdCBvZiBjbGVhbi11cCwgY2FuJ3QgaXQ/CgoqIFRoZSBjYWxs
ZWQgc29mdHdhcmUgY29tcG9uZW50cyBkbyBhbHNvIG5vdCBuZWVkIHRvIGZpZGRsZSB3aXRoIHN1
Y2ggZXh0cmEgZGF0YSB0aGVuLgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0
ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2Nj
aQo=
