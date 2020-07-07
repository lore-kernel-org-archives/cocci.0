Return-Path: <SRS0=xwEL=AS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76855C433E0
	for <cocci@archiver.kernel.org>; Tue,  7 Jul 2020 19:53:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38E42067D
	for <cocci@archiver.kernel.org>; Tue,  7 Jul 2020 19:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="c9ZR6rAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38E42067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 067Jqlpl017873;
	Tue, 7 Jul 2020 21:52:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2D3BC44A7;
	Tue,  7 Jul 2020 21:52:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 234813FFB
 for <cocci@systeme.lip6.fr>; Tue,  7 Jul 2020 20:30:18 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 067IUHbv024131
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 7 Jul 2020 20:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1594146617;
 bh=cZENA1YVwRyih1M/HntCD14o9211SGa+IgF6cJ/KWDY=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=c9ZR6rAMP06GBA5nZ9ajseJyIQBWlqP60yHkN1A8tdBmDFU+uLcTC4FBuwI7SWq0p
 K84g3laXSNwKHs1LAn8TBJao+O3QwcWnJPt3QhH77esups/lg1iKoEx5z/kFml9zxp
 PXq+GEElsxICTcwnIk6yyPq3BZIIU2/zVSW1VP+Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.121.241]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQcl-1kayXA1PHd-00i477 for
 <cocci@systeme.lip6.fr>; Tue, 07 Jul 2020 20:30:17 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4b3bb651-5db0-021c-cbea-347eda0e95e0@web.de>
Date: Tue, 7 Jul 2020 20:30:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:ia/UsfL5twnhpq9hUWlnj1UKEsqhkvCfOaxfGb4cicpr+759J8k
 VZs3jD9hjvWBDIofUGySLj/A2mg6EQZc/mg1ljZw4HH4nGYuVR/rC3NPGcwn47h1sutIZ9u
 a4CYm/Den8ONKlkAnaktuRzrGTQBmzAQT3/RyYUvmAb5Bg+B4h5A0a9RtpdmBxVXJJ2Fifq
 YRxt9fRGO7f+p8MMc2PZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xFPXG4JjDz0=:rT3/kXgf55QL5qdmlQ5PeW
 IgG0qkSnV1+EJlga6GmswsqCVTUzW95p7sKSkUyQnACxCFkaaaDcrcvWYui5dth+UHjiyvvVt
 Dr3T2xv2kRZ2jDY2C7Lb2kTbZqu8l3AUC6Tv710cVgL3dJso22QOC5Sq1BTnuXRo/LWSNFPvu
 OW1VHZZ98yVrO/3IhhO5nOyOlQfIPVl98nYPBePHL0TN5puRkjVDidUxL43FuMi8XDVaG6DuT
 qtVH4ul54CQCLdiRCP1YgK+MQ2vu//i/BfbmxAxPv8k5aDmJ9Qq6AirQXk7yFP0TqOtt0lI1V
 vlnqhxrVUj/IERrKPF9rPCj5afy29UD09Hx7ZGNJK7zKSMffvkZex0iQ44uhzm6ohIi5xreMO
 HhZ0UlSy3EUwh54i8e9f82AVj+QpbokN0rP7tyzPxJU3I25IHjDEvU8z83xPyP9MS7XHzdaSz
 +N30BKwbwMVbj+H1NOHL/bHKQDEqdRkNzUAmqLd4xQXQlsisHOBMGb6oLsNinGx4oI95iL1r5
 +1Gw465x+aC4dwQVNKFcs5LzC3E1EafCG4NTdxen0rxwuCE0uwAisQvGG4W2NeiRmz3SGMH/S
 AVToI53K1KDHMw4x+JqxS+4SSuiKHSm/g4FOSGvAIkFTBpldgfpA957G2ToF9CZmfPDR34ar0
 5bAbKlmNE2xN5HJnzgNhfOxHHcxp1e1BhT/jlRn5NT8cbzGvO67Rk2r42uRKL10xB8GBZC5Ft
 V9hX2bP+1QmqKbsWr9pc3EGf+xIUF+PTYWanB8nFBIbZ7fI3muTXTxfb4gcr5Nux5SJFuhV5B
 Qe+Elsy1VdPujp7/4H/0lT6tAme54aI1aLIjsCiKitbKoRKkDtI1LGHICcB7Qy74xG0Ypcug7
 m+Dugv0IAehJahNWJEvQjOxRFddh9tbyqdDl1T0RyFuVp6SiUhXqXcNaU3WmHVCUI7PoHpkj6
 I9Od63lJkRoJt8hqJ9rT0JNaKWQNf/J4Y7+pkuyLXpYeLJweaDxZlSF2ksn485FtESZQZEqdL
 qBAlq+Cp5oTPTyrnO8LDvRXJnRRmLF4+OeGB6ql1Cm03Pai9/qJ+J7t+Jnf2VBAnb3Q7EpLJL
 cYYCmKLxZT6o0y9r5/7qHERzZAAVsg19e2JCjRnsOYUtfMt9t6OgR6jkyIxAqFEhx9XE6NIUb
 ccqiruNjxe9frn9YLTDX98M1fJmWNhSRWDmGTMpxt7xa86WeMYIQg+H1gkpRFcJM2p4Jo54yn
 CbV/5WzEKRwjXRmlYbXL+NWyhiasCT7vqn4Z01g==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 07 Jul 2020 21:52:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 07 Jul 2020 20:30:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 07 Jul 2020 21:52:45 +0200
Subject: [Cocci] Adding labels without indentation before specific
	statements?
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgYW5vdGhlciB0aW55IHNjcmlwdCB2YXJpYW50IG91dCBmb3Ig
dGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlCihhY2NvcmRpbmcgdG8gdGhlIHNvZnR3YXJlIGNv
bWJpbmF0aW9uIOKAnENvY2NpbmVsbGUgMS4wLjgtMDAxMzktZ2QwZmQ0Yzdk4oCdKS4KCkBhZGRp
dGlvbkAKaWRlbnRpZmllciB3b3JrOwpleHByZXNzaW9uIGFjdGlvbjsKQEAKIHZvaWQgd29yaygu
Li4pCiB7CiAuLi4gd2hlbiBhbnkKK2xhc3RfYWN0aW9uOgogYWN0aW9uKC4uLik7CiB9CgoKU3Vj
aCBhIHNpbXBsZSBhZGp1c3RtZW50IGFwcHJvYWNoIGNhbiB3b3JrIGFzIGV4cGVjdGVkIChpbiBw
cmluY2lwbGUpLgpJdCBzZWVtcyB0aGF0IGluZGVudGF0aW9uIGlzIGFsc28gYXBwbGllZCB0byB0
aGUgYWRkZWQgbGFiZWwgYWNjb3JkaW5nIHRvCnRoZSBmdW5jdGlvbiBjYWxsIGF0IHRoZSBlbmQg
b2YgZm91bmQgZnVuY3Rpb24gaW1wbGVtZW50YXRpb25zLgoKQnV0IHRoZSBMaW51eCBjb2Rpbmcg
c3R5bGUgcHJlZmVycyB0byBzdGFydCBsYWJlbHMgaW4gdGhlIGZpcnN0IGNvbHVtbi4KSG93IHNo
b3VsZCBwYXRjaGVzIGJlIGFjY29yZGluZ2x5IGdlbmVyYXRlZCB0aGVuPwoKUmVnYXJkcywKTWFy
a3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2Np
IG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYu
ZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
