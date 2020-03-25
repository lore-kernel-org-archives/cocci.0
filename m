Return-Path: <SRS0=YhuU=5K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283F5C1975A
	for <cocci@archiver.kernel.org>; Wed, 25 Mar 2020 17:01:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683B420772
	for <cocci@archiver.kernel.org>; Wed, 25 Mar 2020 17:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="P2SNi1su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683B420772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02PH0lER019253;
	Wed, 25 Mar 2020 18:00:47 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2CF867749;
	Wed, 25 Mar 2020 18:00:47 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F028B66CB
 for <cocci@systeme.lip6.fr>; Wed, 25 Mar 2020 18:00:44 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02PH0iNT022547
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 25 Mar 2020 18:00:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1585155644;
 bh=Pac8XYt1R8+wRKatvhl9Cy3GwyMwUgpxlyB7iQerv6Q=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=P2SNi1suncvD5W1Se4wNQypk7qpJRmkggCLChy3yidt/ASn1D8KngQf4sDtZ+mcUG
 rH7QcRMZMahZEF4Wbsrjz4SncybG7cUmydxjMo52EAPLxgYk+GBgwsHgQB2O9kziv+
 IBvJ4SuEj9XxP6HT0MzxZmnjl108U//BePGaBNk4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.140.118]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MfqAq-1iwKkh3tEi-00NCKI for
 <cocci@systeme.lip6.fr>; Wed, 25 Mar 2020 18:00:44 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <757cdb2d-9274-4d7d-64b8-387c76254254@web.de>
Date: Wed, 25 Mar 2020 18:00:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:MJqoGIGbuwOv/Cp9bEG64C9BQO1icngHWBgYcVMYa0LdMwRtMQV
 gABJXRt0EuPO7u+lLjEVnAsgfJYXd9UqgHu33KekOfTSFFy8l+kiKHX2vjMsDrml9IeGpTo
 yCMAe0nA/LLIGJypyQ1aO7wiH3vRD4JplBEVG7/2thwnhIVoVQ5/ci+NDhcNiVScZgYV/hu
 kLcnzliAEGwwOep9Nn6bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s3+QEAiRL2E=:jQlkQd7dCpmoftb2iqnmWQ
 oNDZBWmOnpohavFpEDk4XYkgjOgip6xXWWjqVd7ySzQB6tHZY+hdjDLFG9ADdIGwt9+uoTL1n
 veL1nLaoiIl/3/ScyuIwuVjrD8wMCq/SL096c6VTxENItuxWMeIZFL0gV6yDMzvnazAX1XReY
 Y9A66BOuFzdrdh/urdajzmefQ2/M8wwPRKWubUhlYGLbvQE6Lkj81Ssii6lA3NQX5MseBtONq
 HgqGXt2Ge3+162VHjyHvsqWQbqnmWBxWB5s+aKIZM39B+x3eZIhsAiWEI1Vxq1aRtzcCCZqrZ
 dmZJUGhNmgIdeN1mPXH61jZfA8ZBzPckT5hT8pwNMxl50n4r2B8cnGPWQ0UfuUQEnApwTvv3F
 RVe7bxhBJvuq6CDLRr9jCp+ARkjbz6Hq/FCPJv/UUhBH+gllXhR9vx9obtw9fMO0YDMzKkf29
 /jLazk1OHZ9o1PIwKi+egGfqc5y1qav9UGSnV9TyI85N9ghv3EJMeENCIVUXlWTt5rTdCkajs
 xtBtBp8o/JctN4S9cK11J9Wui3+D0srH4zllRGSA/zGpEHuHoZL/W3dWiOW6DttEWpJZhabaP
 l1s96/djzsRMJItt4hRmlf1TTPqq5VDTGp6wFtNSBMrG4UiNBqZmN0+NHp5UFYyuFsehhKWnd
 P7NEY/ERYRsFOuYg1XRrTpgETshsrLjnDucshemiYT7FXIBB8x8BBv5jyoKzVYgshikwa4DpN
 2TFl9wHHtdRu0PG0YCMfHCAbwf1yUkhISfpBz0mRpJrOSeaMnSWDNV8ByS4mN5cwn4ckS6Q9j
 wG5MDxs9wHYuHAK2bfJPYF3uiOjGTy/el+PEXJ+eSJDitB2XRgZiPzWZPKjCCZKhy6fDVvK73
 A0x7GcGXuHXDGQ26vONaAed6eTWNV1WP5PlBRK4pXwL+nr0ox8yqBmFg2u+WPd884KWhmY0Xp
 A4oADqAOBhkDu9kl3LiosGdf8aJPIJAIo75zpa648y5svqF6dhkUtTJ2CENQcG5QkE0fWf1Mu
 sK0o0WDI3q1aeVpKuYHl9i+2ENKff42vk4eQQmiCQuY34XBJYrDjqsHiMV1WD+lW1UBIfrKCR
 79aUa4Yf5tccdSdksy8MzDJwU3wG5JFXwICObBGHmF+Qm+dLa7qE0OuX5/KaarGcNU1M+sdfg
 2bcsn7WciT1JQwZJpxTK1YnY6rtg3Aoag3tQ4EYBnF95QfWYD49Rrt02dhsAPhmG8n2T16ogP
 rMfhrJlDXj/euzxdI
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 25 Mar 2020 18:00:47 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 25 Mar 2020 18:00:44 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Determination of failure predicates for selected function
 calls with SmPL?
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

SGVsbG8sCgpJIGhhdmUgbm90aWNlZCB0aGUgcGF0Y2gg4oCcdHR5OiBzZXJpYWw6IGZzbF9scHVh
cnQ6IGZpeCByZXR1cm4gdmFsdWUgY2hlY2tpbmfigJ0uCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LXNlcmlhbC8yMDIwMDMyNTA5MDY1OC4yNTk2Ny0yLW1pY2hhZWxAd2FsbGUuY2MvCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMjE1NTQyLwpodHRwczovL2xr
bWwub3JnL2xrbWwvMjAyMC8zLzI1LzIwMgoKSSBhbSBjdXJpb3VzIGlmIHN1Y2ggYSBzb2Z0d2Fy
ZSB0cmFuc2Zvcm1hdGlvbiBjYW4gYmUgZXh0ZW5kZWQgZm9yIHNpbWlsYXIKc291cmNlIGNvZGUg
c2VhcmNoZXMgYWxzbyBieSB0aGUgbWVhbnMgb2YgdGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdl
LgpUaGUgcHJvcGVyIGtub3dsZWRnZSBvZiBmYWlsdXJlIHByZWRpY2F0ZXMgZm9yIGZ1bmN0aW9u
IGNhbGxzIGlzIGEga2V5IGFzcGVjdApmb3IgdGhpcyB1c2UgY2FzZS4KV291bGQgeW91IGxpa2Ug
dG8gY2xhcmlmeSBhbnkgY29ycmVzcG9uZGluZyBkZXZlbG9wbWVudCBwb3NzaWJpbGl0aWVzPwoK
UmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9z
eXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
