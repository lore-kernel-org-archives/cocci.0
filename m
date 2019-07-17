Return-Path: <SRS0=ZAj6=VO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684B9C76192
	for <cocci@archiver.kernel.org>; Wed, 17 Jul 2019 08:02:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8568321743
	for <cocci@archiver.kernel.org>; Wed, 17 Jul 2019 08:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XlpPbq6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8568321743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6H81pMt003048;
	Wed, 17 Jul 2019 10:01:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6D91D777E;
	Wed, 17 Jul 2019 10:01:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 418E7777C
 for <cocci@systeme.lip6.fr>; Wed, 17 Jul 2019 10:01:44 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6H81fsV026053;
 Wed, 17 Jul 2019 10:01:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1563350477;
 bh=jkEaRlO2fi+2jTPU/PB+JLfb55RGjL5j70dNr41geHE=;
 h=X-UI-Sender-Class:Subject:Cc:References:To:From:Date:In-Reply-To;
 b=XlpPbq6zD2Mqj6RqNbU1nxa1cwe9Tz+RXB6Y6f9HrL2nWrX10LJzIilh2gm0wlh4T
 VUTdVR7TZXKkc+EHr3yX/l8DhAHPszSGeIdqeh8jpbwQVwG4TiH/D3tNoUgRKXr54L
 ZXFLB9dreaB6br8fKDDo0Hr5FDMk2d++KRTPyPik=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.123.82]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lj2Dy-1iIsHz0aSs-00dHbB; Wed, 17
 Jul 2019 10:01:17 +0200
References: <201907171143136548526@zte.com.cn>
To: Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <17342c44-256f-8899-0662-b0fe7168f647@web.de>
Date: Wed, 17 Jul 2019 10:00:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201907171143136548526@zte.com.cn>
Content-Language: en-GB
X-Provags-ID: V03:K1:GDirqPjxEbr0gRYyhJbA0LvAthEiYXRKwdA1rtkopru4NxZh2d2
 rYmacmVG5iqPgaefuTBD9oC5eh6Gupge1n56XRiiTFdgaxS2X2FpKTP6pSvXq7AIxr1YdpS
 tNZ2Bg4qB01+hgjis++k2ExBgS/ZG13IiO+EpOQnsHK+0s93izApWaHxO+FOw99iy/NRADh
 HbDKmZMhBFArFtuyNZdRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5IDi0Y8+vXs=:K51mmenoEJA+37/Y6sjdrQ
 pAr9kbTOgeuqPwre6mqAP3jhw/o6XK+PNG94jZo8SxwvPqEPRZUTqVamtAb5UdDd/NHuWnV3T
 7Y9ffYOz95fUu6f/2VpbOzCLTNpw7Nn8lSiA5eFJ2TbL+Zp3yk5mZ+TZK+pTZu6pUmNRNkose
 8N3Te39IUAxxe95iAonq+Z789w8FXGZYhUkfQ0xvZ+GwdGWFYbSwJxDOyU22sRCJXZ80sh77T
 ZgpNAXlHZ77oaMCGnY+V6+vHNsFhxX/5VtpArsK2ZP9RqWr4OtMMnxvEoH3sTzy2wbnS1SFHh
 Dtr6h4SF4u81Ce0NGSF0/wuKDSxhsD0oPYcp9hEnIkS5HTM1WZSL1Jy5TiuVW/CFLDac1GEpX
 q96mqcRAhrB+bgVxdLF96tA5nJTtLdBn0OPkoDX9SokTakP3/hg5ZMwTYDeYjf64mPYa64gcs
 5WZCq1CpJA3wx2p4Q8gJdchv7LTZMYfevEdq9AblzrKUGJ7kUrOdm/c8t3HazPINywR4ZZI4d
 mT8XNjEBhyzGoQlb0GrQadnpPnEt2dla+B3bwT0jZMTnXdd3f+uWRnL8NoSAb06SVrB3kO5lH
 2L1tKNaf/eCDzfYEDBfjkwNPJ22aefq42yhs19OlKWFS03Ui9JhDYRnxIUMufleZHV+xTPi8k
 6m2A8SGA69n51FfI6cEX+b1Jyyn7DyIVzPUrfaslLUnmCcxYKVh4BtAE8xbqV99dpqTRYG1j3
 I61A5wtfArSYt+dlUSUahws0nnCI3y5EVjrv47zq2hc7ZxDyl7kwXxI5MkzhHRoJZm7GqIp6+
 gCXqEbU5WS65k0vVdQpCbVmo9kqguwUTZZ2gD46DYuK6eumf1meIhwqKU5+pKoVmFp9liMzq1
 NI5mgugCdH1FxYSDsb17BmsO+H2Ylz+Yw7kmv7oOap8OuhiN1vRBgUJJpMcsyujs3G7ymNteE
 C1lnipcpTCCwAIaYQM6YKo7f1V5+nqfEIvVnagIqeyo8ypQEmR3z0ATlE4DeIpy60XTymKhk8
 bRat04I1wp4oUlSNGigahqrMjJn2ILvlmFuQqLq8k5emnAdyxruoiV7rUyQ5pQUa6bZtWfEh8
 UskXJgIX2BfDJvR+XX20V5KXLyGqF8lR4xs
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jul 2019 10:01:52 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jul 2019 10:01:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>
Subject: Re: [Cocci] [v3] coccinelle: semantic code search for missing
	of_node_put
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

PiAyKSwgVGhlbiBTbVBMIEEgZ2VuZXJhdGVzIGFub3RoZXIgU21QTCBCIGJhc2VkIG9uIHRoZSBm
dW5jdGlvbiBuYW1lIGxpc3Q7CgpUaGlzIHdvdWxkIGJlIGEgZ2VuZXJhbCBkYXRhIHByb2Nlc3Np
bmcgcG9zc2liaWxpdHkuCkFub3RoZXIgb3B0aW9uIHdvdWxkIGJlIHRvIGxldCBTbVBMIHNjcmlw
dHMgdG8gaW1wb3J0IHJlbGV2YW50IGRhdGEKZnJvbSBleHRlcm5hbCBmaWxlcyBvciB0byBxdWVy
eSBmYWN0cyBmcm9tIGRhdGFiYXNlcy4KCgo+IFlvdSBleHBlY3QgdGhlIGVudGlyZSBwcm9jZXNz
IGFib3ZlIHRvIGJlIGF1dG9tYXRlZC4KCkkgaG9wZSB0aGF0IHRoaXMgY2FuIGJlIGFjaGlldmVk
IGZpbmFsbHkuCgoKPiBUaGlzIGlkZWEgbWF5IGJlIGludGVyZXN0aW5nLAoKVGhhbmtzIGZvciB5
b3VyIGZlZWRiYWNrLgoKCj4gYnV0IGl0IGNhbid0IGJlIGRvbmUgbm93LAoKSSBnb3QgYW4gb3Ro
ZXIgdmlldy4gLSBXaHkgaXMgeW91ciB2aWV3IHNvIGxpbWl0ZWQgYXQgdGhlIG1vbWVudD8KCgo+
IGFuZCBpdCB3aWxsIGludHJvZHVjZSB1bmNvbnRyb2xsYWJsZSBmYWN0b3JzLgoKSSBzdWdnZXN0
IHRvIHRha2UgYWRkaXRpb25hbCBkZXNpZ24gb3B0aW9ucyBpbnRvIGFjY291bnQgc28gdGhhdCB5
b3UgbWlnaHQgZ2V0Cm1vcmUgY29udHJvbCBvbiBzb21lIGZhY3RvcnMuCldoaWNoIHNvZnR3YXJl
IGRldmVsb3BtZW50IGNoYWxsZW5nZXMgYXJlIHN0aWxsIHdhaXRpbmcgZm9yIGJldHRlciBzb2x1
dGlvbnM/CgoKPiBXZSBhZ3JlZSB3aXRoIGp1bGlhJ3MgY29tbWVudHM6Cj4gSSB3b3VsZCBwcmVm
ZXIgbm90IHRvIHB1dCBzZW1hbnRpYyBwYXRjaGVzIHRoYXQgaW52b2x2ZSBpdGVyYXRpb24gaW50
byB0aGUga2VybmVsLCBmb3Igc2ltcGxpY2l0eS4KCkkgZ3Vlc3MgdGhhdCB0aGlzIGtpbmQgb2Yg
Y2hhbmdlIHJlbHVjdGFuY2UgY2FuIGJlIGFsc28gYWRqdXN0ZWQuClNvbWUgc291cmNlIGNvZGUg
YW5hbHlzaXMgYXBwcm9hY2hlcyBjYW4gbG9vayBzaW1wbGUgZW5vdWdoCndoaWxlIGFkdmFuY2Vk
IG9uZXMgd2lsbCBzaG93IG1vcmUgb2YgdGhlIGluaGVyZW50IGNvbXBsZXhpdHkuCgoKPiBPdXIg
ZmlsZSBpcyBjYWxsZWQgb2Zfbm9kZV9wdXQuY29jY2ksIHdoaWNoIGNvbnRhaW5zIHRocmVlIHJ1
bGVzOiByX21pc3NfcHV0LAo+ICByX21pc3NfcHV0X2V4dCBhbmQgcl91c2VfYWZ0ZXJfcHV0LgoK
VGhpcyBjb21iaW5hdGlvbiBpcyBpbnRlcmVzdGluZywgaXNuJ3QgaXQ/CgoKPiBJZiB5b3Ugc2Vw
YXJhdGUgdGhlbSwgaXQgc2VlbXMgaW5hcHByb3ByaWF0ZS4KCiogV291bGQgeW91IGxpa2UgdG8g
YmUgYWJsZSB0byBsZXQgZWFjaCBzb3VyY2UgY29kZSBhbmFseXNpcyB0YXNrIHRvIGJlIGV4ZWN1
dGVkCiAgb24gaXRzIG93bj8KCiogSSBndWVzcyB0aGF0IGl0IGNhbiBiZWNvbWUgcG9zc2libGUg
d2l0aCBhZGRpdGlvbmFsIGRldmVsb3BtZW50IGVmZm9ydHMKICB0byBzdXBwb3J0IGFsc28gYSBt
aXh0dXJlIG9mIGFuYWx5c2lzIHBhdHRlcm5zLgoKKiBUaGUgcGF0Y2ggc3ViamVjdCDigJzigKYg
bWlzc2luZyDigKbigJ0gZG9lcyBwcm9iYWJseSBub3QgZml0IHRvIHRoZSBkZXRlY3Rpb24g4oCc
dXNlIGFmdGVyIOKApuKAnS4KCgo+Pj4gdjM6IGRlbGV0ZSB0aGUgZ2xvYmFsIHNldCwg4oCmCj4+
Cj4+IFRvIHdoaWNoIHByZXZpb3VzIGltcGxlbWVudGF0aW9uIGRldGFpbCBkbyB5b3UgcmVmZXIg
aGVyZT8KPgo+IEhlcmUgaXMgYW4gaW1wcm92ZW1lbnQgYmFzZWQgb24ganVsaWEncyBjb21tZW50
czoKPiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS83LzUvNTUKCkkgd291bGQgZmluZCBhbiBv
dGhlciBkZXNjcmlwdGlvbiBjbGVhcmVyIHRoZW4uCiogRHJvcCBvZiBmdW5jdGlvbnMgYXJvdW5k
IOKAnGFkZF9pZl9ub3RfcHJlc2VudOKAnQoqIE9taXNzaW9uIG9mIGl0ZXJhdGlvbiBmdW5jdGlv
bmFsaXR5CgoKQXJlIGFueSBtb3JlIGFkanVzdG1lbnRzIHdvcnRoIHRvIGJlIGV4cGxpY2l0bHkg
bWVudGlvbmVkIGluIHRoaXMgcGF0Y2ggY2hhbmdlIGxvZz8KCgo+IEhlcmUgYXJlIHNvbWUgaW1w
cm92ZW1lbnRzLgoKQXJlIHlvdSBnb2luZyB0byBjb250cmlidXRlIGZ1cnRoZXIgcGF0Y2ggdmVy
c2lvbnM/CgoKPiBBZGRpbmcgYW4gYXN0ZXJpc2sgaGVyZSBpcyBtb3JlIGNvbnZlbmllbnQgdG8g
dXNlLAoKVGhpcyBtaWdodCBiZS4gLSBJIHdvbmRlciBob3cgZ29vZCBhZGRpdGlvbmFsIGRhdGEg
Zml0IHRvIHN1cHBvcnRlZCBvdXRwdXQgZm9ybWF0cy4KCgo+IGl0IGNhbiBtYXJrIHRoZSBsb2Nh
dGlvbiBvZiB0aGUgY29kZSBvZiBpbnRlcmVzdCwgc3VjaCBhczoKCkkga25vdyBpdHMgZnVuY3Rp
b25hbGl0eSBhbHNvLiAtIEkgZ290IHRoZSBpbXByZXNzaW9uIHRoYXQgdGhlIHVzZSBvZiBTbVBM
IGFzdGVyaXNrcwp3aWxsIGJlIHNhZmUgZm9yIHRoZSBvcGVyYXRpb24gbW9kZSDigJxjb250ZXh0
4oCdLgoKCj4+PiArLi4uIHdoZW4gIT0gZSA9IChUKXgKPj4+ICsgICAgd2hlbiAhPSB0cnVlIHgg
PT0gTlVMTAo+Pgo+PiBXaWxsIGFzc2lnbm1lbnQgZXhjbHVzaW9ucyBnZXQgYW55IG1vcmUgc29m
dHdhcmUgZGV2ZWxvcG1lbnQgYXR0ZW50aW9uPwo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzAzY2M0ZGY1LWNlN2YtYmE5MS0zNmI1LTY4N2ZlYzhjNzI5N0B3ZWIuZGUvCj4+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMDk1MTY5LyMxMjkxODkyCj4+IGh0
dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzYvMjkvMTkzCgpXaWxsIHRoaXMgYXNwZWN0IGV2b2x2
ZSBmdXJ0aGVyIGFueWhvdz8KCgo+PiBZb3UgcHJvcG9zZSBvbmNlIG1vcmUgdG8gdXNlIGEgU21Q
TCBjb25qdW5jdGlvbiBpbiB0aGUgcnVsZSDigJxyX21pc3NfcHV0X2V4dOKAnS4KPj4gSSBhbSBh
bHNvIHN0aWxsIHdhaXRpbmcgZm9yIGEgZGVmaW5pdGl2ZSBleHBsYW5hdGlvbiBvbiB0aGUgYXBw
bGljYWJpbGl0eQo+PiBvZiB0aGlzIGNvbWJpbmF0aW9uLgoKV291bGQgeW91IGxpa2UgdG8gY2xh
cmlmeSB0aGlzIHNvZnR3YXJlIGRldGFpbCBhbnkgbW9yZT8KCgo+Pj4gK0ByX3VzZV9hZnRlcl9w
dXQgZXhpc3RzQAo+Pj4gK2V4cHJlc3Npb24gcl9wdXQuRSwgc3ViRTw9cl9wdXQuRTsKPj4KPj4g
SSBoYXZlIGdvdCBhbiB1bmRlcnN0YW5kaW5nIGRpZmZpY3VsdHkgYXJvdW5kIHRoZSBpbnRlcnBy
ZXRhdGlvbgo+PiBvZiB0aGUgc2hvd24gU21QTCBjb25zdHJhaW50Lgo+PiBIb3cgd2lsbCB0aGUg
Y2xhcmlmaWNhdGlvbiBiZSBjb250aW51ZWQ/CgpNb3JlIGhlbHBmdWwgaW5mb3JtYXRpb24/CgoK
PiArfAo+ICsgZiguLi4sYywuLi4sKFQpRSwuLi4pCgpJIHdvdWxkIGludGVycHJldCBzdWNoIHBh
c3Npbmcgb2YgYSBwb2ludGVyIGZvciBhIGRldmljZSBub2RlCmFzIGFuIHVuZGVzaXJhYmxlIOKA
nHVzZSBhZnRlciBmcmVlIChvciBwdXQp4oCdLgpXaWxsIHRoaXMgU21QTCBkaXNqdW5jdGlvbiBu
ZWVkIGZ1cnRoZXIgYWRqdXN0bWVudHM/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2Np
QHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZv
L2NvY2NpCg==
