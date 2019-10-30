Return-Path: <SRS0=bhL7=YX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB7ECA9EAE
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 03:01:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30FB20856
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 03:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30FB20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9U30skj003756;
	Wed, 30 Oct 2019 04:00:54 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B8DD277BA;
	Wed, 30 Oct 2019 04:00:54 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 736B3454C
 for <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 04:00:52 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9U30pkb009093
 for <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 04:00:51 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 71745825542A7613829D;
 Wed, 30 Oct 2019 11:00:50 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
 by mse-fl1.zte.com.cn with SMTP id x9U2x9uL069209;
 Wed, 30 Oct 2019 10:59:09 +0800 (GMT-8)
 (envelope-from zhong.shiqi@zte.com.cn)
Received: from mapi (xaxapp02[null]) by mapi (Zmail) with MAPI id mid32;
 Wed, 30 Oct 2019 10:59:09 +0800 (CST)
Date: Wed, 30 Oct 2019 10:59:09 +0800 (CST)
X-Zmail-TransId: 2afa5db8fc7d05c93ccb
X-Mailer: Zmail v1.0
Message-ID: <201910301059095572036@zte.com.cn>
In-Reply-To: <781f1507-9002-3168-9efd-ef15f0966dc8@web.de>
References: 1572076248-43770-1-git-send-email-zhong.shiqi@zte.com.cn,
 781f1507-9002-3168-9efd-ef15f0966dc8@web.de
Mime-Version: 1.0
From: <zhong.shiqi@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn x9U2x9uL069209
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 04:00:55 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 04:00:52 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, cheng.shengyu@zte.com.cn,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?=5BPATCH_v4=5D_coccicheck=3A_Support_search_for?=
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

PiA+IFdvdWxkIHlvdSBsaWtlIHRvIHVwZGF0ZSB0aGUgcHJvdmlkZWQgc29mdHdhcmUgZG9jdW1l
bnRhdGlvbiB0b2dldGhlciB3aXRoCj4gPiB0aGUgc21hbGwgZXh0ZW5zaW9uIG9mIHRoaXMgYmFz
aCBzY3JpcHQ/Cj4gPiAKPiA+IFVwZGF0ZSBjYW5kaWRhdGVzOgo+IAo+IFBsZWFzZSByZWNvbnNp
ZGVyIGFsc28gdGhlIHNlY3Rpb24g4oCcVXNpbmcgQ29jY2luZWxsZSB3aXRoIGEgc2luZ2xlIHNl
bWFudGljIHBhdGNo4oCdOgo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vZGV2LXRvb2xz
L2NvY2NpbmVsbGUucnN0P2lkPWY4NzdiZWU1ZWEwYjU2YzM5Y2QwYTI0M2UxMTNhNTc3YjVhNGVm
OTIjbjE1MQo+IAo+IFJlZ2FyZHMsCj4gTWFya3VzCgpDb3VsZCB3ZSBhZGQgbmV3IGxpbmVzPwpI
b3cgYWJvdXQgdGhlIGZvbGxvd2luZz8KClRoZSBvcHRpb25hbCBtYWtlIHZhcmlhYmxlIENPQ0NJ
IGNhbiBiZSB1c2VkIHRvIHNlYXJjaCBTbVBMIHNjcmlwdHMgaW4gYQpkaXJlY3RvcnkuIEluIHRo
YXQgY2FzZSwgdGhlIHZhcmlhYmxlIG11c3QgYmUgaW5pdGlhbGl6ZWQgd2l0aCB0aGUgbmFtZSBv
ZgpkaXJlY3RvcnkgY29udGFpbnMgU21QTCBzY3JpcHRzLgpGb3IgaW5zdGFuY2U6OgoJbWFrZSBj
b2NjaWNoZWNrIENPQ0NJPTxteV9TUERJUj4gTU9ERT1wYXRjaApvcjo6CgltYWtlIGNvY2NpY2hl
Y2sgQ09DQ0k9PG15X1NQRElSPiBNT0RFPXJlcG9ydAoKVGhhbmtzLApaaG9uZy5zaGlxaQ==


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

