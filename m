Return-Path: <SRS0=tAXx=6P=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F51C4724C
	for <cocci@archiver.kernel.org>; Fri,  1 May 2020 11:43:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4A62051A
	for <cocci@archiver.kernel.org>; Fri,  1 May 2020 11:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Ge+Izach"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4A62051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 041BhIRI004808;
	Fri, 1 May 2020 13:43:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E2398757C;
	Fri,  1 May 2020 13:43:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5071D3DC8
 for <cocci@systeme.lip6.fr>; Fri,  1 May 2020 13:43:17 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 041BhFg4007485
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 1 May 2020 13:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588333395;
 bh=PaMYyPzyWLrQumKb06EKjtmz9Q0m41IvSJk+OXjbyFk=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=Ge+IzachiJ7rYTskKPgyWg0pX+/k+rt0zlzH9ChSJ/QE08btFhuV5xdJsfYd3NDyO
 DC1OxnZzxqwWmzn+gFJW4eKq2RFsq5yRROZE1Wko5iP/4MawaGSy0PyIEDmYib0psl
 9xYip2i0JlVv1ha80YsOk+vnC4cwwl+3Dwe2X92U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.136.146]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUnuu-1jeV152Wjc-00Y9dJ for
 <cocci@systeme.lip6.fr>; Fri, 01 May 2020 13:43:15 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fd0d48f1-ba0a-74d6-6eeb-7494600067f7@web.de>
Date: Fri, 1 May 2020 13:43:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:7+E7l5XQkXjpjAvrsIcnEn1UGvl56ng7lXHYuJ7hxcUojMazdKs
 GrhuXu/bFu/IyuIs9sbMh+b+LaqSIpBS7Mkzhqy5EChVbcnEJT//ONM54RgcAE5c5b4nzwo
 miHm1LENzaCursnVcX/wX4qbGKCjcvMX48VPwvwwQCjJ32NT1c5kSe16hAJVMKs9HQF8MW/
 wTRbLfY47m2f9T5K4wKXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fftf0Q8y/K0=:UwRyt3e+BPsAPxK1D1wXE8
 X3BGHSEE45tbWKufKUbl180ud/Bh024ZFs8Etd16rwlY2ce59IFNefbP1QMebqMWGIB8zYxtQ
 Vy4cgqi3c7P2hVzyl2cUBb7+x8BP0OClB7vKrykm6lXslvCoLKyWD62zctoMA8zIl6nv5l9fV
 pJMsCzqcfd0VNlGhhUkW9tc6PJDYSm4MkO/DqhKhzse9JamGns62QuGVoMZXqF9Ic0N8mEIRe
 1iBjR1WBeZttCiw/5eJHUl9x/KHhdo0TJ4dM0reqz/gwfFEJELhu8fZG32SXD5SZi3IYeLS9M
 OiXc1HOQYOjbWaUrgodNqjbvZ4Hd0599U7radulOu4QczDTn3XjznCW5HzQcsOHCyrhzOtaNP
 CJJRN4dHky3EUwdcxCxPSbgoy2Ai77BhahzCMPFORkVTV/H9eJT+XftB3TIewRy1C05P9jmvr
 3Hi4w9TG5Rl8FD3JMG9sTBzNqHLxLUaxkuVXsjoOjQk+/MqgkhaX3ZmVeD/9Cao3rFj16JGRN
 bui6RGZ/AauUNz64u40RqTzZZ15LGvkb8EtEUY8ZW7ZwzDsqcD6IaPhEdN9/bKr+VGA9JA5OD
 xYumjDiawgIBhLTPxlDc5891VDTjc6QXYqCjbzMsIpJR+GLh78iDrP9imXCBtljepugzaF67K
 6w/aXHPlmezv1RIf3OwvYKS0psX5vAng6LHuLw29J9zUunm5iGG/FnEJkXwyt0JYa4bSFpvU8
 gXHmeko2bkX6m192+T8fymNrXog9BQ3kM+N7Sazgnr63BpP5i5bTVO5fe4wO3WGad/kii5aKI
 kxSFmOurX68TiT4T7kZoL55hm+AHTWqWCblb/ewA3shajdhqY/q6tYCk0+67uqaNsTgs0FiNb
 aC+En/pbPpxsIjjhX0SavHvnrEnRoRRaSsBGRAPpPpatLkRpq2ZtzHrHNDnoTD5s462VT1MzI
 uj9KsVNIPDrNN9f4HOg4FwIN9OMeGn0J0PmnIDXLGqTRnCYzJBJAeZFizcSy5z+gK9BG5Bgyq
 p6Ong+uwm4BSld65Y1lxZ/8f1U1PpBUWcIiBZ3f7XV6KHPIxwo7n77CJrfqJvpi18WycRVAd0
 75cYGlTt/Vq+CnMfRuKSuDoxdodY3YAhE/890vzV5YuPuDT8sagy1VfgJ5WyUtve04Uw8xZry
 wowwtDWufW8f4j184raV7ZsKMIHcBtZqngOUxUSvQIRnnlR6Tkv8j+Q8CEPbCXN/RnDsT2Eyn
 5tOlFOHw6BxZFW+U0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 01 May 2020 13:43:18 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 01 May 2020 13:43:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Searching for exported Linux functions
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

SGVsbG8sCgpJIHdvdWxkIGxpa2UgdG8gZGV0ZXJtaW5lIHNwZWNpZmljIGluZm9ybWF0aW9uIGFs
c28gYnkgdGhlIG1lYW5zIG9mIGFub3RoZXIKc2NyaXB0IGZvciB0aGUgc2VtYW50aWMgcGF0Y2gg
bGFuZ3VhZ2UuCgoKQGRpc3BsYXlACmlkZW50aWZpZXIgYWN0aW9uOwp0eXBlIHJldHVybl90eXBl
OwpAQAoqcmV0dXJuX3R5cGUgYWN0aW9uKC4uLikKIHsKIC4uLgogfQogRVhQT1JUX1NZTUJPTChh
Y3Rpb24pOwoKCkJ1dCBJIGdldCB0aGUgZm9sbG93aW5nIGVycm9yIG1lc3NhZ2Ugc28gZmFyLgoK
ZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvcj4gc3BhdGNoIC0tcGFy
c2UtY29jY2kgc2hvd19leHBvcnRlZF9mdW5jdGlvbnMxLmNvY2NpCuKApgptaW51czogcGFyc2Ug
ZXJyb3I6CiAgRmlsZSAic2hvd19leHBvcnRlZF9mdW5jdGlvbnMxLmNvY2NpIiwgbGluZSA5LCBj
b2x1bW4gMSwgY2hhcnBvcyA9IDg3CiAgYXJvdW5kID0gJ0VYUE9SVF9TWU1CT0wnLAogIHdob2xl
IGNvbnRlbnQgPSAgRVhQT1JUX1NZTUJPTChhY3Rpb24pOwoKCkhvdyBhcmUgdGhlIGNoYW5jZXMg
Zm9yIGZ1cnRoZXIgc29mdHdhcmUgZXZvbHV0aW9uIGFjY29yZGluZyB0byBzdWNoCmEgZGF0YSBw
cm9jZXNzaW5nIGFwcHJvYWNoPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0
ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2Nj
aQo=
