Return-Path: <SRS0=aura=Q2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEA0C43381
	for <cocci@archiver.kernel.org>; Tue, 19 Feb 2019 09:10:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA4D2146F
	for <cocci@archiver.kernel.org>; Tue, 19 Feb 2019 09:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA4D2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1J99l7a007765
          ; Tue, 19 Feb 2019 10:09:47 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7ABF3770E;
	Tue, 19 Feb 2019 10:09:47 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C53C976FB
 for <cocci@systeme.lip6.fr>; Tue, 19 Feb 2019 10:09:45 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1J99fbU010221
 for <cocci@systeme.lip6.fr>; Tue, 19 Feb 2019 10:09:43 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 4A491DFC79179CBB49B1;
 Tue, 19 Feb 2019 17:09:39 +0800 (CST)
Received: from kjyxapp04.zte.com.cn ([10.30.12.203])
 by mse01.zte.com.cn with SMTP id x1J99WFk079033;
 Tue, 19 Feb 2019 17:09:32 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp07[null]) by mapi (Zmail) with MAPI id mid14;
 Tue, 19 Feb 2019 17:09:34 +0800 (CST)
Date: Tue, 19 Feb 2019 17:09:34 +0800 (CST)
X-Zmail-TransId: 2b095c6bc7ce4c84bea0
X-Mailer: Zmail v1.0
Message-ID: <201902191709341581016@zte.com.cn>
In-Reply-To: <31a0ea02-4005-23a4-8030-47319504e84a@web.de>
References: 201902191014156680299@zte.com.cn,
 31a0ea02-4005-23a4-8030-47319504e84a@web.de
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse01.zte.com.cn x1J99WFk079033
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 19 Feb 2019 10:09:48 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 19 Feb 2019 10:09:43 +0100 (CET)
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

PiA+IERvIHlvdSBoYXZlIGFueSBvdGhlciBxdWVzdGlvbnM/Cj4gCj4gT2J2aW91c2x5LCB5ZXMu
Cj4gSSBhbSBjdXJpb3VzIGlmIHRoaXMgZGV2ZWxvcG1lbnQgZGlzY3Vzc2lvbiBhbmQgY29kZSBy
ZXZpZXcgd2lsbCB0cmlnZ2VyCj4gZnVydGhlciBzb2Z0d2FyZSBhZGp1c3RtZW50cy4KPiBJIGd1
ZXNzIHRoYXQgeW91IHdpbGwgbmVlZCBhZGRpdGlvbmFsIHRpbWUgdG8gcmVjb25zaWRlciBzcGVj
aWZpYyBpdGVtcwo+IGZyb20gcmVjZW50IGZlZWRiYWNrLgo+IAo+IFdpbGwgY29ycmVjdGlvbnMg
YmVjb21lIHJlbGV2YW50IGZvciBzcGVjaWZpY2F0aW9ucyBpbiAoYXNzaWdubWVudCkgZXhjbHVz
aW9ucwo+IG9mIHRoZSBzZWNvbmQgU21QTCBlbGxpcHNpcyBpbiB0aGUgZGlzY3Vzc2VkIHNjcmlw
dD8KCkxldCdzIGRvIHNvbWUgZXhwZXJpbWVudHMgd2l0aCB0aGUgY29kZSBpbiB0aGUgY3VycmVu
dCBrZXJuZWwuCkxldCB1cyB0YWtlIHRoaXMgY29kZSBhcyBhbiBleGFtcGxlOgpIdHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0
L3RyZWUvc291bmQvc29jL2ZzbC9pbXgtc2d0bDUwMDAuYwoKMSwgT3JpZ2luYWwgY29kZQpzdGF0
aWMgaW50IGlteF9zZ3RsNTAwMF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQp7
CiAgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOwogICAg
ICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqc3NpX25wLCAqY29kZWNfbnA7CiAgICAgICAgc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqc3NpX3BkZXY7Ci4uLgogICAgICAgIHNzaV9wZGV2ID0gb2ZfZmlu
ZF9kZXZpY2VfYnlfbm9kZShzc2lfbnApOwouLi4KfQoKT3VyIGN1cnJlbnQgcGF0Y2ggd2lsbCBm
aW5kIHRoZSBwcm9ibGVtOgouL3NvdW5kL3NvYy9mc2wvaW14LXNndGw1MDAwLmM6MTY5OjEtNzog
RVJST1I6IG1pc3NpbmcgcHV0X2RldmljZTsgY2FsbCBvZl9maW5kX2RldmljZV9ieV9ub2RlIG9u
IGxpbmUgMTA1LCBidXQgd2l0aG91dCBhIGNvcnJlc3BvbmRpbmcgb2JqZWN0IHJlbGVhc2Ugd2l0
aGluIHRoaXMgZnVuY3Rpb24uCi4vc291bmQvc29jL2ZzbC9pbXgtc2d0bDUwMDAuYzoxNzc6MS03
OiBFUlJPUjogbWlzc2luZyBwdXRfZGV2aWNlOyBjYWxsIG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUg
b24gbGluZSAxMDUsIGJ1dCB3aXRob3V0IGEgY29ycmVzcG9uZGluZyBvYmplY3QgcmVsZWFzZSB3
aXRoaW4gdGhpcyBmdW5jdGlvbi4KClRoZSBwcm9ibGVtIGNhbiBiZSBkZXRlY3RlZCBieSBib3Ro
IG9mIHRoZSBmb2xsb3dpbmcgbWV0aG9kczoKK2lkID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZUBw
MSh4KQorLi4uIHdoZW4gIT0gZSA9IGlkCi4uLgpPcjoKLi4uCisgLi4uIHdoZW4gIT0gaWQgPSBl
CgoyLCAgU3VwcG9zZSB3ZSBjaGFuZ2UgaXQgdG86CnN0YXRpYyBpbnQgaW14X3NndGw1MDAwX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCnsKICAgICAgICBzdHJ1Y3QgZGV2aWNl
X25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7CiAgICAgICAgc3RydWN0IGRldmljZV9ub2Rl
ICpzc2lfbnAsICpjb2RlY19ucDsKICAgICAgICBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpzc2lf
cGRldjsKLi4uCiAgICAgICAgc3NpX3BkZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlKHNzaV9u
cCk7Ci4uLgogICAgICAgIHNzaV9wZGV2ID0gdG9fcGxhdGZvcm1fZGV2aWNlKFhZWik7Cn0KCkJ1
dCB0aGlzIHRpbWUsIG9ubHkgdGhlIGZpcnN0IG1ldGhvZCBjYW4gZGV0ZWN0IHRoZSBwcm9ibGVt
LgoKVGhlIHNlY29uZCBtZXRob2QsIGFsdGhvdWdoIHRoZSBmYWxzZSBwb3NpdGl2ZSByYXRlIGlz
IGxvd2VyLCAKYnV0IHRoZSByZWNhbGwgcmF0ZSBpcyByZWR1Y2VkLCB3ZSBtYXkgbWlzcyBzb21l
IHJlYWwgaXNzdWVzLgpUaGFua3MsCgpSZWdhcmRzLApXZW4=


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

