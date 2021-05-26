Return-Path: <SRS0=hedW=KV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5394C47082
	for <cocci@archiver.kernel.org>; Wed, 26 May 2021 16:56:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277246105A
	for <cocci@archiver.kernel.org>; Wed, 26 May 2021 16:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277246105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 14QGubh0008575;
	Wed, 26 May 2021 18:56:37 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B9DDD7737;
	Wed, 26 May 2021 18:56:37 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A32843E3B
 for <cocci@systeme.lip6.fr>; Wed, 26 May 2021 18:43:23 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 14QGhMeF004554
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 26 May 2021 18:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1622047400;
 bh=lXoNSXcHtPYGxeyMSsPSO6/gWpSLtCpPIi1SuvdKFZc=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=XuTWdROfak7WNCjwua3OWSx4K4CXPZm0PBpjY1e4Z5iDlxLkh3+PJoijwDA/Z1lYu
 gDUTYilDTpc+mW9KP2dFRRSttdvXOMRlaXcOYJaf8nNq6ISvwZtAZIXfJ6rn78WGCt
 rSLpYkrB5dI86fuHo6Tvyuk9YaqguphIFCkGmBcM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.69.98]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSFY-1lxNMs38Ug-00WXeo; Wed, 26
 May 2021 18:43:20 +0200
To: Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>
References: <cover.1622024972.git.sylphrenadin@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <a205b3d2-5da2-8ed5-26a9-2103bee9a534@web.de>
Date: Wed, 26 May 2021 18:43:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <cover.1622024972.git.sylphrenadin@gmail.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:XwDcGYmNJdHR/sMRRn8XG7GAZtouyDinkONx3ZLR9UrVJ39kWK+
 NnTiT8/QGDjKfVc+tsOkDOhxRHXRriX5SILzz+hUigYV0wNt3/av1S5SmUR1iV9VmyaptI1
 zUPtiqTF8GFuVUI/c1+BlNBvzb//y9Q62IKhLzQHwB+pJLFdmGkrHSLnXvmqIOckuDIfVA0
 ul689HyznZ5eGSnBGFy4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IJScND6WWfw=:c562s36xUvHjV5iWTnwbe7
 tgpJRGfMe8j8G4fzWXKVdIY5+axzWA8kg/U+Vyt8tA6QxLrqxe0nMVhvN8kPwjQXTEOST5+s8
 QiMMl+KtkWutQT/W1MRO4TZ0tiVP1zj/e2kqvke41LkzkFeCtq1xon2+4JAVl59QqJ2ZHrUGl
 VBudt/R/DuWEw1iZO9wejT7vhkJFBBJmUmwLMcvi20a3pPxPkTeeezPmggbKD0HFy16cqOv35
 mu5XSy+xM0oRwcl5PNjaUx+Vx1ucqEYAAbDJ0kTzFd/7+TDdJb4EOYgkF8DCntboBnz4Baj/A
 w1j2TqbJLWWxip1Ty2uKG9v/ZWH863lRAGopb+LgPIS8jXgzKBsJFGYXa3BQdy+Exu0ya/NdE
 tk9lVfWTwBxqn/nZ0TPhyLeyJMYXVOZwdsga7suvJB16wzzLSfwB156iFF8iwj6n8QcdHlnph
 3KQxxduoeWxuXdUF7AkkUK4b4gkBhHih8nuj01nrJPn+OrJf6DssA+SctDBnu1r+4JOTF5FNK
 N3/f2TaG+lfcsst3BtE3gh8z3vJJjUk5SQGcXF2epaY5XN0wkQTsH5iJ15GE2R3k9hyMMO6fU
 XFDaTd+OGRr/ljf4MFwcs1+zchbQW7E2WOvJAgCpYOSKW187+ig8SOB/gIND2q1w7TUkvzdo7
 APWDmvU9mzA0vpnTLJJ1OGQkYC0ThPNIi1DG04uto6Og3R2RKNhjEDwbnB4x99Dbm0qdfsQ1r
 9ku8WALqs0kDTY4BlLL5t2W7J/CKc7VxD7xF52dZcBLRwuvpigC4tBe0XYmPvHx1WKQel5NZP
 ccPxb0WcB8s/v+ls3x9/LwkVhSlNNRp2t/REqGnakWjqdKGIxpyS5GmEDY3MCaZsvvV8/ORHw
 wG6PspCA64mEvOsYJupJHZ7wgmrHpODv1ZNBl+oa3xaukKJRrSwKmQ7iOphtpmCFiukJEHP4J
 I36yi08zqRgRcb8+Sr4K42QZ7fXIvLAHeTovyJ4qk0RoFEeqBSN9E8W7AqSFK44BMP9C1CCa4
 bDkwO8U3/UE+hvf5zLHCOt+/hoocmnb4psks4twZyae/i+wzV+AI85Zqd/nRd/OvTh6MWOvwS
 yEXV8aDeSlj3e3Ju624ps+tY2t2GsZFBmsjfGK2MqtchfezS6iWmALlfi6ydaJPO92uqJeooH
 MQb08wnXOBaeoxGl2fN6hF/7eJvAyzh4BztshJWlMJzqaGB2T5wDhkAa9IIplmAC/FJQM=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 26 May 2021 18:56:38 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 26 May 2021 18:43:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 26 May 2021 18:56:36 +0200
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 0/2] Add "use-patchdiff" option
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

PiBUaGlzIHBhdGNoc2V0IGFkZHMgYSBmZWF0dXJlIHRvIGVuYWJsZSBDb2NjaW5lbGxlCj4gdG8g
b25seSBjaGVjayBhbGwgdGhvc2UgZmlsZXMgaW4gYSBkaXJlY3Rvcnkgd2hpY2ggd2VyZQo+IG1v
ZGlmaWVkLiBJdCBwYXJzZXMgYWxsIHRoZSBmaWxlcyBvYnRhaW5lZCBmcm9tIHRoZQo+IG91dHB1
dCBvZiAiZ2l0IGRpZmYiIGFuZCBjaGVja3MgdGhlbSBhZ2FpbnN0IHRoZSBzcGVjaWZpZWQKPiBj
b2NjaSBzY3JpcHQuCj4KPiBBbiBleGFtcGxlIGZvciBwYXNzaW5nIHRoZSAidXNlLXBhdGNoZGlm
ZiIgb3B0aW9uIGlzOgoKSG93IGRvIHlvdSB0aGluayBhYm91dCB0byB1c2UgdGhlIHBhcmFtZXRl
ciBuYW1lIOKAnHVzZS1maWxlcy1mcm9tLWRpZmbigJ0/CgpSZWdhcmRzLApNYXJrdXMKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBs
aXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFu
L2xpc3RpbmZvL2NvY2NpCg==
