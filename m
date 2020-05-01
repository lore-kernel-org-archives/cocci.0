Return-Path: <SRS0=tAXx=6P=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149D5C47253
	for <cocci@archiver.kernel.org>; Fri,  1 May 2020 12:36:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F9520708
	for <cocci@archiver.kernel.org>; Fri,  1 May 2020 12:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="D6RAGNSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F9520708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 041CaPeT013325;
	Fri, 1 May 2020 14:36:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A4707757C;
	Fri,  1 May 2020 14:36:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C270E3DC8
 for <cocci@systeme.lip6.fr>; Fri,  1 May 2020 14:36:24 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 041CaOaR001180
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 1 May 2020 14:36:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588336583;
 bh=Q1f+D414NuvCxzsgOM0QVyYBecTdOZSxeNy0QACSlmk=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=D6RAGNSLs16G7vWbB3A+ih2EyWsps8ixxpHBHbl3VzCWvS3KoI7b+dD0eIHJloJJR
 U3f1edAaZpLCj6yXKrLdIFrR5/pV/9h6vxtsexK4RkmH1FlPkYvNi6pVvVQ7IP/efF
 hqQit3T45CbOsz2yoiKgLl8/zkCQUqEaOspmjf2A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.136.146]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKek3-1jUDNx4BfD-001wL3; Fri, 01
 May 2020 14:36:23 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <fd0d48f1-ba0a-74d6-6eeb-7494600067f7@web.de>
 <alpine.DEB.2.21.2005011348250.2504@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7d135ae6-4f49-4555-d680-62850fddc100@web.de>
Date: Fri, 1 May 2020 14:36:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005011348250.2504@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:YxynhxWBIP14qsGqNWLMuAbcprFKSD+yI8f1imnzH7WLTxSpOzV
 xXZqoKvGgjTtFO8NApdjcX4VZWAf+SAD11zPk5wE5uBVnjsDEkpX5nqr/5Udcei5onIcfEN
 RTEsoE/ozjMGWAUErV7G7Z3ESXNf3TYwF2NqcSHZyhcTLY85LKLj7Ag0DQ4S+HpqhOaG/sA
 h/CLaWG0efc2yZtg8u16Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k8K+YzmjZ3M=:LeBfa051ZDN1GQBfT7kmmm
 UfcHx4TX1Edj6MO+DhfTkslXZ8u9jE5uiQq7ultl4AoWR/cKG1tF3jMGT8wGwRGuMJaTWtzqK
 qdYrx+gPYelisiYd0dlzotr44zhf5uTDgc4Gg6/+A6DRjYzOVyuVGJtiYm2yzSBZtPWeu637v
 H+JJySUbsoqViI240WGrgS5bLx2zwFAx3lQ012jG40XNsLZOwt3TTA9doJE+owSIwk3b0q6rA
 Yu1718dB1eIjlfU1v39Hq/2HaP5hE1GxVOgvNI2uTpEb0JOSldg55OobkUJoui6UTD2C+OTQ1
 vIdRQILP9YOWnAv6oo872SVra8JNFCO+jRrG9HFjwVkBGLLp5woJZJN24vao+FnBtUn0OXEK9
 D6TtlKCWR+3vpQvk+WI7ddPEgYo0+PLK2RIOemnJ30SlNJe2+RiY2h4h0um/jcfoKKA/7hKJ4
 G74s+omtNY9JGbpPg61+w22f1cR1cFgX1bcE8ndSBEu3SpcOg8qgAvfmvTHBL3eiI1ASga8Zs
 tLcqmQDnp+lGS4wLsQDDzCb5zH1zqhoTDAUgNAYil0QFO9VUpB5zsXIrkGRGLKj6MRGlC1eOp
 WtyMOMrZoyAgabkkPNJEh5qBqFXYE5SU/5t3D0TGbaeHAYJVMRT1nzWVtiY7xsBeyIgeeiDri
 DaYsZamMhS1hMTmmuiXBXkafkIWbHvfp73stERp1lhclD2B1IElyzor286EeIhslysSrQs+yB
 8vxMoeWcnvEIiBIjtkATedvyvxoQW2QFwKX9rWi6enp5JuF4ek0zLOPDPW5oe47u8Ug1ZZkqb
 8Q2ep0NPKr0KxTxOXaN8qxvgsBDL8XfTMc4hzz5x2E5JkARMdmc3UbVzzWWbweCo+1pXddXwX
 AWnF3oPHrgJWaBAnRqdAaYBD+TA2Zgsx89W28Z5WpsamWTjpTTBgymROYctKNwQnjDOhSc3k+
 j65rJeuIlvJjE9VsNt5YlkawxNllmGghEXks1yDi4pTm1+UiuUqijpEdgG9CSODdUZC3c0GcD
 5EJFKm5Im11KCwf2hH0kDaYmysIBERl3D5uo8EilMBAYg7sVHjQCbyaliwopqxuNO+1e0UPdh
 FyT9kHeHXPDdrHKaUBqdCP2lnfUhW+rnqKLhLkZ4zNv2veBZb+WrjMG7qKqCE2tNeU4Nl4Cgv
 fG77cFUGSA9jUrufDRuuQqUkB5Am14zcRvoMkCsjldxn1x4ZYE5zQukHoXDCa84N5HF5QAN7x
 ldTDdFGEcP807UTCb
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 01 May 2020 14:36:25 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 01 May 2020 14:36:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Searching for exported Linux functions
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

Pj4gQGRpc3BsYXlACj4+IGlkZW50aWZpZXIgYWN0aW9uOwo+PiB0eXBlIHJldHVybl90eXBlOwo+
PiBAQAo+PiAqcmV0dXJuX3R5cGUgYWN0aW9uKC4uLikKPj4gIHsKPj4gIC4uLgo+PiAgfQo+PiAg
RVhQT1JUX1NZTUJPTChhY3Rpb24pOwo+Pgo+Pgo+PiBCdXQgSSBnZXQgdGhlIGZvbGxvd2luZyBl
cnJvciBtZXNzYWdlIHNvIGZhci4KPj4KPj4gZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2Np
bmVsbGUvamFuaXRvcj4gc3BhdGNoIC0tcGFyc2UtY29jY2kgc2hvd19leHBvcnRlZF9mdW5jdGlv
bnMxLmNvY2NpCj4+IOKApgo+PiBtaW51czogcGFyc2UgZXJyb3I6Cj4+ICAgRmlsZSAic2hvd19l
eHBvcnRlZF9mdW5jdGlvbnMxLmNvY2NpIiwgbGluZSA5LCBjb2x1bW4gMSwgY2hhcnBvcyA9IDg3
Cj4+ICAgYXJvdW5kID0gJ0VYUE9SVF9TWU1CT0wnLAo+PiAgIHdob2xlIGNvbnRlbnQgPSAgRVhQ
T1JUX1NZTUJPTChhY3Rpb24pOwo+Pgo+Pgo+PiBIb3cgYXJlIHRoZSBjaGFuY2VzIGZvciBmdXJ0
aGVyIHNvZnR3YXJlIGV2b2x1dGlvbiBhY2NvcmRpbmcgdG8gc3VjaAo+PiBhIGRhdGEgcHJvY2Vz
c2luZyBhcHByb2FjaD8KPgo+IERvIHlvdSBoYXZlIGFueSBpZGVhIGhvdyBhbm5veWluZyB0aGlz
IGNvbW1lbnQgaXM/CgpJdCBzZWVtcyB0aGF0IHdlIGNvbWUgYWxvbmcgZGlmZmVyZW50IHBvc3Np
YmxlIGludGVycHJldGF0aW9ucwphbHNvIGZvciB0aGlzIGNsYXJpZmljYXRpb24gcmVxdWVzdC4K
Cgo+IEJhc2ljYWxseSwgeW91IGFyZSBzYXlpbmcgIkknbSBzdXJwcmlzZWQgYWJvdXQgdGhlIHJl
c3VsdCwKCiogTXkgc3VycHJpc2UgaXMgbGltaXRlZCBoZXJlLgoKKiBJIGhhdmUgY29udHJpYnV0
ZWQgYW5vdGhlciBzb2Z0d2FyZSB0ZXN0IHJlc3VsdC4KCgo+IHNvIHNvbWVvbmUgZWxzZSBzaG91
bGQgZ28gZml4IHRoZSBzeXN0ZW0gc28gaXQgZG9lcyB3aGF0IEkgdGhpbmsgaXQgc2hvdWxkIGRv
Ii4KCkltcHJvdmVtZW50cyB3aWxsIGRlcGVuZCBvbiBjb3JyZXNwb25kaW5nIGRldmVsb3BtZW50
IHJlc291cmNlcy4KCgo+IENvdWxkbid0IHlvdSBleHByZXNzIHlvdXJzZWxmIGFzICJXaGF0IHNo
b3VsZCBJIGRvIHRvIGdldCB0aGUgcmVzdWx0IEkgZXhwZWN0PyIuCgpJIHVzdWFsbHkgdHJ5IHRv
IGluZm9ybSBjb250cmlidXRvcnMgYWJvdXQgY2hhbmdlIHBvc3NpYmlsaXRpZXMuCgoKPiBUaGF0
IGlzLCBwdXQgdGhlIGJ1cmRlbiBvbiB5b3Vyc2VsZiwgcmF0aGVyIHRoYW4gc2hpZnRpbmcgaXQK
PiBpbW1lZGlhdGVseSB0byBzb21lb25lIGVsc2UuCgpJdCBpcyBpbnRlcmVzdGluZyB0aGF0IHlv
dSBpbnRlcnByZXQgbXkgYnVnIHJlcG9ydCAob3IgZmVhdHVyZSByZXF1ZXN0KQppbiB0aGlzIGRp
cmVjdGlvbi4KCgo+IEluIHRoaXMgY2FzZSwgdGhlIHByb2JsZW0gZW50aXJlbHkgb24geW91ciBz
aWRlLgoKSSBoYXZlIGdvdCBhbiBvdGhlciBpbXByZXNzaW9uLgoKCj4gWW91IHNob3VsZCBzZXBh
cmF0ZSB0aGUgdHdvIHRvcC1sZXZlbCBkZWNsYXJhdGlvbnMgaW50byB0d28gc2VwYXJhdGUgcnVs
ZXMsCj4ganVzdCBsaWtlIGFueSBvdGhlciB0d28gdG9wLWxldmVsIGRlY2xhcmF0aW9ucyB5b3Ug
d291bGQgbGlrZSB0byBtYXRjaC4KCkkgY2FuIHRha2UgYWRkaXRpb25hbCBhbHRlcm5hdGl2ZXMg
aW50byBhY2NvdW50IGFmdGVyIHRoZSBmYWlsdXJlIG9mCmEgZGlyZWN0IGFwcHJvYWNoLgoKCj4g
WW91IGFsc28gbmVlZCBhCj4KPiBkZWNsYXJlciBuYW1lIEVYUE9SVF9TWU1CT0w7Cj4KPiBpbiB0
aGUgcnVsZSB0aGF0IHlvdSBuZWVkIHRvIGNyZWF0ZSBmb3IgbWF0Y2hpbmcgdGhhdCBwYXJ0IG9m
IHRoZSBjb2RlLgoKVGhhbmtzIGZvciB0aGlzIGluZm9ybWF0aW9uLgoKCkBmaW5kQApkZWNsYXJl
ciBuYW1lIEVYUE9SVF9TWU1CT0w7CmlkZW50aWZpZXIgYWN0aW9uOwpAQAogRVhQT1JUX1NZTUJP
TChhY3Rpb24pOwoKQGRpc3BsYXlACmlkZW50aWZpZXIgZmluZC5hY3Rpb247CnR5cGUgcmV0dXJu
X3R5cGU7CkBACipyZXR1cm5fdHlwZSBhY3Rpb24oLi4uKQogewogLi4uCiB9CgoKV291bGQgaXQg
YmUgbmljZXIgaWYgYSBzaW5nbGUgU21QTCBydWxlIHdpbGwgYmUgc3VmZmljaWVudCBpbnN0ZWFk
PwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6
Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
