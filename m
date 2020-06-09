Return-Path: <SRS0=tHwe=7W=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F340BC433DF
	for <cocci@archiver.kernel.org>; Tue,  9 Jun 2020 17:41:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8002074B
	for <cocci@archiver.kernel.org>; Tue,  9 Jun 2020 17:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cnhrZuEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8002074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 059Hf7P9023568;
	Tue, 9 Jun 2020 19:41:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 201B77783;
	Tue,  9 Jun 2020 19:41:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A94403F9A
 for <cocci@systeme.lip6.fr>; Tue,  9 Jun 2020 19:41:05 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 059Hf4tA009259
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 9 Jun 2020 19:41:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591724464;
 bh=MMcbSLeZbrQDnnFMBQMeG5ec/7gxzoe/n48JQL70H+I=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=cnhrZuEaumCgCIffnlXZCBcwFajrBYdo6Nizb1cX+LgelSqzXwKIfdPAQMeyOOf1p
 nLeJCvZ8CcfhdkpDXSGfTS1q5VmHQPl7qB5g2rgtIsTZCD/A8HUqKm7OD19GjghOnp
 3pZgskbe65V448SnikTZktq3h+HsXqKugfqrPg5I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([77.6.55.3]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6V1T-1ikIKR0wGJ-00yP8t for
 <cocci@systeme.lip6.fr>; Tue, 09 Jun 2020 19:41:04 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <88d56de0-0a22-3371-ebd9-0ccbbc81f76e@web.de>
Date: Tue, 9 Jun 2020 19:41:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:dZ2Pxg7fE2spCtoNdNjr+jGOuikkV0DlaOvB1K5b/sWks9LsY0j
 BGUgDPVZm/RSDGVDdxSMGgSjSdMw4MGY/hGmY96sTeEg8a+cyZKgV8v+WLVMIMAsh6DbxBV
 OolkGC8I08VVcxQCkSN1LCe48MMCGDM7JGQm+mY+72YEJjJIy+VU/oL/DXqNpw7rOOYyzfH
 caE5vP53l5cCTJ7QYFjZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hNlXNfnloVw=:gSKWxSPF8uUIb4v7yiEXxM
 y/O3ED7cEJBPRUNxeAO2R3UauohSI77Nq+g9O3khp26fEGGu5F1jP0yyWwZSb3iAd3aKVl5c0
 afAGaKGUeKHuLm1cSNWJptqSOzbnPGAUI2/Vfdex+q8lkpqQtA0l8pZU1sRh+cqeMzdxfOYkP
 +6k2MSMh+H4BpuQAkqtCce5kPB/ptujcXdKKfNAlqhb3DMnNUTGJc9YA9QKdAVaz9ELt5smyu
 8UvWlO/NTIl0eeMWcZ4rN8PKhWLhcs3L2kNNwcJGUjx2/Zf1Z6YXYZIH9PVxYDnCuaz5KzmMG
 W0eTxRfqz8pu6ZG+8dk8ajkajdEMq5hCBajz1F4opWMrvZNNp0rB/NoPcIrMhq7dxaehFd8pI
 HfqFnWOYRfyCCIhmS/nsw1pL3HwVVyop8WGkOFt9wrrCrlhiCKkUgiODVwUCaqHNKWVQL9wpr
 SByj6voOfMWkVSN7AqJZfXJ1hUJfWNVZx5Oclm4NtLcjNjT56KuH6+uWKfZejd+C5UZMKwNm3
 2tkFKQmO97r1VShaUFaa3PnwPkeC1bAnxycUG8TY46NwlMBrcdzSvCb4fBhBUhaC4QOVJpyts
 yYMX3qRYyXErw50nvUXdXxTWnnJIBqe0ebaDUmVDV56sIu0QsE/WLTTyNDH+zfHRZ6+0Bb/lT
 kbKErviueY35zTb3OA6a7bMvEIUj2W1b3QTKKFPK+gLvGkLZLdSNFS9OYCXDVqu/2gStGQS8M
 LYEBycjzE6Zx8dUxIZsx8I/wzijRK15Fiwf3F+LQFWWuIogqRraVexRDkMbXG9TtfYAsaX0BJ
 MmxdTHo27GZCmm6jzQuBXL2xzh4mDFPliDkuPiDdd0nZRj2itiT0jw60RE6dL90hbq+JRySp0
 1j9V3x6oj0ADQz0BjCZUqr7VhvOBUFFzEzH5t3XWqpFw63Z127ko+SpyiiwA39c6P6mSgUdeI
 Q40xWegu0qkJpgD78kSmQydfpC+UFUf/7aOXw1naubXfsE04JrwC7N7kuP2FdaS/qnGimQhU7
 d1p21+DHWagrFxhuyxuh4wtjsSJa5GJCpvHo9GKHtfEZhVFQNro3g2CLKFfvT9A+yVIB2HOyn
 u8+cfBtUgXV0Wg9Th4EZK+/etY7cBiAUh6ZtxSaaBJnTpa03La8VGo+6dSg9ULtnqAVBKZS0S
 YbTcVlkKuLZ8rdEsaLwAg0WvTBU14D7C7a0Xe6WiEu5wexNoOBNLhBDxIoCjmDeFHbuHorX6m
 h6C8dVaIYBaASgSKX
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 09 Jun 2020 19:41:07 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 09 Jun 2020 19:41:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking software behaviour according to selected SmPL code
	variants
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

SGVsbG8sCgpNeSBzb2Z0d2FyZSBkZXZlbG9wbWVudCBhdHRlbnRpb24gd2FzIGNhdWdodCBhbHNv
IGJ5IGEgcmVjZW50IHBhdGNoLgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVs
LzIwMjAwNjA4MTQxNjI5LkdBMTkxMjE3M0Btd2FuZGEvCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3BhdGNod29yay9wYXRjaC8xMjUzNDk5LwoKVGh1cyBJIGhhdmUgdHJpZWQgYW5vdGhlciB0aW55
IHNjcmlwdCBvdXQgZm9yIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZQooYWNjb3JkaW5nIHRv
IHRoZSBzb2Z0d2FyZSBjb21iaW5hdGlvbiDigJxDb2NjaW5lbGxlIDEuMC44LTAwMTA0LWdlMDZi
OTE1NuKAnSkuCgoKQGRpc3BsYXlACmV4cHJlc3Npb24gZSwgeCwgeTsKQEAKKmJyZWxzZShlKTsK
KnkgPSB4KDwrLi4uIGUgLi4uKz4sIC4uLik7CgoKQW4gdXNhYmxlIG91dHB1dCBpcyBnZW5lcmF0
ZWQgdGhlbiBhcyBleHBlY3RlZCBmb3IgYSB0ZXN0IHNvdXJjZSBmaWxlCmxpa2UgdGhlIGZvbGxv
d2luZy4KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4
dC9saW51eC1uZXh0LmdpdC90cmVlL2ZzL2V4ZmF0L25scy5jP2lkPWI2NzZmZGJjZjRjODQyNGYz
YzAyZWQ3ZjMxNTc2ZDk5Yjk2M2JkZWQjbjY1MgoKLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb3ItbGF0ZXIKLy8gZGVsZXRlZCBwYXJ0CnN0YXRpYyBpbnQgZXhmYXRfbG9hZF91
cGNhc2VfdGFibGUoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwKCQlzZWN0b3JfdCBzZWN0b3IsIHVu
c2lnbmVkIGxvbmcgbG9uZyBudW1fc2VjdG9ycywKCQl1bnNpZ25lZCBpbnQgdXRibF9jaGVja3N1
bSkKewoJc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9IEVYRkFUX1NCKHNiKTsKCXVuc2lnbmVk
IGludCBzZWN0X3NpemUgPSBzYi0+c19ibG9ja3NpemU7Cgl1bnNpZ25lZCBpbnQgaSwgaW5kZXgg
PSAwOwoJdTMyIGNoa3N1bSA9IDA7Ci8vIGRlbGV0ZWQgcGFydAoJd2hpbGUgKHNlY3RvciA8IG51
bV9zZWN0b3JzKSB7CgkJc3RydWN0IGJ1ZmZlcl9oZWFkICpiaDsKCgkJYmggPSBzYl9icmVhZChz
Yiwgc2VjdG9yKTsKLy8gZGVsZXRlZCBwYXJ0CgkJYnJlbHNlKGJoKTsKCQljaGtzdW0gPSBleGZh
dF9jYWxjX2Noa3N1bTMyKGJoLT5iX2RhdGEsIGksIGNoa3N1bSwgQ1NfREVGQVVMVCk7Cgl9Ci8v
IGRlbGV0ZWQgcGFydAp9Ci8vIGRlbGV0ZWQgcGFydAoKCklmIEkgb21pdCB0aGUgc3BlY2lmaWNh
dGlvbiDigJwsIC4uLuKAnSBmcm9tIHRoZSBmdW5jdGlvbiBjYWxsIHBhcmFtZXRlcnMKYmVjYXVz
ZSBJIGNvdWxkIGJlIHVuc3VyZSBhYm91dCB0aGUgbnVtYmVyIG9mIGFyZ3VtZW50cyBpbiBvdGhl
cgpzb2Z0d2FyZSBzaXR1YXRpb25zLCBJIGRvIG5vdCBnZXQgdGhlIGRlc2lyZWQgdGVzdCBvdXRw
dXQgYXMgYmVmb3JlLgoKSWYgSSBvbWl0IGV2ZW4gdGhlIHNlbWljb2xvbiBmcm9tIHRoZSBhc3Np
Z25tZW50IHN0YXRlbWVudCBpbiB0aGUKc2VhcmNoIHBhdHRlcm4sIEkgZ2V0IGFuIGVycm9yIG1l
c3NhZ2UuCgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2luZWxsZS9qYW5pdG9yPiBzcGF0
Y2ggLS1wYXJzZS1jb2NjaSBzaG93X3F1ZXN0aW9uYWJsZV9icmVsc2VfdXNhZ2U2LmNvY2NpCuKA
pgptaW51czogcGFyc2UgZXJyb3I6CiAgRmlsZSAic2hvd19xdWVzdGlvbmFibGVfYnJlbHNlX3Vz
YWdlNi5jb2NjaSIsIGxpbmUgNiwgY29sdW1uIDAsIGNoYXJwb3MgPSA2NwogIGFyb3VuZCA9ICcn
LAogIHdob2xlIGNvbnRlbnQgPQoKCldpbGwgc3VjaCBvYnNlcnZhdGlvbnMgaW5mbHVlbmNlIHN1
YnNlcXVlbnQgc29mdHdhcmUgZXZvbHV0aW9uPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApD
b2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0
aW5mby9jb2NjaQo=
