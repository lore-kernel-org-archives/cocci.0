Return-Path: <SRS0=dn/h=ZE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C0EC43331
	for <cocci@archiver.kernel.org>; Tue, 12 Nov 2019 01:07:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B252206C3
	for <cocci@archiver.kernel.org>; Tue, 12 Nov 2019 01:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B252206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAC16kQ9021740;
	Tue, 12 Nov 2019 02:06:47 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CF02777C2;
	Tue, 12 Nov 2019 02:06:46 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A79B87700
 for <cocci@systeme.lip6.fr>; Tue, 12 Nov 2019 02:06:45 +0100 (CET)
Received: from mxct.zte.com.cn (mx7.zte.com.cn [202.103.147.169])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAC16flM004714
 for <cocci@systeme.lip6.fr>; Tue, 12 Nov 2019 02:06:43 +0100 (CET)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id A14BEA08DC373F15F227;
 Tue, 12 Nov 2019 09:06:39 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
 by mse-fl2.zte.com.cn with SMTP id xAC16NkA004856;
 Tue, 12 Nov 2019 09:06:24 +0800 (GMT-8)
 (envelope-from zhong.shiqi@zte.com.cn)
Received: from mapi (xaxapp02[null]) by mapi (Zmail) with MAPI id mid32;
 Tue, 12 Nov 2019 09:06:23 +0800 (CST)
Date: Tue, 12 Nov 2019 09:06:23 +0800 (CST)
X-Zmail-TransId: 2afa5dca058f94e959d6
X-Mailer: Zmail v1.0
Message-ID: <201911120906235569181@zte.com.cn>
In-Reply-To: <af9cad95-56d8-943d-6f99-8ec896861694@web.de>
References: 1573458124-14528-1-git-send-email-zhong.shiqi@zte.com.cn,
 af9cad95-56d8-943d-6f99-8ec896861694@web.de
Mime-Version: 1.0
From: <zhong.shiqi@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn xAC16NkA004856
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 Nov 2019 02:06:47 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 12 Nov 2019 02:06:43 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, corbet@lwn.net, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, cheng.shengyu@zte.com.cn,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?=5Bv7=5D_coccicheck=3A_Support_search_for_SmPL_?=
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

PiA+IENoYW5nZXMgaW4gdjc6Cj4gPiAgICAgICAgIDE6YWRqdXN0IGNvY2NpbmVsbGUucnN0IGRv
Y3VtZW50YXRpb24KPiAKPiBUaGFua3MgZm9yIHlvdXIgY29udHJpYnV0aW9uLgo+IAo+IE5vdyBJ
IGFtIGN1cmlvdXMgaWYgb3RoZXIgY29udHJpYnV0b3JzIHdpbGwgYWRkIGNvcnJlc3BvbmRpbmcg
cmV2aWV3IGNvbW1lbnRzLgo+IAo+IAo+ID4gICAgICAgICAyOmZpeCBhIHJlcG8gb2YgImRlZmF1
bHQiIAoKICAgIFNvcnJ5Li4uaXQgc2hvdWxkIGJlICJ0eXBvIi4KClRoYW5rcwpaaG9uZy5zaGlx
aQoKPiBJIGZpbmQgdGhlIHdvcmQg4oCccmVwb+KAnSBwYXJ0bHkgdW5jbGVhciBhdCB0aGUgbW9t
ZW50Lgo+IAo+IFJlZ2FyZHMsCj4gTWFya3Vz


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

