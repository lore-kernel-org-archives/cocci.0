Return-Path: <SRS0=dehY=QZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8D0C43381
	for <cocci@archiver.kernel.org>; Mon, 18 Feb 2019 03:23:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1757B218DE
	for <cocci@archiver.kernel.org>; Mon, 18 Feb 2019 03:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1757B218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1I3N0SC008496
          ; Mon, 18 Feb 2019 04:23:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7BBE575FF;
	Mon, 18 Feb 2019 04:23:00 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7C77A39DA
 for <cocci@systeme.lip6.fr>; Mon, 18 Feb 2019 04:22:58 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1I3MtfK023991
 for <cocci@systeme.lip6.fr>; Mon, 18 Feb 2019 04:22:56 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mse02.zte.com.cn (unknown [10.30.3.21])
 by Forcepoint Email with ESMTPS id 80D41496EB895CBFB742;
 Mon, 18 Feb 2019 11:22:52 +0800 (CST)
Received: from kjyxapp03.zte.com.cn ([10.30.12.202])
 by mse02.zte.com.cn with SMTP id x1I3Mmj4071965;
 Mon, 18 Feb 2019 11:22:48 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp07[null]) by mapi (Zmail) with MAPI id mid14;
 Mon, 18 Feb 2019 11:22:50 +0800 (CST)
Date: Mon, 18 Feb 2019 11:22:50 +0800 (CST)
X-Zmail-TransId: 2b095c6a250a7160a928
X-Mailer: Zmail v1.0
Message-ID: <201902181122502228026@zte.com.cn>
In-Reply-To: <52c07e7c-eec7-792b-0b03-b5cb46ddeab3@web.de>
References: HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com,
 52c07e7c-eec7-792b-0b03-b5cb46ddeab3@web.de
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse02.zte.com.cn x1I3Mmj4071965
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 18 Feb 2019 04:23:01 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 18 Feb 2019 04:22:56 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, michal.lkml@markovi.net,
        yellowriver2010@hotmail.com, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cheng.shengyu@zte.com.cn,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?=5Bv6=5D_coccinelle=3A_semantic_code_search_for?=
	=?utf-8?q?_missing_put=5Fdevice=28=29?=
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

PiA+IHdoZW4gIT0gZSA9IGlkIGFjaGlldmVzIHRoaXMgYmVoYXZpb3IuCj4gCj4gSSBjYW4gbm90
IGFncmVlIHRvIHRoaXMgdmlldyBjb21wbGV0ZWx5IGJlY2F1c2Ugb2YgdGhlIG1lYW5pbmcgdGhh
dCBpcyBjb25uZWN0ZWQKPiB3aXRoIHRoZXNlIHZhcmlhYmxlIGlkZW50aWZpZXJzLgo+IAo+IEJv
dGggbWV0YXZhcmlhYmxlcyBzaGFyZSB0aGUga2luZCDigJxleHByZXNzaW9u4oCdLiBTbyBJIGNh
biBpbWFnaW5lCj4gdGhhdCB0aGVyZSBpcyBhbiBpbnRlcnNlY3Rpb24gZm9yIHRoZSBzb3VyY2Ug
Y29kZSBtYXRjaCBwb3NzaWJpbGl0eS4KPiBCdXQgb25lIHdhcyBpbnRlbnRpb25hbGx5IHJlc3Ry
aWN0ZWQgdG8gdGhlIGtpbmQg4oCcbG9jYWwgaWRleHByZXNzaW9u4oCdIHNvIGZhci4KPiAKPiBX
aGljaCBkYXRhIGVsZW1lbnQgc2hvdWxkIG5vdCBnZXQgcmVhc3NpZ25lZCBoZXJlIChiZWZvcmUg
YSBjb3JyZXNwb25kaW5nCj4gbnVsbCBwb2ludGVyIGNoZWNrKT8KPiAKClRoYW5rIHlvdSBmb3Ig
eW91ciBjb21tZW50cy4KV2UgZGlkIHNvbWUgZXhwZXJpbWVudHM6CitpZCA9IG9mX2ZpbmRfZGV2
aWNlX2J5X25vZGVAcDEoeCkKKy4uLiB3aGVuICE9IGUgPSBpZAouLi4KT3I6Ci4uLgorIC4uLiB3
aGVuICE9IGlkID0gZQoKVGhlIG51bWJlciBvZiBpc3N1c2VzIGZvdW5kIGJ5IHRoZXNlIHR3byBt
ZXRob2RzIGlzIHRoZSBzYW1lLgpXaGVuICE9IGUgPSBpZCBhY2hpZXZlcyB0aGlzIGJlaGF2aW9y
LgoKSW4gYWRkaXRpb24sIHdlIGZlZWwgdGhhdCB3ZSBzaG91bGQgcHJvYmFibHkgYWNjZXB0IHRo
aXMgcGF0Y2ggZmlyc3QsIHVzZSBpdCB0byBmaW5kIG1vcmUgbWVtb3J5IGxlYWtzLCBhbmQgc29s
dmUgdGhlIGFjdHVhbCBwcm9ibGVtcyBpbiB0aGUga2VybmVsIGNvZGUuCkFzIGZvciB0aGUgcGF0
Y2ggaXRzZWxmLCB3ZSBjYW4gY29udGludWUgdG8gcHVyc3VlIHBlcmZlY3QgaW4gdGhlIHByb2Nl
c3Mgb2YgdXNpbmcgaXQgdG8gc29sdmUgcHJhY3RpY2FsIHByb2JsZW1zLgoKUmVnYXJkcywKV2Vu

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

