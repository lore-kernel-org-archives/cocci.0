Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A80C433DF
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 11:09:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C212072F
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 11:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="s5C1FqoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C212072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058B9eJo019300;
	Mon, 8 Jun 2020 13:09:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5FDDA7783;
	Mon,  8 Jun 2020 13:09:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 23C5A44A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 13:09:39 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058B9cYj023370
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 13:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591614577;
 bh=XeieFli9/bz70uVAYlFnNuxN8ET5GiqBKz3QrJ0jQr4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=s5C1FqoLp6FvySlIwJsZ76UEj8VPK3HXZ/tShcxM/LNvRTGMEnbCK0uuR8iUnSbRA
 UlCqg4Dcz1Vk54xx2+Q/pOtCkGwBUInVIYd8PinMo7/y7LZ9bQavEB/9ZFcE3evR7r
 ayW1GDc7FSMTHEvdSNuTUBPoUKU58+5RD5xIUI9w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M0hbG-1inniw3AJa-00uowg; Mon, 08
 Jun 2020 13:09:36 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <0a07fbfd-df53-2386-dd02-4d179d963e81@web.de>
 <alpine.DEB.2.21.2006081228380.3136@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6b47be1a-f024-2d34-0fe4-5e5dc894721b@web.de>
Date: Mon, 8 Jun 2020 13:09:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006081228380.3136@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:tqU7HxBXcV6PR7/jQz5sACiO7SVoKynDieDu84ArqE21eZke1TJ
 16NHsd6sOk4aKm5tTbeH97GIRecI7shg4JGOrYRAutO41F6ZV6pPZyP6b1bwRixX0EC4LIQ
 iEiTa6d4CQ5JOHYSgogiC7PZT6qrts7y6mk3j8dh10p14giKHRhiIcuUVOLBU/1EkvvRPYW
 FEIU7k/fr9jddMQuFM8aA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b97Amc7WSxg=:R8ZoJ/qeHBL2PKhH8Oahut
 NHMrdrHoqayqYG2IeLI7mn+OSqRdq/RNqxwpzsv2+61ZFO8eSYZCe3jG5rgzaB6Addj1KmDqe
 yim2ZZhuBB9lhU7soGhYwXnxRO4omIgnHWsMBRf35nOZVlYyYNZbEEobl58gbRqHzHCnGtOOd
 ESj9ANKLy9D4VMPAkiw2TGqkgPjIf9XQfXW/PVYEXsX7nvpABuhbqOzVqjlesc7ebifLWTOiP
 UvoetsHln1pTVyVPd3ksFs8ZzmZLTeSwYvAj1oNstxw80wRNTZ2k0eVGxY+7x8FwCU1/3/aCq
 6KsL34tb/Y18Y+eV+p6dBGcg8FqsX3EnH9mF8YoLeMeEuAm5BaE8TU9N0Dib5qFroOYbTIIRa
 NukCtFq9OJIXNsJj6Y2FXyTq4wGeDsCyfnKxoH2DmtxYN6yHo2gN3i9dUvJfC3n8szeUPlRaU
 CvYVBYvq+C45E/T9JKBjNNe3PVZuLCFrlNidYt4EVrloO5tmFyeoOZbJyp6XAKdeqvickf4G2
 YSGmQKjv2q3CrlNJC+1M2bLqwLZL90/CaszHBPQVDh1zieQ41OaBrc/OX8W+jHYubbdko8Zt0
 2EHJpvNmB/NDeZ2KEu2XwRsR+ZgBvZuyaEv/jDO82HCmGFoZ78IPEXnUaFbvcSrAVLHsheVJM
 X/flPGIrhGrH5d3A8Oq5yOefeHdRjOLKX8B20dZ82TyBWPv8GHOETI5it5AcN8UuUhS1vT7U2
 mz1lY70PTQ0houPddb6up/xpRYbKFNNjJPBqvcmAigfpCF8xUeY6cJtiycIO7D/cY47wKX7TE
 f6s6MxTzgli3UaTk0D344jTvzQhWku0l1QYfPEGURmipaLSf8lheJ/OlkwNlyPT2Do5+d6o1P
 16yzT6k0AQ2neFWOo6oHR42uuQg8AI0ZeIh4uGm4Htcfc6GvbdrIeoPtRxU0I3QagiSmxSfEC
 45fizeRKqRKV1IEPsKgNDOR9e+UZo03x5FO1y/lHvnUGua4xjSMMm2meAZDFhg3bZKKqQByhs
 PrAwAGXYiFvuaYCAA+Wi0AigLMg4YwmoNcwdgRAoQssKNmnToDgTy3NSKQv225IAb+oNbW0A3
 DauDKlOcETOfCj+ocxVXusf8HDkycTSBmZm1+cnpHFED6ISa8GaEsellZO2x+O29le2W/9Ldn
 Buosj2q3sqR9sGTeSEumkHp37gtMjC6Feki5bILCcsYLE+3Iyj3FG/460i2BcSrLMde5ysgDb
 INb7MoQ0uR3qOjpbb
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 13:09:40 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 13:09:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, Denis Efremov <efremov@ispras.ru>
Subject: Re: [Cocci] Python interface
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

Pj4gU2hvdWxkIHRoZSBzb2Z0d2FyZSBiZSBhYmxlIHRvIGRldGVybWluZSBqdXN0IHRoZSBhbW91
bnQgb2Ygc2NyaXB0IGNvZGUKPj4gYmV0d2VlbiB0aGUgY3VybHkgYnJhY2tldHM/Cj4KPiBXaGF0
IGlmIHRoZXJlIGlzIGEgc3RyaW5nIG9yIGNvbW1lbnQgaW5zaWRlIHRoZSBzY3JpcHQgY29kZSwg
YW50IGl0Cj4gY29udGFpbnMgb25seSBhIH0/CgpJIHN1Z2dlc3QgdG8gY29uc2lkZXIgY29ycmVz
cG9uZGluZyBlc2NhcGluZyAob3IgcXVvdGluZykgb2YgcXVlc3Rpb25hYmxlIHRleHQuCgoKPiBB
bnl3YXkgdGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgQ29jY2luZWxsZSBsZXhlciBkb2Vzbid0IGtu
b3cgdGhhdCBpdCBpcwo+IGxvb2tpbmcgYXQgc2NyaXB0IGNvZGUsIG9yIGVnIHt9IGFyb3VuZCBh
IHNlbGVjdGlvbiBvZiB0eXBlcy4KCkNhbiB0aGUgcGFyc2VyIGNvbXBvbmVudCBiZWNvbWUgYmV0
dGVyIGFjY29yZGluZ2x5PwoKCj4+IFdpbGwgYSBTbVBMIGNoaWxkIHByb2Nlc3MgZ2V0IGEgY2hh
bmNlIHRvIHBlcmZvcm0gY3VzdG9taXNlZCBmaW5hbGlzYXRpb24gY29kZT8KPj4gV291bGQgeW91
IGxpa2UgdG8gY29udGludWUgdGhlIGNsYXJpZmljYXRpb24gYWNjb3JkaW5nIHRvIGEgdG9waWMK
Pj4gbGlrZSDigJxDb21wbGV0ZSBzdXBwb3J0IGZvciBmb3JrLWpvaW4gd29yayBmbG93c+KAnT8K
Pj4gaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS9pc3N1ZXMvNTAKPgo+
IFRob3NlIGlzc3VlcyBhcmUgYWRkcmVzc2VkIGJ5IHRoZSB1c2Ugb2YgdGhlIG1lcmdlIGZ1bmN0
aW9uYWxpdHkuCgpJIGhhdmUgc3RpbGwgZ290IHVuZGVyc3RhbmRpbmcgZGlmZmljdWx0aWVzIGZv
ciB0aGUgcHJldmlvdXNseSBtZW50aW9uZWQgdGVzdCBzY3JpcHQuCmh0dHBzOi8vZ2l0aHViLmNv
bS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxvYi8xNzVkZTE2YmM3ZTUzNWI2YTg5YTYyYjgxYTY3
M2IwZDBjZDcwNzVjL3Rlc3RzL21lcmdlX3ZhcnNfcHl0aG9uLmNvY2NpI0wxCgpIb3cgd2lsbCB0
aGUgc29mdHdhcmUgZG9jdW1lbnRhdGlvbiBiZWNvbWUgZmluYWxseSBjb21wbGV0ZSBhbHNvIGZv
ciB0aGlzIGlzc3VlPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
