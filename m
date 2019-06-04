Return-Path: <SRS0=Tsgg=UD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1FEC28CC6
	for <cocci@archiver.kernel.org>; Tue,  4 Jun 2019 08:55:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB4D24C49
	for <cocci@archiver.kernel.org>; Tue,  4 Jun 2019 08:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB4D24C49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x548tXvE003306;
	Tue, 4 Jun 2019 10:55:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 196257760;
	Tue,  4 Jun 2019 10:55:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1C6DE7759
 for <cocci@systeme.lip6.fr>; Tue,  4 Jun 2019 10:55:30 +0200 (CEST)
Received: from mxct.zte.com.cn (mx7.zte.com.cn [202.103.147.169])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x548tHF5017584
 for <cocci@systeme.lip6.fr>; Tue, 4 Jun 2019 10:55:18 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id C703856D9FFEEB954F33;
 Tue,  4 Jun 2019 16:55:14 +0800 (CST)
Received: from kjyxapp04.zte.com.cn ([10.30.12.203])
 by mse-fl1.zte.com.cn with SMTP id x548t4kM041434;
 Tue, 4 Jun 2019 16:55:04 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp02[null]) by mapi (Zmail) with MAPI id mid14;
 Tue, 4 Jun 2019 16:55:04 +0800 (CST)
Date: Tue, 4 Jun 2019 16:55:04 +0800 (CST)
X-Zmail-TransId: 2b045cf631e8804fb11e
X-Mailer: Zmail v1.0
Message-ID: <201906041655048641633@zte.com.cn>
In-Reply-To: <1bc40e20-d4d0-77e6-67d6-2230e8026ef0@web.de>
References: 201906041350002807147@zte.com.cn,
 1bc40e20-d4d0-77e6-67d6-2230e8026ef0@web.de
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn x548t4kM041434
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Jun 2019 10:55:33 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Jun 2019 10:55:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: michal.lkml@markovi.net, nicolas.palix@imag.fr, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?Coccinelle=3A_semantic_patch_for_missing_of=5Fn?=
	=?utf-8?q?ode=5Fput?=
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



--=====_001_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PiA+IFdlIGN1cnJlbnRseSB1c2UgdGhlIGZvbGxvd2luZyBPY2FtbCBzY3JpcHQgdG8gYXV0b21h
dGljYWxseQo+ID4gY29sbGVjdCBmdW5jdGlvbnMgdGhhdCBuZWVkIHRvIGJlIGNvbnNpZGVyZWQu
Cj4gPgo+ID4gQGluaXRpYWxpemU6b2NhbWxACj4gPiBAQAo+ID4KPiA+IGxldCByZWxldmFudF9z
dHIgPSAidXNlIG9mX25vZGVfcHV0KCkgb24gaXQgd2hlbiBkb25lIgo+IAo+IEkgc3VnZ2VzdCB0
byByZWNvbnNpZGVyIHRoaXMgc2VhcmNoIHBhdHRlcm4uCj4gCj4gVGhlIG1lbnRpb25lZCB3b3Jk
cyBhcmUgZGlzdHJpYnV0ZWQgb3ZlciB0ZXh0IGxpbmVzIGluIHRoZSBkaXNjdXNzZWQKPiBzb2Z0
d2FyZSBkb2N1bWVudGF0aW9uLgo+IFRodXMgSSBpbWFnaW5lIHRoYXQgYW4gb3RoZXIgZG9jdW1l
bnRhdGlvbiBmb3JtYXQgd291bGQgYmUgc2FmZXIKPiBhbmQgbW9yZSBoZWxwZnVsIGZvciB0aGUg
ZGV0ZXJtaW5hdGlvbiBvZiBhIGNvcnJlc3BvbmRpbmcgQVBJCj4gc3lzdGVtIHByb3BlcnR5LgoK
T3VyIHNjcmlwdCB3aWxsIHJlbW92ZSAnKiAnLCdcIG4nLCdcdCcgYW5kIHNvIG9uIGZyb20gdGhl
IGNvbW1lbnRzIGluIHRoZSBmdW5jdGlvbiBoZWFkZXIKYW5kIHRoZW4gbWVyZ2UgdGhlbSBpbnRv
IG9uZSBsaW5lLCBzbyB3ZSBjYW4gZXhhY3RseSBtYXRjaCB0aGUgdGFyZ2V0IHN0cmluZwondXNl
IG9mX25vZGVfcHV0KCkgb24gaXQgd2hlbiBkb25lICcKCi0tClJlZ2FyZHMsCldlbg==


--=====_003_next=====--

--=====_001_next=====
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--=====_001_next=====--

