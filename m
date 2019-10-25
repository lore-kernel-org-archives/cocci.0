Return-Path: <SRS0=FZn7=YS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91F6CA9EA0
	for <cocci@archiver.kernel.org>; Fri, 25 Oct 2019 09:39:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070E121D71
	for <cocci@archiver.kernel.org>; Fri, 25 Oct 2019 09:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070E121D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9P9dIY7021738;
	Fri, 25 Oct 2019 11:39:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 787E477BE;
	Fri, 25 Oct 2019 11:39:18 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 721DF7415
 for <cocci@systeme.lip6.fr>; Fri, 25 Oct 2019 11:39:16 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9P9dEqY025732
 for <cocci@systeme.lip6.fr>; Fri, 25 Oct 2019 11:39:15 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 30873D0DCC63326BB403;
 Fri, 25 Oct 2019 17:39:13 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
 by mse-fl1.zte.com.cn with SMTP id x9P9c0ck028162;
 Fri, 25 Oct 2019 17:38:00 +0800 (GMT-8)
 (envelope-from zhong.shiqi@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid32;
 Fri, 25 Oct 2019 17:38:00 +0800 (CST)
Date: Fri, 25 Oct 2019 17:38:00 +0800 (CST)
X-Zmail-TransId: 2af95db2c278d1aec157
X-Mailer: Zmail v1.0
Message-ID: <201910251738005781441@zte.com.cn>
In-Reply-To: <14f7a50d-63f5-343f-70e8-6b42ab5baa4c@web.de>
References: 1571966374-42566-1-git-send-email-zhong.shiqi@zte.com.cn,
 14f7a50d-63f5-343f-70e8-6b42ab5baa4c@web.de
Mime-Version: 1.0
From: <zhong.shiqi@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn x9P9c0ck028162
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 25 Oct 2019 11:39:18 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 25 Oct 2019 11:39:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, cheng.shengyu@zte.com.cn,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?=5BPATCH_v3=5D_coccicheck=3A_Support_search_for?=
	=?utf-8?q?_SmPL_scripts_withinselected_directory_hierarchy?=
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

PiA+IEFsbG93IGRlZmluaW5nIENPQ0NJIGFzIGEgZGlyZWN0b3J5IHRvIHNlYXJjaCBTbVBMIHNj
cmlwdHMuIFN0YXJ0IGEKPiA+IGNvcnJlc3BvbmRpbmcgZmlsZSBkZXRlcm1pbmF0aW9uIGlmIHRo
ZSBlbnZpcm9ubWVudCB2YXJpYWJsZSDigJxDT0NDSeKAnQo+ID4gY29udGFpbnMgYW4gYWNjZXB0
YWJsZSBwYXRoLgo+IAo+IENhbiBhbm90aGVyIHdvcmRpbmcgZmluZS10dW5pbmcgbWF0dGVyIGZv
ciBzdWNoIGEgY2hhbmdlIGRlc2NyaXB0aW9uPwo+IAo+ICAgKiBBbGxvdyBkZWZpbmluZyB0aGUg
ZW52aXJvbm1lbnQgdmFyaWFibGUg4oCcQ09DQ0nigJ0gYXMgYSBkaXJlY3RvcnkKPiAgICAgdG8g
c2VhcmNoIFNtUEwgc2NyaXB0cy4KPiAKPiAgICogU3RhcnQgYSBjb3JyZXNwb25kaW5nIGZpbGUg
ZGV0ZXJtaW5hdGlvbiBpZiBpdCBjb250YWlucyBhbiBhY2NlcHRhYmxlIHBhdGguCgoJVGhhbmtz
LGkgdGhpbmsgaXQgIHdvdWxkIGJlIGJldHRlciEKCkJlc3QgUmVnYXJkcywKemhvbmcuc2hpcWkK
Cj4gUmVnYXJkcywKPiBNYXJrdXM=


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

