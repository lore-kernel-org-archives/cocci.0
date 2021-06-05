Return-Path: <SRS0=Fsbo=LB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334E4C47082
	for <cocci@archiver.kernel.org>; Mon,  7 Jun 2021 05:32:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840FB6120F
	for <cocci@archiver.kernel.org>; Mon,  7 Jun 2021 05:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840FB6120F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1575W0Nv024308;
	Mon, 7 Jun 2021 07:32:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B615877FD;
	Mon,  7 Jun 2021 07:31:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D38207666
 for <cocci@systeme.lip6.fr>; Mon,  7 Jun 2021 07:31:57 +0200 (CEST)
Received: from mail.zx2c4.com (mail.zx2c4.com [104.131.123.232])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 1575VuUf016504
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 7 Jun 2021 07:31:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1622917975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5Noua8GkwWGta148lVFb/EtDQaeDAvLUL7HhMXXyPc=;
 b=EgvO42MyisZk/C3LEDprITEoKTcQya8i3EHwxfO/wW3DprKx9zZTDTboR6jknjt0OEwSLv
 FDKUoGB6NcGFI5UIuzgw+pWD/pHg4Arofht3YM6LmMGUgG/XhwFHWO8wZ2ipTEBgoWNlwy
 REAsrTVqL+MjZBpw1M1GVjQy6TVEAbY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 22c684cf
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO); 
 Sat, 5 Jun 2021 18:32:55 +0000 (UTC)
Date: Sat, 5 Jun 2021 20:32:52 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <YLvDVI9TCEVoL16r@zx2c4.com>
References: <CAHmME9rRQmSLkU6ELNiC=pr-D7CGjdyw27_oXdBp+hMdn8WQ5Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2106051335410.25155@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2106051335410.25155@hadrien>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 07 Jun 2021 07:32:00 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 07 Jun 2021 07:31:57 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] struct type renaming in the absence of certain function
 calls on members
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

SGkgSnVsaWEsCgpIb2x5IG1hY2tlcmVsLCB0aGF0J3MgYW1hemluZy4gVGhhbmsgeW91IHNvIG11
Y2ghIFZlcnkgZmFuY3kgZW1iZWRkaW5nCnRoZSBvY2FtbCBpbiB0aGVyZSwgYW5kIGp1c3QgdXNp
bmcgYSBoYXNoIHRhYmxlLiBOZWF0IGlkZWEuCgpJJ20gcnVubmluZyBpdCAod2VsbCwgYSBtb2Rp
ZmllZCB2ZXJzaW9uLCBwYXN0ZWQgYmVsb3cpIG9uIGEgY29kZWJhc2UKYW5kIGZpbmRpbmcgdGhh
dCBpdCBmYWlscyB0byByZXBsYWNlIHRoZSAic3RydWN0IHJ3bG9jayB4IiB3aXRoICJzdHJ1Y3QK
bXR4IHgiIGluIG1vc3QgY2FzZXMsIGV4Y2VwdCBvbmUsIHdoaWNoIGlzIHN0cmFuZ2UuIEkgd29u
ZGVyIGlmIGl0J3MgdGhlCnBhcnNlciBjaG9raW5nIG9uIG1hY3JvcyBpdCBkb2Vzbid0IHVuZGVy
c3RhbmQgaW4gdGhlIGNvZGU/IE9yIG9uCnNvbWV0aGluZyBlbHNlPwoKQ29kZSBpcyBoZXJlLCBp
ZiB5b3UncmUgY3VyaW91czoKCiQgZ2l0IGNsb25lIGh0dHBzOi8vZ2l0Lnp4MmM0LmNvbS93aXJl
Z3VhcmQtZnJlZWJzZAokIGNkIHdpcmVndWFyZC1mcmVlYnNkL3NyYwokIHNwYXRjaC5vcHQgLS1z
cC1maWxlIGRvaXQuY29jY2kgLWogNCAtLXJlY3Vyc2l2ZS1pbmNsdWRlcyAtLWluY2x1ZGUtaGVh
ZGVycy1mb3ItdHlwZXMgLS1pbmNsdWRlLWhlYWRlcnMgLS1pbi1wbGFjZSAuCgpJJ2xsIGtlZXAg
cGxheWluZyB3aXRoIGl0IHRvIHNlZSB3aGF0J3MgaGFwcGVuaW5nLi4uCgpKYXNvbgoKPT0gZG9p
dC5jb2NjaSA9PQoKdmlydHVhbCBhZnRlcl9zdGFydAoKQGluaXRpYWxpemU6b2NhbWxACkBACgps
ZXQgaGFzX3dyaXRlX3RhYmxlID0gSGFzaHRibC5jcmVhdGUgMTAxCmxldCBoYXNfcmVhZF90YWJs
ZSA9IEhhc2h0YmwuY3JlYXRlIDEwMQoKbGV0IG9rIGkgbSA9CsKgIGxldCBlbnRyeSA9IChpLG0p
IGluCsKgIEhhc2h0YmwubWVtIGhhc193cml0ZV90YWJsZSBlbnRyeSAmJiBub3QoSGFzaHRibC5t
ZW0gaGFzX3JlYWRfdGFibGUgZW50cnkpCgpAaGFzdyBkZXBlbmRzIG9uICFhZnRlcl9zdGFydEAK
aWRlbnRpZmllciBpLG07CnN0cnVjdCBpIHg7CkBACgooCnJ3X3dsb2NrKCZ4Lm0pCnwKcndfd3Vu
bG9jaygmeC5tKQopCgpAc2NyaXB0Om9jYW1sQAppIDw8IGhhc3cuaTsKbSA8PCBoYXN3Lm07CkBA
Ckhhc2h0YmwucmVwbGFjZSBoYXNfd3JpdGVfdGFibGUgKGksbSkgKCkKCkBoYXNyIGRlcGVuZHMg
b24gIWFmdGVyX3N0YXJ0QAppZGVudGlmaWVyIGksbTsKc3RydWN0IGkgeDsKQEAKCigKcndfcmxv
Y2soJngubSkKfApyd19ydW5sb2NrKCZ4Lm0pCikKCkBzY3JpcHQ6b2NhbWxACmkgPDwgaGFzci5p
OwptIDw8IGhhc3IubTsKQEAKSGFzaHRibC5yZXBsYWNlIGhhc19yZWFkX3RhYmxlIChpLG0pICgp
CgpAZmluYWxpemU6b2NhbWwgZGVwZW5kcyBvbiAhYWZ0ZXJfc3RhcnRACnd0IDw8IG1lcmdlLmhh
c193cml0ZV90YWJsZTsKcnQgPDwgbWVyZ2UuaGFzX3JlYWRfdGFibGU7CkBACgpsZXQgcmVkbyB0
cyBkc3QgPQrCoCBMaXN0Lml0ZXIgKEhhc2h0YmwuaXRlciAoZnVuIGsgXyAtPiBIYXNodGJsLmFk
ZCBkc3QgayAoKSkpIHRzIGluCnJlZG8gd3QgaGFzX3dyaXRlX3RhYmxlOwpyZWRvIHJ0IGhhc19y
ZWFkX3RhYmxlOwoKbGV0IGl0ID0gbmV3IGl0ZXJhdGlvbigpIGluCml0I2FkZF92aXJ0dWFsX3J1
bGUgQWZ0ZXJfc3RhcnQ7Cml0I3JlZ2lzdGVyKCkKCigqIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICopCgpAdHkyIGRlcGVuZHMgb24g
YWZ0ZXJfc3RhcnRACmlkZW50aWZpZXIgaTsKaWRlbnRpZmllciBtIDogc2NyaXB0Om9jYW1sKGkp
IHsgb2sgaSBtIH07CkBACgpzdHJ1Y3QgaSB7CsKgIC4uLgotIHN0cnVjdCByd2xvY2sgbTsKKyBz
dHJ1Y3QgbXR4IG07CsKgIC4uLgp9CgpAZGVwZW5kcyBvbiBhZnRlcl9zdGFydCBkaXNhYmxlIGZs
ZF90b19wdHJACmlkZW50aWZpZXIgbTsKaWRlbnRpZmllciBpIDogc2NyaXB0Om9jYW1sKG0pIHsg
b2sgaSBtIH07CnN0cnVjdCBpIHg7CkBACgotIHJ3X3dsb2NrCisgbXR4X2xvY2sKwqAgwqAoJngu
bSkKCkBkZXBlbmRzIG9uIGFmdGVyX3N0YXJ0IGRpc2FibGUgZmxkX3RvX3B0ckAKaWRlbnRpZmll
ciBtOwppZGVudGlmaWVyIGkgOiBzY3JpcHQ6b2NhbWwobSkgeyBvayBpIG0gfTsKc3RydWN0IGkg
eDsKQEAKCi0gcndfd3VubG9jaworIG10eF91bmxvY2sKwqAgwqAoJngubSkKCkBkZXBlbmRzIG9u
IGFmdGVyX3N0YXJ0IGRpc2FibGUgZmxkX3RvX3B0ckAKaWRlbnRpZmllciBtOwpleHByZXNzaW9u
IGU7CmlkZW50aWZpZXIgaSA6IHNjcmlwdDpvY2FtbChtKSB7IG9rIGkgbSB9OwpzdHJ1Y3QgaSB4
OwpAQAoKLSByd19pbml0KCZ4Lm0sIGUpOworIG10eF9pbml0KCZ4Lm0sIGUsIE5VTEwsIE1UWF9E
RUYpOwoKQGRlcGVuZHMgb24gYWZ0ZXJfc3RhcnQgZGlzYWJsZSBmbGRfdG9fcHRyQAppZGVudGlm
aWVyIG07CmlkZW50aWZpZXIgaSA6IHNjcmlwdDpvY2FtbChtKSB7IG9rIGkgbSB9OwpzdHJ1Y3Qg
aSB4OwpAQAoKLSByd19kZXN0cm95CisgbXR4X2Rlc3Ryb3kKwqAgwqAoJngubSkKCkBkZXBlbmRz
IG9uIGFmdGVyX3N0YXJ0IGRpc2FibGUgZmxkX3RvX3B0ciwgcHRyX3RvX2FycmF5QAppZGVudGlm
aWVyIG07CmlkZW50aWZpZXIgaSA6IHNjcmlwdDpvY2FtbChtKSB7IG9rIGkgbSB9OwpzdHJ1Y3Qg
aSAqeDsKQEAKCi0gcndfd2xvY2sKKyBtdHhfbG9jawrCoCDCoCgmeC0+bSkKCkBkZXBlbmRzIG9u
IGFmdGVyX3N0YXJ0IGRpc2FibGUgZmxkX3RvX3B0ciwgcHRyX3RvX2FycmF5QAppZGVudGlmaWVy
IG07CmlkZW50aWZpZXIgaSA6IHNjcmlwdDpvY2FtbChtKSB7IG9rIGkgbSB9OwpzdHJ1Y3QgaSAq
eDsKQEAKCi0gcndfd3VubG9jaworIG10eF91bmxvY2sKwqAgwqAoJngtPm0pCgpAZGVwZW5kcyBv
biBhZnRlcl9zdGFydCBkaXNhYmxlIGZsZF90b19wdHIsIHB0cl90b19hcnJheUAKaWRlbnRpZmll
ciBtOwpleHByZXNzaW9uIGU7CmlkZW50aWZpZXIgaSA6IHNjcmlwdDpvY2FtbChtKSB7IG9rIGkg
bSB9OwpzdHJ1Y3QgaSAqeDsKQEAKCi0gcndfaW5pdCgmeC0+bSwgZSk7CisgbXR4X2luaXQoJngt
Pm0sIGUsIE5VTEwsIE1UWF9ERUYpOwoKQGRlcGVuZHMgb24gYWZ0ZXJfc3RhcnQgZGlzYWJsZSBm
bGRfdG9fcHRyLCBwdHJfdG9fYXJyYXlACmlkZW50aWZpZXIgbTsKaWRlbnRpZmllciBpIDogc2Ny
aXB0Om9jYW1sKG0pIHsgb2sgaSBtIH07CnN0cnVjdCBpICp4OwpAQAoKLSByd19kZXN0cm95Cisg
bXR4X2Rlc3Ryb3kKwqAgwqAoJngtPm0pCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIK
aHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
