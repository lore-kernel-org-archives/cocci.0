Return-Path: <SRS0=bkjO=YR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC95CA9EAF
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2019 10:00:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B25920856
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2019 10:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B25920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9O9xkVx002834;
	Thu, 24 Oct 2019 11:59:46 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C34BC77BB;
	Thu, 24 Oct 2019 11:59:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5B94077B9
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 11:59:45 +0200 (CEST)
Received: from mxct.zte.com.cn (mx7.zte.com.cn [202.103.147.169])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9O9xg8E025706
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 11:59:43 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 9815DA57EF0AA54F7D49;
 Thu, 24 Oct 2019 17:59:40 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
 by mse-fl1.zte.com.cn with SMTP id x9O9wJEL011355;
 Thu, 24 Oct 2019 17:58:20 +0800 (GMT-8)
 (envelope-from zhong.shiqi@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid32;
 Thu, 24 Oct 2019 17:58:19 +0800 (CST)
Date: Thu, 24 Oct 2019 17:58:19 +0800 (CST)
X-Zmail-TransId: 2af95db175bb42066cde
X-Mailer: Zmail v1.0
Message-ID: <201910241758198340332@zte.com.cn>
In-Reply-To: <9303864d-0feb-5be2-9639-bb4f6f574cb5@web.de>
References: 201910241603217396927@zte.com.cn,
 9303864d-0feb-5be2-9639-bb4f6f574cb5@web.de
Mime-Version: 1.0
From: <zhong.shiqi@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn x9O9wJEL011355
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Oct 2019 11:59:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 24 Oct 2019 11:59:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, cheng.shengyu@zte.com.cn,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?=5Bv2=5D_coccicheck=3A_support_=24COCCI_being_d?=
	=?utf-8?q?efined_as_adirectory?=
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

PiA+PiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIHVzZSB0aGUgc3ViamVjdCDigJxbUEFUQ0hd
IGNvY2NpY2hlY2s6Cj4gPj4gU3VwcG9ydCBzZWFyY2ggZm9yIFNtUEwgc2NyaXB0cyB3aXRoaW4g
c2VsZWN0ZWQgZGlyZWN0b3J5IGhpZXJhcmNoeeKAnT8KPiA+Cj4gPiBJIHdvdWxkIGxpa2UgdG8g
dXNlIHN1YmplY3QgYXMgeW91IHNhaWQuCj4KPiBUaGFua3MgZm9yIHlvdXIgcG9zaXRpdmUgZmVl
ZGJhY2suCj4KPgo+ID4gQnV0IGl0IHNlZW1zIGEgbGl0dGxlIGJpdCBsb25nLAo+Cj4gSSBob3Bl
IHRoYXQgdGhpcyBzdWdnZXN0aW9uIGlzIHN0aWxsIGFwcHJvcHJpYXRlLgo+Cj4KPiA+IGRvZXMg
aXQgbWF0dGVyPwo+Cj4gRG8geW91IGtub3cgYW4gYXBwcm9hY2ggd2hpY2ggY2FuIGV4cHJlc3Mg
YWxtb3N0IHRoZSBzYW1lIGluZm9ybWF0aW9uCj4gd2l0aCBhIHNob3J0ZXIgd29yZGluZyAoYmVz
aWRlcyB1c2luZyBhbiBvdGhlciBsYW5ndWFnZSkgYXQgdGhpcyBwbGFjZT8KCkhvdyBkbyB5b3Ug
dGhpbmsgYWJvdXQgdG8gdXNlIHRoZSBzdWJqZWN0ICJbUEFUQ0hdIGNvY2NpY2hlY2s6ClN1cHBv
cnQgc2VhcmNoIGluIGEgc2VsZWN0ZWQgZGlyZWN0b3J5Ij8KCj4gUmVnYXJkcywKPiBNYXJrdXM=

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

