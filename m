Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46553C433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 12:36:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B16F207FB
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 12:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gAsGdYvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B16F207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OCaSPn013373;
	Sun, 24 May 2020 14:36:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 180D13DC8;
	Sun, 24 May 2020 14:36:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DDA763D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 14:36:26 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OCaQKF027294
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 14:36:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590323783;
 bh=Z/VgAvLKWI2WY1Smh9E360e9CdiyY7tBBX9eyTRixAA=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=gAsGdYvKnNifiRZcS9lsO0nQ5ZwP9muR2wlslnFyV+bjuy2Ok42GI0drVf8CAHVKc
 jVoIZ3ikOsU1yLzaGv9N/A4axj71qEe7SqwYrZc/1fcx/eLk1NestJ+mjCbmZS272G
 CcD2UKZy9PFYLWq3tcz5vjPb7YB/ADEpcO5GPA9s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.187.46]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MhlP1-1jPJBs18Lb-00MqrG; Sun, 24
 May 2020 14:36:23 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <1d595042-0940-3056-5460-bffd58782fe2@web.de>
 <alpine.DEB.2.21.2005241405010.2429@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a29f1f11-c12c-6b96-0ddc-09b9790fe9af@web.de>
Date: Sun, 24 May 2020 14:36:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005241405010.2429@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:Q81v8Ny3Ir1QCJeEOWwAkGghWYJA8jBtcDq/WhOziv3NUhSJdvN
 hqW9V/zj2/q6S4zzYg8pE05DhLXmj702SVz1MU7y8wm0oDTFxeiBCyIoDyStHh/6gMAPjUq
 pvIV2j29+C8CoKJT+E8BMwP355kd3pWNS2vW3Jt4K00hBN40cMF073dbw/laEA27yk44uKy
 XzRCxsL0/oJ4xstVmoKjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ywZzNr3NgG0=:mbSHSfGTMwqLBTCuPKehe6
 gZmO9eBPSWhPDgiiqeJFUvZ2O4trIs8dR7FffzeB8VluQf00VJzpDAEdDpYzhApbHDzGCI28X
 zwfemjwpLcbKsj5B7tT+PgWpu+bC3wY6nXniE++YN6eEtuYBoY501B7YxmYP7sJ7Xok7usG+i
 cwNUnZBcjZAWGjXDXjbXpQxR310R9nCoI4hgx7HUqzzkSd6LdYLLIjxb8+LRXt8NVhMMUA76W
 RISEGmp/AQ7hT41zUmJnz42eXktO7ejqPjSMdJHZv6Ltf0qPxVXsyIH8U7TT+VFj13+w4BWTw
 x3c36jyoF0fSfLRk76uElpxm9+oZYp+JUP7oBUpaXlbCwR3WRQSGGJW7hHxFWsyOF4BZhEsl5
 ILXKq3+qNV/g/Ycxxp20WqkKSVpm/MY3RHcn0HXcvbP7G8NT7M2mmiq1xScYweC4IGZUI2Nxv
 b/ToyTOLq/P6npHhCjDN2sRXApSkbKFhd7teJIs9KmVa8ufkdX15h1WyVuzWr6mUVALmudLQR
 orF3iIvLUBNZfSpwAMNH7GKe89L/31YROiBJH3ThEMtjQ2M5OlPV/rUGctg1QE9UCJsWDNT+X
 XJKyPBfctRv56L+8PNlO8JQxfiPpErYvziRcfBVvcBjclg59/L+JAUUU/stp/76BvktyXDJuR
 YDQnqJ2Jll9BnIp1l7PS06d7OzRzGH+kzFD1oP4BBv3ODTyZCANdKEGbi8kI39/jXdzm5aaIJ
 NvhCMs6/jD9lPw/zFOTvw60rs2fQGucJnRHcXUlo6vN3OWTvWWz4FyffSE3o/YiKtpkdpXNyz
 jGOajNlzXuLspgQVnDZkxw6TxMX1TYZFLQmQdzL8U2CGU+1v/SbsGkJVqWqEpRTfAOXIlLi71
 gGxxe/Z83A1YKnw9SG6unIpjwiGorY8Z3yFXW2M1tdLvSVaDoGZ653T3vvIpvgJBYkpiIBD2O
 pYMvNstlVM0bXBgzSy8TgCdB5i9rYe5ajMNbY2eOYXRj9OHCF4G0gSOHZDfAqad5H2unSuPx3
 tJY19R3OK0Yt8zV1AMJicb6TKKwjc3k5sX8/B145Yi/N8uVqgQZT3cYCNLKu5jUk4NOILDtoI
 t+a0DNFbdT1L7WbyARm5+TOAkyF32tTznuBJJuiFdGbxDDF2KAxoABWR9OuxBmwUxwZDHFspP
 9kx076f7q4cKb46Qb0ykEzRLA183UZ75g3kVtSXoEkJy2PMgVkCl2+EfsCI3b39MrW/0oXASO
 OfKZEjpeuTzkvz/ln
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 14:36:28 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 14:36:26 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Converting variable initialisations to later assignments
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

Pj4gQG1vdmVtZW50QAo+PiBleHByZXNzaW9uIEU7Cj4+IGlkZW50aWZpZXIgVjEsIFYyLCBWeDsK
Pj4gc3RhdGVtZW50IFM7Cj4+IHR5cGUgVDEsIFQyOwo+PiBAQAo+PiAgVDEgVjE7Cj4+ICAuLi4g
d2hlbiBhbnkKPj4gIFQyIFYyCj4+IC0gICAgICA9IFwoIDwrLi4uIFZ4IC4uLis+IFwmIEUgXCkK
Pgo+IFdoYXQgaXMgVnggZm9yPyAgSGUgd2FudHMgYW4gZXhwcmVzc2lvbiB0aGF0IGludm9sdmVz
IGEuCgpJIGNob3NlIGEgc2xpZ2h0bHkgbW9yZSB1bmlxdWUgbWV0YXZhcmlhYmxlIGlkZW50aWZp
ZXIgZm9yIHRoZSBkZXNpcmVkCmNsYXJpZmljYXRpb24gb2YgdGhpcyB1c2UgY2FzZS4KCmEg4oeU
IFZ4CiAgICAoT3Igc2hvdWxkIHRoZSBpZGVudGlmaWVyIOKAnFYx4oCdIGJlIHVzZWQgaW5zdGVh
ZD8pCgoKPj4gIDsKPj4gIC4uLiB3aGVuIGFueQo+PiAgICAgIHdoZW4gIT0gUwo+PiArKyBWMiA9
IEU7Cj4KPiBXaGF0IGRvIHlvdSBleHBlY3QgdGhpcyBjb2RlIHRvIGJlIGFkZGVkIG9uIHRvPwoK
SSBpbWFnaW5lIHRoYXQgd2Ugd291bGQgbGlrZSB0byBkZXRlcm1pbmUgdGhlIGVuZCBvZiB0aGUg
Y29kZSBibG9jawpmb3IgdmFyaWFibGUgZGVjbGFyYXRpb25zIHNvbWVob3cuCgoKPj4gZWxmcmlu
Z0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvcj4gc3BhdGNoIC0tcGFyc2UtY29j
Y2kgY29udmVydF92YXJpYWJsZV9pbml0aWFsaXNhdGlvbl90b19hc3NpZ25tZW50LmNvY2NpCj4+
IOKApgo+PiBwbHVzOiBwYXJzZSBlcnJvcjoKPj4gICBGaWxlICJjb252ZXJ0X3ZhcmlhYmxlX2lu
aXRpYWxpc2F0aW9uX3RvX2Fzc2lnbm1lbnQuY29jY2kiLCBsaW5lIDEwLCBjb2x1bW4gOSwgY2hh
cnBvcyA9IDExNwo+PiAgIGFyb3VuZCA9ICdcKCcsCj4+ICAgd2hvbGUgY29udGVudCA9IC0gICAg
ICA9IFwoIDwrLi4uIFZ4IC4uLis+IFwmIEUgXCkKPj4KPj4KPj4gSSBoYXZlIHRyaWVkIGFub3Ro
ZXIgU21QTCBjb2RlIHZhcmlhdGlvbiBvdXQgdGhlbi4KPj4KPj4gLVQyIFYyID0gXCggPCsuLi4g
VnggLi4uKz4gXCYgRSBcKQo+PiArVDIgVjIKPj4gIDsKPj4KPj4gZWxmcmluZ0BTb25uZTp+L1By
b2pla3RlL0NvY2NpbmVsbGUvamFuaXRvcj4gc3BhdGNoIC0tcGFyc2UtY29jY2kgY29udmVydF92
YXJpYWJsZV9pbml0aWFsaXNhdGlvbl90b19hc3NpZ25tZW50Mi5jb2NjaQo+PiDigKYKPj4gMTQ6
IG5vIGF2YWlsYWJsZSB0b2tlbiB0byBhdHRhY2ggdG8KCldpbGwgdGhlIG1lbnRpb25lZCBlcnJv
ciBtZXNzYWdlcyBnZXQgYW55IG1vcmUgYXR0ZW50aW9uPwoKUmVnYXJkcywKTWFya3VzCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcg
bGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1h
bi9saXN0aW5mby9jb2NjaQo=
