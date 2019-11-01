Return-Path: <SRS0=b124=YZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA50CCA9ECB
	for <cocci@archiver.kernel.org>; Fri,  1 Nov 2019 02:51:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584FA2086D
	for <cocci@archiver.kernel.org>; Fri,  1 Nov 2019 02:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584FA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA12pNkn002052;
	Fri, 1 Nov 2019 03:51:23 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3DC2C77CB;
	Fri,  1 Nov 2019 03:51:23 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 20E7577BA
 for <cocci@systeme.lip6.fr>; Fri,  1 Nov 2019 03:51:22 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA12oNlf026682
 for <cocci@systeme.lip6.fr>; Fri, 1 Nov 2019 03:50:24 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id A65E02BCBBD9DC1EAEEF;
 Fri,  1 Nov 2019 10:50:22 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
 by mse-fl1.zte.com.cn with SMTP id xA12nGCI049027;
 Fri, 1 Nov 2019 10:49:16 +0800 (GMT-8)
 (envelope-from zhong.shiqi@zte.com.cn)
Received: from mapi (xaxapp02[null]) by mapi (Zmail) with MAPI id mid32;
 Fri, 1 Nov 2019 10:49:16 +0800 (CST)
Date: Fri, 1 Nov 2019 10:49:16 +0800 (CST)
X-Zmail-TransId: 2afa5dbb9d2c681a25ee
X-Mailer: Zmail v1.0
Message-ID: <201911011049160582771@zte.com.cn>
In-Reply-To: <d457995b-fed3-d560-e6b3-b8fa4b0059a0@web.de>
References: 201910301059095572036@zte.com.cn,
 d457995b-fed3-d560-e6b3-b8fa4b0059a0@web.de
Mime-Version: 1.0
From: <zhong.shiqi@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn xA12nGCI049027
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 01 Nov 2019 03:51:23 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 01 Nov 2019 03:50:24 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, cheng.shengyu@zte.com.cn,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?=5Bv4=5D_coccicheck=3A_Support_search_for_SmPL_?=
	=?utf-8?q?scripts_within_selecteddirectory_hierarchy?=
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

PiBJIHN1Z2dlc3QgdG8gaW1wcm92ZSB0aGUgY2FzZSBkaXN0aW5jdGlvbiBmb3IgdGhlIG1ha2Ug
KGFuZCBlbnZpcm9ubWVudCkKPiB2YXJpYWJsZSDigJxDT0NDSeKAnSBhbHNvIGJ5IGFkanVzdGlu
ZyB0aGUgZG9jdW1lbnQgb3V0bGluZS4KPiAqIEVtcHR5IHN0cmluZwo+ICogRGlyZWN0b3J5IHNl
bGVjdGlvbgo+ICogRmlsZSBuYW1lIHNwZWNpZmljYXRpb24KPiAKPiBTZWUgYWxzbzoKPiBodHRw
czovL2RvY3V0aWxzLnJlYWR0aGVkb2NzLmlvL2VuL3NwaGlueC1kb2NzL3VzZXIvcnN0L3F1aWNr
c3RhcnQuaHRtbCNzZWN0aW9ucwoKKiBEZWZhbHV0IHZhbHVlCiogRGlyZWN0b3J5IHNlbGVjdGlv
bgoqIFNpbmdsZSBmaWxlIHNlbGVjdGlvbgoKV291bGQgaXQgYmUgYmV0dGVyPwoKdGhhbmtzLApa
aG9uZy5zaGlxaQ==


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

