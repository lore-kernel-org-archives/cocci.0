Return-Path: <SRS0=Oul2=6V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A99C38A2A
	for <cocci@archiver.kernel.org>; Thu,  7 May 2020 16:33:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BFD20643
	for <cocci@archiver.kernel.org>; Thu,  7 May 2020 16:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gWn8KsBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BFD20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 047GXQfV000297;
	Thu, 7 May 2020 18:33:26 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 201C6775A;
	Thu,  7 May 2020 18:33:26 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4137C3E68
 for <cocci@systeme.lip6.fr>; Thu,  7 May 2020 18:33:24 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 047GXMsj018953
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 7 May 2020 18:33:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588869201;
 bh=Io4lhupnpW+A1dV+S+sL0c+MxE6sIh+l0c8EZpX8iN0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=gWn8KsBjIfXyMmMqdbcX5NGRudWDpWzIWSEDhSAfiCFuwl1p0jqrtybPulTytV/a6
 B/cCWZ6KnHkQz5soLSkZpXVKp98cXfTQwkPl92Nyd59Bxq7vpwY63v3/N8paosiTnm
 wXRqGIw/MsRa2a8yE/zgopi7opWSJmYvtlW1UGOo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.29.220]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqUan-1itX1M22dd-00e6bI; Thu, 07
 May 2020 18:33:21 +0200
To: Julia Lawall <julia.lawall@inria.fr>, Coccinelle <cocci@systeme.lip6.fr>
References: <60964864-2009-f78e-fd51-307cea4692cc@web.de>
 <alpine.DEB.2.21.2005071818390.2505@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3243f0a6-52ec-d7a9-8056-d2f692842503@web.de>
Date: Thu, 7 May 2020 18:33:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005071818390.2505@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:UY7Ebz09VGFopELh3gGGL1FwyBFNrR7Mmwk7SeUWR7tHj0bU+E/
 OKjLLrke5hrCXNUAECuXZvweSJ6N3D3T5zf/Ify76n4H9NAYdfasV69MZDD3q+GNC4FyibW
 50xwnuZTrD5Udbw46vkT1nfhXR0tSdC1gBXZh6D3ThMjka0+gB1xuznmYgUalwxGg4ZLxLR
 m8vfmn6u4OBYeELkVOHHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TIJhHQoQCR0=:vcJgqsbhh/yR/2HK1YgIMH
 5ho1F8/Xh+t77afMFGm+UZi8yB6gQfrBrk2axq8KRmUczAJj1bgMzkXlePKJQHDuFqlJG2p8f
 PAo4FD8qrlt61WfwFSGiC/PRyQkDiP1P0BXxOkIdNYJtv0MYQ83CQmgsdQE4C+PP4D5YXIJd1
 hIXLl5kc7ejRQfZimvPqo92H5IlsUmQ4zvOXRJjiYw+avxB3o1vQsHyxCfyre9e7GD3Qbvgjb
 psFEsOZdT02fiepAA7PPqwQCl6HlGaVhrmjoSTz5AMfXTAl5n9Cp3m4ueWrUetJ5wN9UoWlUm
 bqFoYPmbxZ1EmwpVIlo3OGjlM5ifI63P8/a0IPqXzSaqEsE4HFiObKBhyix1hJXwCEmhH5l/i
 /icXW4JpWbOR2BeRXaqB0jSZbIANZH6UVii5usqvQmsvY7kOZTVtH5WmT0m4Y2IGLm4Iu/hWg
 TvZzCng+XU+oBI8H2zs9H2s7+ocqWikq/676h+B/fZvrlRKJzIWDjKiR9uIpoTzr07/XZcJYg
 3Cd8w1LUvZT6dtyAxWQVu57YPj3CVn4RuVI2Wo/dVZ+knRliFgTMxwTeSZx5mC0HX+l/4IqmP
 ZjtCruqmkI8tOaV0FKwKMqV3DlG9M9U/Osm88Bsrxr8DLKqHES2aaTB/LSlINnujz9HphMoiX
 98nK+MiMuoIWfTRPE33+RN6c2IxrLpBS31WPMbP1jM/VfdwCVRrEnMJpEe4PosAYg6UjvgHc+
 HQBfdYMkaimug8Jh0D4qiUFMIX2W8qq8fxLqpdl+Lp5MSkmzdvPZEKV0QBbsU88Ux7OgPX5jY
 53QlBmewaJTFQoG/fzNKd3hsdImJsedtf6TcMRy1mmjR6DXW72ySqd7nX9slG1yybJSCExAol
 jGzL5mrvrsmjqjYg3m0iiI0mjqE1uk4h+BjErxdw7MkZy5hxm9chwrnLXAPCNTmiQnhwzmkJW
 Lh09HdID+rSH8pAUP3/m1Aw1LA5vLKKuGECn0Y5wHTz31TkrU0EF/hVrmwg26udL+wkBa35GF
 aMjhi9yXwzN11JSeoaCllhKz2M5BG7sMMHiRsPx4bQde5evKIQVPMwnU7vFoxYO/MECUgz/5F
 +EnUpmtxik2NUXDxAeN0ZMZMRZh6sygPvR5+ll/iRYV4yUrg5/RhlMd+Z1R4Sal//hID0YclC
 IOMwdFYhh7E0rjYfKhn0yVL2AA1F9zSzhhO54zoF5UwG4fz5ZOQfUvHctlWBxK75rF6M7P//H
 AEXVcheQ6SqpPXdIJ
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 07 May 2020 18:33:26 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 07 May 2020 18:33:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Subject: Re: [Cocci]
 =?utf-8?q?Checking_an_application_of_the_SmPL_construct_?=
 =?utf-8?b?4oCcPCsuLi4g4oCmIC4uLis+4oCd?=
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

Pj4gQGRpc3BsYXlACj4+IEBACj4+IChkZXZfZXJyCj4+IHxkZXZfaW5mbwo+PiApICAgICAgICgK
Pj4gKiAgICAgICAgPCsuLi4gZ2V0X2RldmljZSguLi4pIC4uLis+Cj4+ICAgICAgICAgKQo+Pgo+
Pgo+PiBJcyBzdWNoIGEgdGVzdCByZXN1bHQgd29ydGggZm9yIGZ1cnRoZXIgc29mdHdhcmUgZGV2
ZWxvcG1lbnQgY29uc2lkZXJhdGlvbnM/Cj4KPiBOby4KPgo+IDwrLi4uIC4uLis+IGFzIGFuIGV4
cHJlc3Npb24gbWF0Y2hlcyBhIHNpbmdsZSBleHByZXNzaW9uLgoKSG93IGRvZXMgdGhpcyBpbmZv
cm1hdGlvbiBmaXQgdG8gdGhlIGRlc2NyaXB0aW9uIGZyb20gdGhlIHNvZnR3YXJlIGRvY3VtZW50
YXRpb24/Cmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxvYi83Y2Yy
YzIzZTY0MDY2ZDUyNDlhNjRhMzE2Y2M1MzQ3ODMxZjdhNjNmL2RvY3MvbWFudWFsL2NvY2NpX3N5
bnRheC50ZXgjTDc4MwoK4oCc4oCmLCBhbmQgYW5vdGhlciAoPCsuLi4gLi4uKz4pIGluZGljYXRl
cyB0aGF0IHRoZSBwYXR0ZXJuIGluIGJldHdlZW4KdGhlIGVsbGlwc2VzIG11c3QgYmUgbWF0Y2hl
ZCBhdCBsZWFzdCBvbmNlLCBvbiBzb21lIGNvbnRyb2wtZmxvdyBwYXRoLgrigKbigJ0KCgo+IFRo
ZSBmdW5jdGlvbiBoYXMgbXVsdGlwbGUgYXJndW1lbnRzLgoKRnVuY3Rpb24tbGlrZSBtYWNybyBj
YWxscyBzaG91bGQgYmUgZm91bmQgaGVyZS4KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGlu
dXgvdjUuNy1yYzQvc291cmNlL2luY2x1ZGUvbGludXgvZGV2X3ByaW50ay5oI0w5MwoKSG93IHNo
b3VsZCBleHByZXNzaW9uIGxpc3RzIGJlIGhhbmRsZWQgZm9yIHN1Y2ggYW4gdXNlIGNhc2U/CgpS
ZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5
c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
