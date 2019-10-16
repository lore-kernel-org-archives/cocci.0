Return-Path: <SRS0=7Tum=YJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297ACC4360C
	for <cocci@archiver.kernel.org>; Wed, 16 Oct 2019 07:12:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B54E217D6
	for <cocci@archiver.kernel.org>; Wed, 16 Oct 2019 07:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IADeFAc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B54E217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9G7BobM012862;
	Wed, 16 Oct 2019 09:11:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B78B977B5;
	Wed, 16 Oct 2019 09:11:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5CFF77792
 for <cocci@systeme.lip6.fr>; Wed, 16 Oct 2019 09:11:49 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9G7Bmoo001273;
 Wed, 16 Oct 2019 09:11:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571209908;
 bh=e59e2D0H6AIrAYG6ZHDcdzMTI1cu/j3A/NRmXvohYFw=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=IADeFAc5fvB8I6SzVtMGKwmPUCOm9gS8uGEO78SfRdOH62LpHc8xGdQdon4ZbCH84
 ChNWb4cJ7Kl9KEplC7muz7OL0laH6s0Q0FsB9cjZ/46f9vWM6mSH+gOAajZM0ojpwY
 vZbxwKAu7/GReLXxhUnQPQRCEvzYP/XBGevGDOiM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.85.206]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MMn1H-1iPtCF0fUt-008ZpD; Wed, 16
 Oct 2019 09:11:48 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <46ce51eb-b6d9-3a38-482c-f1654525bb04@web.de>
 <alpine.DEB.2.21.1910152125020.2581@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8b26349b-69b8-b0cd-9af0-6e99987ab5b8@web.de>
Date: Wed, 16 Oct 2019 09:11:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910152125020.2581@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:qbTKqfGJpsz2Nu+ls0WmpFRs/5SKP0yvAd1fqoqv2wbA7tNGHOX
 EFPKPC1w0XlwJ55lmO+S5gRSlmWZoWB4ZpNHg5mdPjiK/xpSNbpmeBiL0KL0rn2aC/6iC7W
 xsGia6jyrG+pvv/jb6D1CX8djgpEOsBjp+po/XRRcbds3zFuOgvS0oMSsxmSA/u+CT0ikVS
 cZvj7kw3LRcWtTzX0TLZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8dkKN/4mk6I=:Q7YW9l9LEAKG6XoTTI6Qzw
 Gz7hrF+K5WnSOFja6h8Nox0BLhRkYteiSdTUtgAYNQY+ZnW7x2aPAdvlUhEe+lbk2/FBINt3a
 6Mc8jCMtm1Z+dWEK2l6JK+90nhCRls/VNNW7znBpV9uuRVnVQ9lZ7y9CoSqQF7/ISUSVZpbmT
 TVlga0+MipR0oWRZNiFwgfLuk0kVJ6L7KbkhaFhYvZcHd+QuUtw+JQVPJ4rOJaxZRcgeFiF6R
 SSk6v+ukPNz1fBIQUFmKIvRYKntRoQBQY9xHwLnbORaXTrc2qtg6x7akrcUIW8B848+OT3lk3
 K8xEWBLeCN+bI4iWM98bpc8JWNNer1/YOeDVkCqIXu/K68J0I6k0cyj2iyx9kJI1Knv1MoXmb
 8+V3Mx/wcrlXO7YNH1j1DnJCYjFt8IqHobB3PXEhNvjncubwdobFmRMGtiSukv3Jrl5S3k2zb
 qPlNm8k0aDwby6XbjCq/ANEg41fRxLDxLlC8hWiRAEw8msk26t3+XYPlRC19pkWM9ccvWgs18
 KMnZJV+TkVmWrRBruw//wPjaVYrMxSNZu3sHHKcpKxax5ShpEyewdgwQ9F5JfLzKOjeDr15YO
 6NESmTPZD8eV/HXBJbUrSL2bxmsswBHJ0H6bMZGFj54Tmzpw+rbpWsDHHHInC+vixHfzLwZSy
 Gf0p+omsWdCCdG/yvQD9bKbhiOCMF1L4IvUMEnPef7Li+HjvzEPIypjSuj1A8t50YNTfYtl/b
 NV7oI9lsu+eFdH2AKRO/Hw+4I/WT2pSfuSIbh4pYRTTS4CV92yjcX8mv3VIGLuIiZan4Y0qz6
 meWS6nu3oINfETx9kFWWgKf1nfKfq6H0+DPmTOfzjZd0//RymD65vps/vLvEGHogni/BFALBi
 DKTLG82T8sZx1g6se0Tx23bFcjNpb+pj7lg/pO5Q7YVCY59OLc1ARciGL7eL2uOhlnRPLK0Y0
 aEf5w4WVoZbO/ACwZKBuG4DrX9CqdTunrn9RWKO+3yPSY4st2faudHBtKPC7G120ATbcuFrkY
 r5xA3TJ/pOTmhXUOe0L+L8rVf8YO9+P+qpmSyPquXrXvWyqrlewkoPPT74ZKo+6eBWY1Y0w6L
 tRieGnWL0e1TRqzYE938IIWGFaMBu+JlsucUsF48MJTRsFu/bu/us3/g4zE43K33ARlSrR1Wm
 icTjwudPZVa9foHmOfHIoglVj4UGSR0oOQfWRtXIbg4lKy4p89n2lvhAEMHczwZ2j50SmoqW1
 luzp8rAYO/q6In+8y+fwB7HCOXsht6+xRzeA4XWKjf+xRb0sYtCRNN7lB64s=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 16 Oct 2019 09:11:51 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 16 Oct 2019 09:11:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Converting a function return type to void based on a
 SmPL constraint?
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

Pj4gSSBnb3QgdGhlIHNvZnR3YXJlIGRldmVsb3BtZW50IGlkZWEgdGhlbiB0byBjaGFuZ2UgdGhl
IGZ1bmN0aW9uIHJldHVybiB0eXBlCj4+IHRvIOKAnHZvaWTigJ0gdG9nZXRoZXIgd2l0aCB0aGUg
ZGVsZXRpb24gb2YgcmV0dXJuIHN0YXRlbWVudHMgYnkgdGhlIGhlbHAgb2YKPj4gdGhlIHRvb2wg
4oCcQ29jY2luZWxsZSAxLjAuOC0wMDAwNC1nODQyMDc1ZjfigJ0gaW5zdGVhZCBvZiBhZGp1c3Rp
bmcgcmV0dXJuIHZhbHVlcy4KPj4KPj4gQHJlcGxhY2VtZW50QAo+PiBjb25zdGFudCBDOwo+PiBp
ZGVudGlmaWVyIGFjdGlvbiwgcmM7Cj4+IHR5cGUgVDsKPj4gQEAKPj4gIHN0YXRpYwo+PiAtVAo+
PiArdm9pZAo+PiAgYWN0aW9uKC4uLikKPj4gIHsKPj4gLVQgcmMgPSBDOwo+PiAgLi4uIHdoZW4g
IT0gcmMKPj4gICAgICB3aGVuIHN0cmljdAo+PiAtcmV0dXJuIHJjOwo+PiAgfQo+Pgo+Pgo+PiBV
bmZvcnR1bmF0ZWx5LCBJIGRvIG5vdCBnZXQgdGhlIHRyYW5zZm9ybWF0aW9uIHJlc3VsdCB3aGlj
aCBJIHdvdWxkIGV4cGVjdAo+PiBmb3IgdGhpcyBhcHByb2FjaC4gQnV0IEkgaGF2ZSBub3RpY2Vk
IGFsc28gdGhhdCBhIHNpbWlsYXIgU21QTCBzY3JpcHQKPj4gY2FuIHdvcmsgYXMgZXhwZWN0ZWQg
KGlmIGEgZnVuY3Rpb24gbGlrZSDigJx1bnBpbl9leHRlbnRfY2FjaGXigJ0gd2FzIG5vdCBtYXJr
ZWQKPj4gYXMg4oCcc3RhdGlj4oCdPykuCj4+IFdvdWxkIHlvdSBsaWtlIHRvIGFkZCBhbnkgYWR2
aWNlcz8KPgo+IEkgZG9uJ3Qga25vdyB3aGF0IHJlc3VsdCB5b3UgZXhwZWN0LAoKSSBndWVzcyB0
aGF0IHlvdSBnb3Qgc2ltaWxhciBleHBlY3RhdGlvbnMgZm9yIHRoZSBhcHBsaWNhdGlvbiBvZiB0
aGUgZmlsZQrigJxzY3JpcHRzL2NvY2NpbmVsbGUvbWlzYy9yZXR1cm52YXIuY29jY2nigJ0uCgoK
PiBub3Igd2hhdCBpcyB0aGUgcmVsZXZhbmNlIG9mIHVucGluX2V4dGVudF9jYWNoZSwKCkl0IGNh
biBiZSBhbm90aGVyIGV4YW1wbGUgZm9yIHRoZSBkZW1vbnN0cmF0aW9uIG9mIG91ciBpbWFnaW5h
dGlvbnMKYXJvdW5kIHRyYW5zZm9ybWF0aW9ucyBhdCBzdWNoIHNvdXJjZSBjb2RlIHBsYWNlcywg
Y2FuJ3QgaXQ/CgoKPiB3aGljaCBpcyBub3QgdGhlIGZ1bmN0aW9uIGxpbmtlZCB0byBhYm92ZS4K
CkFkZGl0aW9uYWwgbGlua3MgY2FuIGJlIGVhc2lseSBmb3VuZC4KCgo+IE15IGFkdmljZSB3b3Vs
ZCBiZSB0byB0YWtlIHRoZSB0aW1lIHRvIGN1dCBkb3duIHRoZSBleGFtcGxlIHRvIGEgZmV3IGxp
bmVzCj4gb2YgY29kZSB0aGF0IGNhbiBlYXNpbHkgZml0IGluIGFuIGVtYWlsLAoKV2hhdCBkb2Vz
IGhpbmRlciB5b3UgdG8gdXNlIGEgY29tcGxldGUgc291cmNlIGNvZGUgYnJvd3NlciAob3IgdGV4
dCBlZGl0b3IpCmJhc2VkIG9uIG9uZSBvZiB0aGUgcHJvdmlkZWQgbGlua3M/CgoKPiBhbmQgdGhl
biBzZW5kIGEgY29tcGxldGUgbWVzc2FnZSB3aXRoIG5vIFVSTHMKCldvdWxkIHlvdSBsaWtlIHRv
IHRha2UgYW5vdGhlciBsb29rIGF0IGltcGxlbWVudGF0aW9uIGRldGFpbHMgZm9yCnRoZSBtZW50
aW9uZWQgdXBkYXRlIGNhbmRpZGF0ZT8KCkV4Y2VycHQgZnJvbSB0aGUgc291cmNlIGZpbGUg4oCc
ZnMvYnRyZnMvZGlzay1pby5j4oCdIGZvciB5b3VyIGNvbnZlbmllbmNlOgrigKYKc3RhdGljIGlu
dCBidHJmc19kZXN0cm95X2RlbGF5ZWRfcmVmcyhzdHJ1Y3QgYnRyZnNfdHJhbnNhY3Rpb24gKnRy
YW5zLAoJCQkJICAgICAgc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8pCnsKCXN0cnVjdCBy
Yl9ub2RlICpub2RlOwoJc3RydWN0IGJ0cmZzX2RlbGF5ZWRfcmVmX3Jvb3QgKmRlbGF5ZWRfcmVm
czsKCXN0cnVjdCBidHJmc19kZWxheWVkX3JlZl9ub2RlICpyZWY7CglpbnQgcmV0ID0gMDsKCglk
ZWxheWVkX3JlZnMgPSAmdHJhbnMtPmRlbGF5ZWRfcmVmczsKCglzcGluX2xvY2soJmRlbGF5ZWRf
cmVmcy0+bG9jayk7CglpZiAoYXRvbWljX3JlYWQoJmRlbGF5ZWRfcmVmcy0+bnVtX2VudHJpZXMp
ID09IDApIHsKCQlzcGluX3VubG9jaygmZGVsYXllZF9yZWZzLT5sb2NrKTsKCQlidHJmc19pbmZv
KGZzX2luZm8sICJkZWxheWVkX3JlZnMgaGFzIE5PIGVudHJ5Iik7CgkJcmV0dXJuIHJldDsKCX0K
CuKApgoKCXNwaW5fdW5sb2NrKCZkZWxheWVkX3JlZnMtPmxvY2spOwoKCXJldHVybiByZXQ7Cn0K
4oCmCgoKPiBvciBpbXBsaWNpdCByZWZlcmVuY2VzIHRvIHByZXZpb3VzIGVtYWlscyB0aGF0IGRl
c2NyaWJlcyB0aGUgcHJvYmxlbS4KCldoZXJlIGRpZCB5b3Ugc2VlIGFkZGl0aW9uYWwgZW1haWwg
cmVmZXJlbmNlcyBmb3IgdGhlIGluaXRpYWwgY2xhcmlmaWNhdGlvbgpyZXF1ZXN0IG9uIHRoaXMg
dG9waWM/CgoKV2lsbCB0aGUgYXBwbGljYXRpb24gb2YgdGhlIFNtUEwgY29uc3RydWN0IOKAnDwr
Li4uIOKApiAuLi4rPuKAnSBiZSBuZWVkZWQgZm9yCnN1Y2ggdXNlIGNhc2VzPwoKUmVnYXJkcywK
TWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNv
Y2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxp
cDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
