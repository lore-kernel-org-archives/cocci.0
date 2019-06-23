Return-Path: <SRS0=b71c=UW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5838FC43613
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2019 14:17:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74CFB20663
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2019 14:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="DvTsAnDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CFB20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5NEH7A3013866;
	Sun, 23 Jun 2019 16:17:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 81A57776C;
	Sun, 23 Jun 2019 16:17:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A81CD7761
 for <cocci@systeme.lip6.fr>; Sun, 23 Jun 2019 16:17:05 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5NEH3bO000046;
 Sun, 23 Jun 2019 16:17:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1561299422;
 bh=EyeOx519uO8L7FHNLW/N9h9mZMk1nWhMPYUX0Y0oNb8=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=DvTsAnDSL6GsAANT4oFl2aQfIiBH6+V9mwiP/gKBkm6K/ux96LQvBVmDGLwss6qWF
 vwk131yVLe4MyUcyFxEVVQ+gjO1uijb1NZrQB/QzS88r9jufT2cno/P5S68h63go5H
 N3nkHiuUrSI8hMkawx1Lw57gEeU3UjlgND5VQrxI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.32.213]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ls9F9-1iaU9B2d5j-013y1t; Sun, 23
 Jun 2019 16:17:02 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <f1bb347b-7318-f69f-ad86-bd633c72b375@web.de>
 <alpine.DEB.2.21.1906212251430.2538@hadrien>
 <9d2ef926-62b9-d182-d6d6-cd82ca13173f@web.de>
 <alpine.DEB.2.21.1906221517080.3253@hadrien>
 <4dfb9359-ab09-d206-3110-0fd177ba34b3@web.de>
 <alpine.DEB.2.21.1906221555220.3253@hadrien>
 <5f436d79-b510-b0a3-d11a-d92b8d175f7f@web.de>
 <alpine.DEB.2.21.1906231454520.4961@hadrien>
 <bf3a5ea0-3cda-4342-a6af-b27a4cc0295e@web.de>
 <alpine.DEB.2.21.1906231511450.4961@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <43ca61d9-1d3b-ee05-9e3d-f2f1ced25f6a@web.de>
Date: Sun, 23 Jun 2019 16:17:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906231511450.4961@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:PlBR4l8n6PLBGmsnifa6kHMmXi4kf+B4IezQh67cKvdcdq1Vfzi
 LQqjPjxjMA6DxTL1UwRY7x7+S6g/UaTztCr7cbgzxCH1hUrs044EoRdRszFzbClrxQK5HkF
 SlsV8Jj85GBEVDJanmi24a73unCSWIRn4kGkMckg8S6Y6G/2FNj0YV6lPlnIK+DzlyTisqC
 av7+iRghhsWL/JQ3SnQgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aYld0f1ow/c=:c3cU8wtKZ65Jhnn88wPo+8
 xernLxnSlXECk9Bx4VH0dPr0K94X8rPdpqHglxPam4g/6C9qhTDJpADLTTVj4qa8YpKhGyUBT
 792fOrJb0F4n3qmEs3Q4O2/bLWb7g6i0jOas2dLp1KUWVtDFXqzBngswjvybvK6OYXch63aHZ
 WcitpkSoV/66UI+tmUyjSoQThbpbJTuSswmg25TXAoLyiywsO4J8u8BHI1jr/S+ctDZh5U71L
 qYlP8EZvhUH7m+a0ymAOJdoSBioUcIkmt3FRM3VeSFKdSP+OWZP6Srv4k958fW1Vw7o0GCcGY
 UCNIBpzsFYPkUVxIOmMJFI2ICGKPV/R7svapfwMp0ummnnjjH8VpG5Xs79iRkrtw3IurXiOFV
 4M+yaMGaWZu9yAhjeoAiWaZc8DDkapfpi6WSdMItaGn7vxrzstTGwYVFxBueRyfJHOFtf7fZK
 z3c3HtaEsGZ5CTck7dabhqJS7fHmUalAZq+IXDsvsfo6LPIrkuy+YWq/dA8gNF4JgbuMOtj1q
 Z3PmYiBWSJxucHani5cXvCLNUd4rkxy69U4BAouX/hxVtgmnfQbQoUCteC4/QVfxzfbii4h0A
 y+jnRBT7YvrefMhkH+Ztk2BjgCw1NdtNHRqyshmZ3W2fkZmkUiTvwmrqPMpSHJP4ERaP6hneW
 MhISuTee3i//SgeYUL536YbhCrTk+HiwzWS8HVAfb6MImCwJEEld7pnpQ+5cexmdJYJxzoh/n
 P8M3jQjm4nElkdvDDgAJrRd90o/+TmX7OItH1cdLYmdim34GxbYHJOVFZ2gorCWx4tg1l49Hr
 SP5J7qQwxbz133eJ2rnPU8RDVpWhj+GnS3+qTSeSNfruBwTpcqH5zsm0K54puohX65A8TJx/b
 X4mMYEcmwZr08aXG3N9vfdPkzIzwNk+vo3IsNyjcMzG3q00epvMcNMTVIgg5r70ZGKqz0+dNL
 vv290Wlrd6T2aPom2WbyhW5Yfn2AkGF3I0lz6k2NLel5yONut2VTK
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 23 Jun 2019 16:17:08 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 23 Jun 2019 16:17:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking redundant variable initialisations with SmPL?
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

CgpBbSAyMy4wNi4xOSB1bSAxNToxMyBzY2hyaWViIEp1bGlhIExhd2FsbDoKPgo+Cj4gT24gU3Vu
LCAyMyBKdW4gMjAxOSwgTWFya3VzIEVsZnJpbmcgd3JvdGU6Cj4KPj4+IFRyeQo+Pj4KPj4+IC4u
LiB3aGVuIGFueQo+Pj4KPj4+IGp1c3QgYmVmb3JlIHRoZSBmaW5hbCApLiAgSW4gc29tZSBjaXJj
dW1zdGFjZXMgdGhlIHBhcnNlciBkb2Vzbid0IGFjY2VwdAo+Pj4gYW4gZXhwcmVzc2lvbiBhdCB0
aGUgZW5kIG9mIGEgc2VxdWVuY2UgbGlrZSB5b3UgaGF2ZSBoZXJlLgo+Pgo+PiBUaGFua3MgZm9y
IHlvdXIgcXVpY2sgcmVzcG9uc2UuCj4+Cj4+IFRoZSBhZGRpdGlvbiBvZiBzdWNoIGEgU21QTCBl
bGxpcHNpcyBoZWxwcyBzb21laG93Lgo+PiBCdXQgSSBhbSBzdGlsbCBub3QgcGxlYXNlZCB3aXRo
IHRoZSBnZW5lcmF0ZWQgdHJhbnNmb3JtYXRpb24gcmVzdWx0Lgo+PiBTbyBJIGFtIGN1cmlvdXMg
b24gaG93IHRoaXMgc29mdHdhcmUgY2xhcmlmaWNhdGlvbiB3aWxsIGV2b2x2ZSBmdXJ0aGVyLgo+
Cj4gSSBhbSBub3QgcGxlYXNlZCBpcyBub3QgZXNwZWNpYWxseSBkZXNjcmlwdGl2ZS4KClBhcnRs
eSwgeWVzLgoKCj4gSWYgeW91IGhhdmUgYSBxdWVzdGlvbiBhYm91dCBzb21ldGhpbmcsIHByb3Zp
ZGUgdGhlIHNlbWFudGljIHBhdGNoCgpUaGUgZGlzY3Vzc2VkIFNtUEwgc2NyaXB0IOKAnHZhcmlh
bnQgc2hvd19xdWVzdGlvbmFibGVfdmFyaWFibGVfaW5pdGlhbGlzYXRpb241LmNvY2Np4oCdCih3
aGljaCBpcyBhbm90aGVyIHdvcmsgaW4gcHJvZ3Jlc3MpOgoKQGRpc3BsYXlACmJpbmFyeSBvcGVy
YXRvciBibzEsIGJvMjsKZXhwcmVzc2lvbiBhY3Rpb24sIGUxLCBlMiAhPSBlMSwgZTMsIGU0LCBl
NTsKaWRlbnRpZmllciB2YXI7CnN0YXRlbWVudCBlczEsIGlzMiwgZXMyLCBpczMsIGVzMzsKdHlw
ZSB0OwpAQAooCiB0IHZhciA9IGUxOwogPCsuLi4KIGlmICguLi4pCiB7CiAgICB2YXIgPSBlMjsK
ICAgIC4uLgogfQogZWxzZQogICAgZXMxCiAuLi4rPgogaWYgKCBcKCB2YXIgXHwgdmFyIGJvMSBl
MyBcKSApCiAgICBpczIKIGVsc2UKICAgIGVzMgp8CiB0IHZhcgoqICAgICAgPSBlMQogOwogLi4u
IHdoZW4gIT0gaWYgKCBcKCB2YXIgXHwgdmFyIGJvMiBlNCBcKSApIGlzMyBlbHNlIGVzMwogICAg
IHdoZW4gIT0gYWN0aW9uKC4uLiwgdmFyLCAuLi4pCiAgICAgd2hlbiAhPSBzd2l0Y2ggKHZhcikg
eyBkZWZhdWx0OiAuLi4gfQogICAgIHdoZW4gZXhpc3RzCigKKmU1ID0gPCsuLi4gdmFyIC4uLis+
CnwKKnZhciA9IGU1CikKIC4uLiB3aGVuIGFueQopCgoKPiBhbmQgdGhlIGNvZGUgb24gd2hpY2gg
eW91IGdldCBhbiB1bmRlc2lyZWQgcmVzdWx0LgoKV2UgaGF2ZSBnb3QgYWNjZXNzIHRvIHRoZSBv
cmlnaW5hbCBzb3VyY2UgZmlsZSB3aGljaCBpcyBhbm90aGVyIHVwZGF0ZSBjYW5kaWRhdGUuCmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xp
bnV4LmdpdC90cmVlL2RyaXZlcnMvbWlzYy9sa2R0bS9jb3JlLmM/aWQ9NGI5NzJhMDFhN2RhNjE0
YjQ3OTY0NzVmOTMzMDk0NzUxYTI5NWEyZiNuMzg2Cmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L3Y1LjItcmM2L3NvdXJjZS9kcml2ZXJzL21pc2MvbGtkdG0vY29yZS5jI0wzODYKCgpJ
bnRlcm1lZGlhdGUgdGVzdCByZXN1bHQ6CgrigKYKQEAgLTI4NCw4ICsyODQsNiBAQCBzdGF0aWMg
c3NpemVfdCBsa2R0bV9kZWJ1Z2ZzX2VudHJ5KHN0cnVjCiAJCQkJICAgY29uc3QgY2hhciBfX3Vz
ZXIgKnVzZXJfYnVmLAogCQkJCSAgIHNpemVfdCBjb3VudCwgbG9mZl90ICpvZmYpCiB7Ci0Jc3Ry
dWN0IGNyYXNocG9pbnQgKmNyYXNocG9pbnQgPSBmaWxlX2lub2RlKGYpLT5pX3ByaXZhdGU7Ci0J
Y29uc3Qgc3RydWN0IGNyYXNodHlwZSAqY3Jhc2h0eXBlID0gTlVMTDsKIAljaGFyICpidWY7CiAJ
aW50IGVycjsKCkBAIC0zMDMsMTMgKzMwMSwxMSBAQCBzdGF0aWMgc3NpemVfdCBsa2R0bV9kZWJ1
Z2ZzX2VudHJ5KHN0cnVjCiAJYnVmW2NvdW50XSA9ICdcMCc7CiAJc3RyaW0oYnVmKTsKCi0JY3Jh
c2h0eXBlID0gZmluZF9jcmFzaHR5cGUoYnVmKTsKIAlmcmVlX3BhZ2UoKHVuc2lnbmVkIGxvbmcp
YnVmKTsKCiAJaWYgKCFjcmFzaHR5cGUpCiAJCXJldHVybiAtRUlOVkFMOwoKLQllcnIgPSBsa2R0
bV9yZWdpc3Rlcl9jcG9pbnQoY3Jhc2hwb2ludCwgY3Jhc2h0eXBlKTsKIAlpZiAoZXJyIDwgMCkK
IAkJcmV0dXJuIGVycjsKCgo+IEkgYmVsaWV2ZSB0aGF0IHlvdSBwdXQgYSAqIG9uIGFuIGFzc2ln
bm1lbnQgd2l0aCB2YXIgb24gdGhlIHJpZ2h0IGhhbmQgc2lkZSwKCkkgd291bGQgbGlrZSB0byBz
dHJlc3MgdGhlIGNoYW5nZSBwb3NzaWJpbGl0eSB0byBkZWxldGUgYSB2YWx1ZQpmb3IgYSB2YXJp
YWJsZSBpbml0aWFsaXNhdGlvbiBpZiBpdCB3b3VsZCBiZSByZWFsbHkgdW51c2VkIGluIHRoZQph
bmFseXNlZCBmdW5jdGlvbiBpbXBsZW1lbnRhdGlvbnMuCgoKPiB3aGljaCBhdCBsZWFzdCBkb2Vz
bid0IGNvcnJlc3BvbmQgdG8gbXkgdW5kZXJzdGFuZGluZyBvZiB3aGF0IHlvdQo+IGFyZSB0cnlp
bmcgdG8gZG8sIHNvIHBlcmhhcHMgdGhhdCBpcyB0aGUgcHJvYmxlbS4KCjEuIFRoZSBwYXRjaCBo
dW5rIGZvciB0aGUgZnVuY3Rpb24g4oCcbGtkdG1fZGVidWdmc19lbnRyeeKAnSBwb2ludHMgb3V0
CiAgIHRoYXQgdGhlIHByZXByb2Nlc3NvciBzeW1ib2wg4oCcTlVMTOKAnSBjb3VsZCBiZSBvbWl0
dGVkIGluIHRoaXMgY2FzZS4KCjIuIE5vdyBJIGFtIG1pc3NpbmcgdGhlIHByb3Bvc2VkIGRlbGV0
aW9uIG9mIHRoZSBjb2RlIOKAnCA9IC1FSU5WQUzigJ0KICAgZm9yIHRoZSBmdW5jdGlvbiDigJxs
a2R0bV9tb2R1bGVfaW5pdOKAnSAoYWNjb3JkaW5nIHRvIG15IFNtUEwgcGF0Y2ggYXR0ZW1wdCku
CgpTZWUgYWxzbyBhIHBhdGNoIG9uIHRoZSB0b3BpYyDigJxbbmV4dF0gbGtkdG06IHJlbW92ZSBy
ZWR1bmRhbnQgaW5pdGlhbGl6YXRpb24gb2YgcmV04oCdOgpodHRwczovL2xrbWwub3JnL2xrbWwv
MjAxOS82LzE0LzI2NQpodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTA4
ODk3MS8KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE5MDYxNDA5NDMxMS4yNDAyNC0x
LWNvbGluLmtpbmdAY2Fub25pY2FsLmNvbS8KCgpXZSBob3BlIHN0aWxsIG9uIHNvZnR3YXJlIGRl
dmVsb3BtZW50IHByb2dyZXNzIGZvciB0aGUgaXNzdWUK4oCcQWRkaXRpb24gb2YgZG8td2hpbGUg
c3VwcG9ydCBmb3IgU21QTOKAnS4KaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvcGlwZXJtYWlsL2Nv
Y2NpLzIwMTktQXByaWwvMDA1Nzg2Lmh0bWwKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvY29jY2kv
Q0FBR1FTMnVqVXRlOXRYNEFpNjZhdVA4c3k0emtyeXFFWFprYmlveTgraEtNdlVnbU1BQG1haWwu
Z21haWwuY29tLwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYu
ZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
