Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA48C433E0
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 18:29:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F621212CC
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 18:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="pBuIpIya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F621212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05HIT0K8023510;
	Wed, 17 Jun 2020 20:29:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id ECFDE7577;
	Wed, 17 Jun 2020 20:28:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 42D523D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 20:20:26 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05HIKPCR027475
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 20:20:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592418024;
 bh=JuAdXFQhAcqRaQv0UQpQpVrZ2t1BRKoek5MrEFY+nrM=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=pBuIpIya3KoSIQrTb8PyTbchGkXIRpj5/MucjLyWASoTDozOhCc5XtAJBNQSELwOP
 X8S5o6h7SX28WqisutmIDzegqyqkSn2fcBnnGFZQo0YfEvP6aEAMCKFdedYw3MMeb+
 GAtn0Y6hlnkIV/lfA5x/Q51SB/sE6CBZDbrcxI6k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.115.66]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V26-1jl4RO2HS6-000dFK; Wed, 17
 Jun 2020 20:20:24 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <alpine.DEB.2.21.2004151949230.2381@hadrien>
 <5702b553-d054-33a4-8544-f68ed5457acc@web.de>
 <alpine.DEB.2.21.2004161052210.2447@hadrien>
 <0365dceb-3b66-48cd-c273-4bf7fceb4688@web.de>
 <alpine.DEB.2.21.2004161444300.8125@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7f9a55c2-46db-b36f-6145-2524be4c68c9@web.de>
Date: Wed, 17 Jun 2020 20:20:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004161444300.8125@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:alyd1jHfgyyc4RJIPD8AJaYCl10UzgaqK3BzW/D0gxjelY5IgEl
 Dm0jjv4HU3sEXYtNbuVv0KEjgu815A6k0ayyRtn/qM2JpZFlA7460Hsb+MkkxHmJPhqvhzD
 8tXzDZ8ImIzWqZqwA/sJTlj15mvpnMrPHNgDEdoMpENzNt6Bs+bfzsQXbNJgSdOV2onFJGl
 6JPWCzZ3fuu1eDy3JDayA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k6XO2ldq5Fk=:Tjl0araKxa6dBwfv48l0V/
 Mnul7kN+ifS1TFZqokHzMKyK7B+C47S5dvqUyAM/eKjfdBI9w/ireXHUepMBZWpXMykyqwzV7
 N2WbazaL1Q9oWmpbt3ppYZTsDbCSYHTCBp77mpYysoRta3/rKVVRtB2oG88D0ZRX+e/6jPu+I
 JAviCBMQkHkeLjx9FJj4st8oITQ7bc//pyGY599OSF79Ys1caAQKueLsPPE19dykWpuLUmPob
 rSytCLPXxDB2LJ77TkqIx55+G7Jd5Cuo38Njebd8QL85k/xdC5LrkLgfkCeyqahjPPUqKZpJb
 M3yu6dj9glw99tvSfRob4N8CxlD/PtDuMyCxSYFF1ToN5zzNZNjmaOFc3mni6smMaEujq/GNr
 F4FRxhJYdrmi3pdDG9TGr2umEjrvvYp/uXUAAQySNcIkwjPNpJ8VIQuUxQO7OS3ynUCgD9OQU
 sreXCCcZE7Nynh6F1NrPoGiM7baR7apdyrCjc1cxRVF35xcIKme3iXGD5gO6gOu5FzSQ3j7YM
 T2VsEBTRftTg+xuCrwbBsTLH3R4TzxPWIq9cDtwd0MQSrfD5UwqHcLOTjKHc1UEW06MiPsEEs
 ypr73gMekC/BABbuZgLKdbW+G82AIR/JVcYltNNz7GyH+BgmiCk+fOZbLwnOPa90IcHJmioYH
 MorYeSmvpmMZKUBbRgLxFkGIj0OF29K9oB1RXRNTE4P87RdbC6KhYAd4M4ntB9RoEzpQu920N
 T6LCBjExuevCzRPy/jUVqJhn8TmzVaqhr2GekJEtuQRobnyCSP6u8CDo+N6MzBj/tNDCDDG8n
 zjZTBdNsESRzwkB8xm7Y1EmF7SwuVM4t99NMrEllpjMXcmmtEdK8lyqx9w89TEv5Ug/bD3cIJ
 6gmA7K9jPxuh5vStSnB/ddSqhZEf65c5vukNlyaQMH/a8fJLOECNFcd4AMNaWRJ70WmuiOGmS
 uhNoW9KeL6MvWzd+4EUnNKjYGFErfGVQjnpGXJvNLedyxlg+ugKFh+3lOh1H2k+qMZVrMiWD5
 G8y94+P15vr9e4oPM1OfF6Zi96k2JPbw+gNUGCwiODlx8zRY+lRgZsdMlRULtlD+3he9UqwZQ
 ToTFKNXMrm4UKmO9CoVSEi5GshpYCB7r/fOswwOyJb768VI5gri6/DqxdzPhREtsikmGes/9m
 5fDQusWZVL/xcuT1g7qDtogh3Baw4JSl6Z/N2r2YtJZ/fBxJvO3fHd24YqqmnJLaCXK6yk1wh
 Ed7TEBxkRHGH26+p5
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 20:29:00 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 20:20:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 17 Jun 2020 20:28:58 +0200
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking the replacement of two specific function calls
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

Pj4+PiBlbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvTGludXgvbmV4dC1wYXRjaGVkPiBzcGF0Y2gg
LS1pbmNsdWRlLWhlYWRlcnMtZm9yLXR5cGVzIH4vUHJvamVrdGUvQ29jY2luZWxsZS9qYW5pdG9y
L3VzZV9kZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZTMuY29jY2kgZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy1yY2FyLmMKPj4+Cj4+PiBObywgaW5jbHVkZSBoZWFkZXJzIGZvciB0
eXBlcyBkb2Vzbid0IGhhdmUgYW55IGltcGFjdCBvbiBob3cgbWFueSBoZWFkZXIKPj4+IGZpbGVz
IGFyZSBpbmNsdWRlZC4gIFlvdSBuZWVkIG9wdGlvbnMgbGlrZSAtLWFsbC1pbmNsdWRlcyBvcgo+
Pj4gLS1yZWN1cnNpdmUtaW5jbHVkZXMuCj4+Cj4+IEkgc3RpbGwgb2JzZXJ2ZSB0aGF0IHRoZSBr
bm93biBwYXRjaCBodW5rIGlzIG5vdCBnZW5lcmF0ZWQgZXZlbiB3aXRoIHRoZSBhZGRpdGlvbgo+
PiBvZiBvbmUgb2YgdGhlc2UgY29tbWFuZCBvcHRpb25zLgo+PiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTIyMzczNC8KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtaTJjLzIwMjAwNDE0MTM0ODI3LjE4Njc0LTEtemhlbmdkZWppbjVAZ21haWwuY29tLwo+
Pgo+PiBXb3VsZCBJIG5lZWQgYW55IGV4dHJhIHBhcmFtZXRlcnMgaGVyZT8KPgo+IFBlcmhhcHMg
LUkgb3B0aW9ucyB0byBoZWxwIGl0IGZpbmQgdGhlIHJlbGV2YW50IC5oIGZpbGUuCgpJIGJlY2Ft
ZSBjdXJpb3VzIGlmIHRoZSBzb2Z0d2FyZSBzaXR1YXRpb24gY2FuIGJlIGNsYXJpZmllZCBiZXR0
ZXIuCgpUaHVzIEkgaGF2ZSB0ZXN0ZWQgbXkgdHJhbnNmb3JtYXRpb24gYXBwcm9hY2ggYWdhaW4g
d2l0aCB0aGUgY29tbWl0CuKAnGkyYzogYWx0ZXJhOiB1c2UgcHJvcGVyIHZhcmlhYmxlIHRvIGhv
bGQgZXJybm/igJ0gYmVmb3JlIHRoZSByZWZlcmVuY2VkIGNoYW5nZS4KCgpAcmVwbGFjZW1lbnRA
CmV4cHJlc3Npb24gYmFzZSwgZGV2aWNlLCByZXNvdXJjZTsKQEAKLXJlc291cmNlID0gcGxhdGZv
cm1fZ2V0X3Jlc291cmNlKGRldmljZSwgSU9SRVNPVVJDRV9NRU0sIDApOwogYmFzZSA9Ci0gICAg
ICAgZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZkZXZpY2UtPmRldiwgcmVzb3VyY2UpCisgICAgICAg
ZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoZGV2aWNlLCAwLCAmcmVzb3Vy
Y2UpCiA7CgoKCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9MaW51eC9uZXh0LXBhdGNoZWQ+IGdp
dCBjaGVja291dCBlZGIyYzlkZDM5NDg3MzhlZjAzMGMzMmI5NDg1NDNlODRmNGQzZjgxICYmIExB
Tkc9QyBtYWtlIE1PREU9cGF0Y2ggQ09DQ0k9fi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0b3Iv
dXNlX2Rldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlMy5jb2NjaSBNPWRyaXZl
cnMvaTJjL2J1c3NlcyBWPTEgY29jY2ljaGVjawpSdW5uaW5nICg0IGluIHBhcmFsbGVsKTogL3Vz
ci9sb2NhbC9iaW4vc3BhdGNoIC1EIHBhdGNoIC0tdmVyeS1xdWlldCAtLWNvY2NpLWZpbGUgL2hv
bWUvZWxmcmluZy9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0b3IvdXNlX2Rldm1fcGxhdGZvcm1f
Z2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlMy5jb2NjaSAtLXBhdGNoIC4gLS1kaXIgZHJpdmVycy9p
MmMvYnVzc2VzIC1JIC4vYXJjaC94ODYvaW5jbHVkZSAtSSAuL2FyY2gveDg2L2luY2x1ZGUvZ2Vu
ZXJhdGVkIC1JIC4vaW5jbHVkZSAtSSAuL2FyY2gveDg2L2luY2x1ZGUvdWFwaSAtSSAuL2FyY2gv
eDg2L2luY2x1ZGUvZ2VuZXJhdGVkL3VhcGkgLUkgLi9pbmNsdWRlL3VhcGkgLUkgLi9pbmNsdWRl
L2dlbmVyYXRlZC91YXBpIC0taW5jbHVkZSAuL2luY2x1ZGUvbGludXgva2NvbmZpZy5oIC0tam9i
cyA0IC0tY2h1bmtzaXplIDEKY29jY2ljaGVjayBmYWlsZWQKbWFrZTogKioqIFtNYWtlZmlsZTox
NzgxOiBjb2NjaWNoZWNrXSBFcnJvciAyNTUKCgpJIGNhbiB0cnkgYW5vdGhlciBjdXN0b21pc2Vk
IGNvbW1hbmQgb3V0IHdpdGggdGhlIHNob3duIHBhcmFtZXRlcnMuCgplbGZyaW5nQFNvbm5lOn4v
UHJvamVrdGUvTGludXgvbmV4dC1wYXRjaGVkPiBzcGF0Y2ggLUkgLi9hcmNoL3g4Ni9pbmNsdWRl
IC1JIC4vYXJjaC94ODYvaW5jbHVkZS9nZW5lcmF0ZWQgLUkgLi9pbmNsdWRlIC1JIC4vYXJjaC94
ODYvaW5jbHVkZS91YXBpIC1JIC4vYXJjaC94ODYvaW5jbHVkZS9nZW5lcmF0ZWQvdWFwaSAtSSAu
L2luY2x1ZGUvdWFwaSAtSSAuL2luY2x1ZGUvZ2VuZXJhdGVkL3VhcGkgLS1pbmNsdWRlIC4vaW5j
bHVkZS9saW51eC9rY29uZmlnLmggfi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0b3IvdXNlX2Rl
dm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlMy5jb2NjaSBkcml2ZXJzL2kyYy9i
dXNzZXMvaTJjLXJjYXIuYwppbml0X2RlZnNfYnVpbHRpbnM6IC91c3IvbG9jYWwvYmluLy4uL2xp
Yi9jb2NjaW5lbGxlL3N0YW5kYXJkLmgKSEFORExJTkc6IGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMt
cmNhci5jCgoKTWF5IEkgZXhwZWN0IHRoZSBnZW5lcmF0aW9uIG9mIGEgcGF0Y2ggYnkgdGhlIENv
Y2NpbmVsbGUgc29mdHdhcmUgaGVyZT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lA
c3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8v
Y29jY2kK
