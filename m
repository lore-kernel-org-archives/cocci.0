Return-Path: <SRS0=bhL7=YX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBB6CA9EAE
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 02:45:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2D12086D
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 02:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2D12086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9U2jFbl022498;
	Wed, 30 Oct 2019 03:45:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BF77077BA;
	Wed, 30 Oct 2019 03:45:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A18C0454C
 for <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 03:45:13 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9U2jBaL019051
 for <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 03:45:12 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id A03F9129C41C58672E10;
 Wed, 30 Oct 2019 10:45:08 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
 by mse-fl1.zte.com.cn with SMTP id x9U2hTDs051758;
 Wed, 30 Oct 2019 10:43:29 +0800 (GMT-8)
 (envelope-from zhong.shiqi@zte.com.cn)
Received: from mapi (xaxapp02[null]) by mapi (Zmail) with MAPI id mid32;
 Wed, 30 Oct 2019 10:43:29 +0800 (CST)
Date: Wed, 30 Oct 2019 10:43:29 +0800 (CST)
X-Zmail-TransId: 2afa5db8f8d19cb7065e
X-Mailer: Zmail v1.0
Message-ID: <201910301043292761157@zte.com.cn>
In-Reply-To: <4905e8f0-6266-99b4-c3c4-9a9d29170bfc@web.de>
References: 1572076248-43770-1-git-send-email-zhong.shiqi@zte.com.cn,
 4905e8f0-6266-99b4-c3c4-9a9d29170bfc@web.de
Mime-Version: 1.0
From: <zhong.shiqi@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn x9U2hTDs051758
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 03:45:16 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 03:45:12 +0100 (CET)
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

PiA+IEFsbG93IGRlZmluaW5nIHRoZSBlbnZpcm9ubWVudCB2YXJpYWJsZSDigJxDT0NDSeKAnSBh
cyBhIGRpcmVjdG9yeQo+ID4gdG8gc2VhcmNoIFNtUEwgc2NyaXB0cy4gU3RhcnQgYSBjb3JyZXNw
b25kaW5nIGZpbGUgZGV0ZXJtaW5hdGlvbgo+ID4gaWYgaXQgY29udGFpbnMgYW4gYWNjZXB0YWJs
ZSBwYXRoLgo+IAo+IFdvdWxkIHRoZSBwYXJhZ3JhcGggZm9ybWF0dGluZyBiZSBuaWNlciBhcyBh
biBlbnVtZXJhdGlvbgo+IGFzIEkgc3VnZ2VzdGVkIGl0IHByZXZpb3VzbHk/CiAgClNvcnJ5IGZv
ciB0aGUgbGF0ZSByZXBseSEgCkkgd291bGQgc2F5IHllcy4KCgo+IFdvdWxkIHlvdSBsaWtlIHRv
IHVwZGF0ZSB0aGUgcHJvdmlkZWQgc29mdHdhcmUgZG9jdW1lbnRhdGlvbiB0b2dldGhlciB3aXRo
Cj4gdGhlIHNtYWxsIGV4dGVuc2lvbiBvZiB0aGlzIGJhc2ggc2NyaXB0PwoKSSdkIGxpa2UgdG8g
YnV0IGkgZG9uJ3QgaGF2ZSByaWdodHMgdG8gdXBkYXRlLgoKVGhhbnNrLAp6aG9uZy5zaGlxaQoK
PiBVcGRhdGUgY2FuZGlkYXRlczoKPiAqCj4gCj4gKiBodHRwczovL2JvdHRlc3Qud2lraS5rZXJu
ZWwub3JnL2NvY2NpY2hlY2sjY29udHJvbGxpbmdfd2hpY2hfZmlsZXNfYXJlX3Byb2Nlc3NlZF9i
eV9jb2NjaW5lbGxlCj4gCj4gUmVnYXJkcywKPiBNYXJrdXM=


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

