Return-Path: <SRS0=bkjO=YR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53334CA9EAF
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2019 08:05:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78CA20684
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2019 08:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78CA20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9O85S3m003539;
	Thu, 24 Oct 2019 10:05:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1917E77BB;
	Thu, 24 Oct 2019 10:05:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3901277B9
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 10:05:26 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9O85NJb012958
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 10:05:24 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 03538499BFE324A61475;
 Thu, 24 Oct 2019 16:05:22 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
 by mse-fl1.zte.com.cn with SMTP id x9O83L0s046147;
 Thu, 24 Oct 2019 16:03:21 +0800 (GMT-8)
 (envelope-from zhong.shiqi@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid32;
 Thu, 24 Oct 2019 16:03:21 +0800 (CST)
Date: Thu, 24 Oct 2019 16:03:21 +0800 (CST)
X-Zmail-TransId: 2af95db15ac9967ce2bd
X-Mailer: Zmail v1.0
Message-ID: <201910241603217396927@zte.com.cn>
In-Reply-To: <5762844f-2c39-2106-21fa-65e8297d4235@web.de>
References: 1571897060-32374-1-git-send-email-zhong.shiqi@zte.com.cn,
 5762844f-2c39-2106-21fa-65e8297d4235@web.de
Mime-Version: 1.0
From: <zhong.shiqi@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn x9O83L0s046147
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Oct 2019 10:05:28 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 24 Oct 2019 10:05:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, cheng.shengyu@zte.com.cn,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?=5BPATCH_v2=5D_coccicheck=3A_support_=24COCCI_b?=
	=?utf-8?q?eing_defined_as_adirectory?=
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

PiBJIGZpbmQgdGhhdCB0aGUgY29tbWl0IG1lc3NhZ2Ugc2hvdWxkIHN0aWxsIGJlIGNvbnNpZGVy
YWJseSBpbXByb3ZlZC4KPiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIHVzZSB0aGUgc3ViamVj
dCDigJxbUEFUQ0hdIGNvY2NpY2hlY2s6Cj4gU3VwcG9ydCBzZWFyY2ggZm9yIFNtUEwgc2NyaXB0
cyB3aXRoaW4gc2VsZWN0ZWQgZGlyZWN0b3J5IGhpZXJhcmNoeeKAnT8KCkkgd291bGQgbGlrZSB0
byB1c2Ugc3ViamVjdCBhcyB5b3Ugc2FpZC4KQnV0IGl0IHNlZW1zIGEgbGl0dGxlIGJpdCBsb25n
LCBkb2VzIGl0IG1hdHRlcj8KCj4gPiBQdXQgYSBtb2RpZmljYXRpb24gaW4gc2NyaXB0cy9jb2Nj
aWNoZWNrIHdoaWNoIHN1cHBvcnRzIHVzZXJzIGluCj4gPiBjb25maWd1cmluZyBDT0NDSSBwYXJh
bWV0ZXIgYXMgYSBkaXJlY3RvcnkgdG8gdHJhdmVyc2UgZmlsZXMgaW4KPiA+IGRpcmVjdG9yeSB3
aG9zZSBuZXh0IGxldmVsIGRpcmVjdG9yeSBjb250YWlucyBydWxlIGZpbGVzIHdpdGggU3VmZml4
IG9mIGNvY2NpLgoKPiAqIFBsZWFzZSBhdm9pZCBhIHR5cG8gaW4gdGhpcyBjaGFuZ2UgZGVzY3Jp
cHRpb24uCgpJIGFtIHBsZWFzdXJlIHRvIHJld3JpdGUgdGhpcyBjaGFuZ2UgZGVzY3JpcHRpb24u
Cgo+ICogV291bGQgeW91IGxpa2UgdG8gaW50ZWdyYXRlIGEgd29yZGluZyBhcHByb2FjaCBsaWtl
IHRoZSBmb2xsb3dpbmc/CgpJJ2QgbGlrZSB0by4gVGhhbmtzLgoKPiBBIHNlYXJjaCBjYW4gYmUg
cGVyZm9ybWVkIGZvciBTbVBMIHNjcmlwdHMgd2l0aGluIGEgZGlyZWN0b3J5IGhpZXJhcmNoeS4K
PiBTdGFydCBhIGNvcnJlc3BvbmRpbmcgZmlsZSBkZXRlcm1pbmF0aW9uIGlmIHRoZSBlbnZpcm9u
bWVudCB2YXJpYWJsZSDigJxDT0NDSeKAnQo+IGNvbnRhaW5zIGFuIGFjY2VwdGFibGUgcGF0aC4K
CkJlc3QgUmVnYXJkcywKemhvbmcuc2hpcWk=


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

