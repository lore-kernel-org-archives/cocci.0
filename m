Return-Path: <SRS0=lWmI=34=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAC9C35242
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 20:38:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D20422522
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 20:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="kqFC6Fml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D20422522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 018Kc1sF018459;
	Sat, 8 Feb 2020 21:38:01 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1AC2B77ED;
	Sat,  8 Feb 2020 21:38:01 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6B4507718
 for <cocci@systeme.lip6.fr>; Sat,  8 Feb 2020 21:37:59 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 018Kbwvt024122
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 8 Feb 2020 21:37:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581194278;
 bh=YseKjM/w8jIwXnVZSmARw+nmH4Cj2nuZnJDCXVkrYhA=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=kqFC6FmlaOJi3p4FmkrJNA7+AsF6/bmxKab9um8HW/JnzUUClLchmU1ZFFCiJYJYB
 k5VkBiHTCqAb3Omqc2APLiDS9zgBIAoJYrl0GTrRDeK+fiZLdOm73fG/MAMDMXmREj
 Ia0zY3Zqk+l9/vnKHBEIxqy2TknDEwsI1f0sOK/A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.138.97]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6xc5-1jljnc3qTN-00wjTP; Sat, 08
 Feb 2020 21:37:58 +0100
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
References: <beddf327-4b09-16fa-f011-ae14c20e988b@web.de>
 <9DEC698B-1094-4D4C-AE98-719DCE517EFE@sury.org>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c0c3c051-ba4a-401f-42df-e694b0d6377e@web.de>
Date: Sat, 8 Feb 2020 21:37:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <9DEC698B-1094-4D4C-AE98-719DCE517EFE@sury.org>
Content-Language: en-US
X-Provags-ID: V03:K1:bHyC0FskjJz7Os845djY36uXzmQpidPD8OKvgBc65Dr/y/g0f4f
 xnG733IfT/WazaVgC0VkTQYgy/s0gDP5FF/hKJu8x9YrvU8VqHOKmTvm7+ejDepz416fGQq
 hpZ1OQVFypYhM55GwRq/92l5jCHnhB7c5eWwhTLeYkRq1J05/JoXemDOxHmOIOoeqDI0gu3
 x1NiPfZTgRi+d+naQnWyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ezxZoeXWd8=:bYGJ34OZPPCamLTGKB80Qg
 VgQC6GCx/Q9ZQG9FCT6KsUArRnLdgWVyCiF1utEr6dQQaa0XgHJnN4jSXo0/cHybOjSYPIbZS
 iSUvAqB7cO2awNs4Iu1ApQp0497Enu6pxBW/To2D3lJ+pFxbzLJGcSUKG7mn511ZQUMcwttPy
 zJQJJAV0EBVRr7RriqdirrZK4M+fPKWOwbcSZYoqqrpjDadobLSJXKMFQRETgqVoEe9PXpOMB
 cM2JsVvPSAIuMlGEQKOzLzkSJkzU+vAVw6I6mqKayo2WGvajNbU7ku1lha+H+noI3wHTYZPvo
 H6cr8kekkcmERL8nGCmBMgHexS43lMS3GnowSLOfJOMHaR+m1N9LCskvxWPVVoFlt/+jDbm66
 M8hm3gaeWzK1CorsPwRDKe7BauYJlL4MeVrw8SHckJsN2WQuho1zdK6W7CPUOI60qyuFtP2vi
 JURs7tEBI6hPU/oqdhFuAqoELr/zBhRneNVGGco1vvRLqBMldo2qBF1+WZf6Ya7MZCfOGo3sp
 zE1iV5aUk9DJGJokqGgCTkOiJNyxkIyckiXgjqpu9ILnAA+46VXoKkNMnxxCcCyegabc8n2PX
 JqdBq8niDnU3Ool8+EdZvdtsHDc/X51e9wHneinD056RcC7QUoAbTgYTegqKm72qiS+P4Hy9j
 MYT7XF3jkBLrTSTqUP7arkX+3bm5wgx+T2sphbZSG42plArOBuKA/CmkzZ9JgC0MpSrxYMChY
 1OI+poeVK6MVO5laQxdAsFGUI62FtocWaDIkxorjpY2WxXh7rJ+ACFtIYsVymqvZ3nTrIUeVy
 0ZV8TAvpG3R9XkNp4EQMCEjILNe7unPlc4vQ7RNUFFHxhupa4Os1FzOhfhZ83D+UHlK3JLogL
 benY+nrLtcUB/S5a0SL36idqAblKEqdDJVQxu3D/rCYTbgGT4qtMxob4GduESCY5xAnL7ZNog
 uXQBeCCSv+N3mYMOLDRGMBw5S4sy/KmNhM3REfEzLBHQbFj8iMt4RRT0bbEWxtH0nJfNkN/pA
 Cv3W7zdRJzB76OsLrPjO8qnCTrTPY4FV3s5HYX6OsC+QePbrTIZsfK9mtwbiZEyGEU7FFoR8s
 UD8KvtrFlU6IyLm0DQwHGykTT0qyq76X4y0j4X8gyQXEjJ0Rag702GS8gTTAuOJnWdc6qE5qT
 K8CgWCK34t9a2NR9dTMcd6roUTKzxOGfaSyqcvWkeDYoUMUImiSy1D7gAbYLHDfCDhKmaTROw
 YD95LwIFH8NTY99jj
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 08 Feb 2020 21:38:01 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 08 Feb 2020 21:37:59 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Replacing the type casting
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

Pj4gUkVRVUlSRSgoCj4+IC0gICAgICAgICAoVCopCj4+ICAgICAgICAgIHNvdXJjZSkgIT0gTlVM
TCk7Cj4KPiBUaGFua3MsIHRoYXTigJlzIGhlbHBmdWwuCgpUaGFua3MgZm9yIHN1Y2ggYSB2aWV3
IG9uIHRoZSBzdWdnZXN0ZWQgdHJhbnNmb3JtYXRpb24gYXBwcm9hY2guCgoKPj4+ICBSRVFVSVJF
KCgKPj4+IC0gKFQgKikKPj4+ICsgKGRuc19yZGF0YWNvbW1vbl90ICopCj4+Cj4+ICgKPj4gLVQK
Pj4gK2Ruc19yZGF0YWNvbW1vbl90Cj4+ICopCj4KPiBUaGlzIGNhbm5vdCBiZSBkb25lLAoKSSBw
cm9wb3NlIHRvIHRha2UgYW5vdGhlciBsb29rIGF0IGhvdyBtYW55IGFkanVzdG1lbnRzIHN1Y2gg
YSB0eXBlIGNhc3QKd2lsbCBuZWVkIGFjdHVhbGx5LgpXaWxsIHRoZSByZXBsYWNlbWVudCBvZiB0
aGUgZGF0YSB0eXBlIGJlIHN1ZmZpY2llbnQgYXQgdGhpcyBwbGFjZQpvZiBTbVBMIGNvZGU/CgoK
PiBhcyBJIG5lZWQgdG8gY29udmVydCBvbmx5IC5jb21tb24gbWVtYmVycywg4oCmCgpUaGlzIGNv
bmNlcm4gY2FuIGJlIGFkZGVkIHRvIHRoZSByZWZlcmVuY2VkIGNoYW5nZSBwYXR0ZXJuLgoKUmVn
YXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0
ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
