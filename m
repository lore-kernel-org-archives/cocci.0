Return-Path: <SRS0=SYYD=FC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C07C63777
	for <cocci@archiver.kernel.org>; Sat, 28 Nov 2020 17:33:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437AC246CF
	for <cocci@archiver.kernel.org>; Sat, 28 Nov 2020 17:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="RGTdjxGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437AC246CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ASHWp6N007297;
	Sat, 28 Nov 2020 18:32:51 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 979EC5C34;
	Sat, 28 Nov 2020 18:32:51 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4784A454B
 for <cocci@systeme.lip6.fr>; Sat, 28 Nov 2020 18:21:17 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ASHLGt6029413
 for <cocci@systeme.lip6.fr>; Sat, 28 Nov 2020 18:21:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1606584076;
 bh=ja6qTBV7z/wPDAJiDZcngJnbq4AgYnIpDeTDPLYxxEA=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=RGTdjxGcgNzSmkrt3iJDsArHeK+ajW7gdqp1XxRpd1cTGgV9W3mRt8qKOY5JOqb1K
 eE6q+8LegZ6ddjnKllxk05fvoayRbjwkLNJhkcNtf/z6Aj/Gtbz0aEnjcR4Uv2RhTJ
 VxrcqgcKcmtgi7+TR+/2BDiiXWEcH83lfdUmwT/Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.189.227]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMpCg-1kSczA2H4O-00J4Ls for
 <cocci@systeme.lip6.fr>; Sat, 28 Nov 2020 18:21:16 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <13b38013-8d4f-55fa-3c0e-ead782031659@web.de>
Date: Sat, 28 Nov 2020 18:21:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:Z1jB9LdgVbetvmY8X0zL8uFrzxK52N+G4Ogfj1d5pzSWfd8GEyp
 OLQWfYcaQNidBmv4uvo14KG2FdBigNjV2QQh5l7tgU04EhK+BCXMcoyr+NOL4QExd3z+7Pa
 K9koXpkGLE48CHkxvjRZnbw8uzT0kr7oNUXMmbXYLG2B9grrz9mjtFf1KGZ/AbUCcKQyWTB
 ouEIe/Y5usCBPzRQpgTMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/2O92OjxEZ8=:PP+dMyK6T1vAWtwnoZsAUk
 3MxMWD+AV6cmiOiwTHbJpfS0ZhEEfHYmn2dMI6bMYoRBEhEZLyEd2hj8QiKYQ56mL+icKMeD2
 Lah19yUszseNGVb+iEMM/w0sseItFIgv/9B2M7RFgGlKFIHG/i8k+nuqBDZ93EjQ1hbYtnlSk
 5Ab4u83+QM0iureMj4T3BqvW0S6YmvdwuB4kF6vov/rNOXaX6ID5oMRwRmLB+fWdD+OhBKgF5
 Ka9swjjcJ8ZbRL795EUmH6XW33uSYPCJS+Cf/aiuKH4cFVJWhsdRobW7XtaDG4ORUAVP44dVw
 hbpeuSa3bWXPDsh3zewHSi8H/ezynzFbSLAiMRimlfGV243rxMp/D9cwT4UJMzUxsV/9UetWE
 vv7a82WFvihZZnmV7KtGbu7YnO1Z/914NgjUJsyIX/tWdWOV3Y8Mjp365s1qY+umHIZayiQ/X
 SXyTL4xqtyep0iFxNF1Lvrc1sRyWrG9eMO/KtAuJlnDjAi0cdh1OkEk3Z0AsLr1Tj9Goevghs
 zY8BK8uxBB/YdOdaOGF2rR7g6K/6rzRcKC1cyyR5RwEPmqamTWpH2xncfCC1op/8ArsgiE0nP
 dH6s0tIIWzl1EDDMKIzCB6VkZgvNpISfEZ1FLKroPALxAXscf7x1fMFqyPjQqWoRgSQjZJAId
 xzOymTNlDE2tz9ALrytsmW8JgnOz4+bKVLGXA0zEWPSXQbInWhlE4MyR29vGjjNIFMeC/epOu
 3jlzyZvcwNtcq3nDM1rivi22yE1HDRH3gAmF6gw6afxYEDMGctQ0KGOLoNqEmESWY9nyJeAqc
 Ih6B9qtP3fejQRMoN3wp/P3WVlURb0MyBI0ns1XVAwyoUK0s4fQpxsszTGswNh8W2+3GHepki
 +qXo9+5nkwV8SScC/TlQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 28 Nov 2020 18:32:51 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 28 Nov 2020 18:21:16 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 28 Nov 2020 18:32:50 +0100
Subject: [Cocci] Checking the influence of an omitted semicolon on a code
	adjustment
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

SGVsbG8sCgpUaGUgZm9sbG93aW5nIHNtYWxsIFNtUEwgc2NyaXB0IGdldHMgc3VjY2Vzc2Z1bGx5
IHBhcnNlZCBieSB0aGUgQ29jY2luZWxsZSBzb2Z0d2FyZS4KCgpAUmVwbGFjZW1lbnRACmV4cHJl
c3Npb24gY2FsbCwgaW5wdXQsIHRhcmdldDsKaWRlbnRpZmllciBnczsKQEAKLVwoIGdfc3RyaW5n
X2Fzc2lnbkBncyBcfCBnX3N0cmluZ19hcHBlbmRAZ3MgXCkgKHRhcmdldCwgaW5wdXQpOwogY2Fs
bCAoCi0gICAgICB0YXJnZXQKKyAgICAgIGdzICh0YXJnZXQsIGlucHV0KQogICAgICApOwoKCkJ1
dCBpZiBJIHdvdWxkIGxpa2UgdG8gb21pdCB0aGUgc2VtaWNvbG9uIGluIHRoZSBsYXN0IGxpbmUs
IEkgc3R1bWJsZSBvbgp0aGUgZXJyb3IgbWVzc2FnZSDigJxpbmNvbXBhdGlibGUgbWludXMgYW5k
IHBsdXMgY29kZSBzdGFydGluZyBvbiBsaW5lcyA1IGFuZCA24oCdLgpDYW4gc3VjaCBhIHNvZnR3
YXJlIGxpbWl0YXRpb24gYmUgYWRqdXN0ZWQ/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNv
Y2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3Rp
bmZvL2NvY2NpCg==
