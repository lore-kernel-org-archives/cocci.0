Return-Path: <SRS0=aura=Q2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47959C43381
	for <cocci@archiver.kernel.org>; Tue, 19 Feb 2019 02:14:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEE82173C
	for <cocci@archiver.kernel.org>; Tue, 19 Feb 2019 02:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEE82173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1J2EZhX009089
          ; Tue, 19 Feb 2019 03:14:35 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1D66876F9;
	Tue, 19 Feb 2019 03:14:35 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9245B764A
 for <cocci@systeme.lip6.fr>; Tue, 19 Feb 2019 03:14:32 +0100 (CET)
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1J2ETFV023275
 for <cocci@systeme.lip6.fr>; Tue, 19 Feb 2019 03:14:31 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id C47178EDB6371B0FC284;
 Tue, 19 Feb 2019 10:14:27 +0800 (CST)
Received: from kjyxapp05.zte.com.cn ([10.30.12.204])
 by mse01.zte.com.cn with SMTP id x1J2EFeE002799;
 Tue, 19 Feb 2019 10:14:15 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp07[null]) by mapi (Zmail) with MAPI id mid14;
 Tue, 19 Feb 2019 10:14:15 +0800 (CST)
Date: Tue, 19 Feb 2019 10:14:15 +0800 (CST)
X-Zmail-TransId: 2b095c6b6677f784bc4e
X-Mailer: Zmail v1.0
Message-ID: <201902191014156680299@zte.com.cn>
In-Reply-To: <ab463e94-287a-6188-6795-06eeb832e861@web.de>
References: 201902181122502228026@zte.com.cn,
 ab463e94-287a-6188-6795-06eeb832e861@web.de
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse01.zte.com.cn x1J2EFeE002799
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 19 Feb 2019 03:14:35 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 19 Feb 2019 03:14:31 +0100 (CET)
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

PiA+IEkgd291bGQgaGF2ZSBhIGhhcmQgdGltZSBzYXlpbmcgd2hpY2ggb25lIGlzIG1vcmUgcmVh
c29uYWJsZSB0byB0ZXN0LCAKPiBJIHN1Z2dlc3QgdG8gcmVjb25zaWRlciB0aGUgaW50ZXJwcmV0
YXRpb24gb2YgdGhpcyBzb2Z0d2FyZSBzaXR1YXRpb24gb25jZSBtb3JlLgo+ID4gc2luY2UgYm90
aCBhcmUgZXh0cmVtZWx5IHVubGlrZWx5Lgo+IEkgZGlzYWdyZWUgdG8gdGhpcyB2aWV3IGJlY2F1
c2UgdHdvIGVsbGlwc2VzIHdlcmUgaW50ZW50aW9uYWxseSBzcGVjaWZpZWQKPiBpbiBwdWJsaXNo
ZWQgU21QTCBzY3JpcHRzLgo+IFNvIHNvbWUgc29mdHdhcmUgZGV2ZWxvcGVycyBmb3VuZCB0aGVz
ZSDigJxzcGVjaWFsIHVzZSBjYXNlc+KAnSBpbXBvcnRhbnQgZW5vdWdoLgo+ID4+IEluIGFkZGl0
aW9uLCB3ZSBmZWVsIHRoYXQgd2Ugc2hvdWxkIHByb2JhYmx5IGFjY2VwdCB0aGlzIHBhdGNoIGZp
cnN0LAo+IEkgZGlzYWdyZWUgdG8gdGhpcyBpbWFnaW5hdGlvbiBiZWNhdXNlIEkgd291bGQgcHJl
ZmVyIHRvIGludGVncmF0ZSBhIHNvdXJjZSBjb2RlIHZhcmlhbnQKPiB3aXRob3V0IGEgYnVnICh3
aGljaCB3YXMgY29waWVkIGZyb20gYSB2ZXJzaW9uIG9uIDIwMTMtMDUtMDggYnkgUGV0ciBTdHJu
YWQpLgo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rv
cnZhbGRzL2xpbnV4LmdpdC90cmVlL3NjcmlwdHMvY29jY2luZWxsZS9mcmVlL3BjaV9mcmVlX2Nv
bnNpc3RlbnQuY29jY2k/aWQ9ZjdiMTY3MTEzNzUzZTk1YWU2MTM4M2UyMzRmOGQxMDE0Mjc4MmFj
ZSNuMTIKPiBJIGhvcGUgdGhhdCBuaWNlciBydW4gdGltZSBiZWhhdmlvdXIgY2FuIGJlY29tZSBh
bHNvIHJlbGV2YW50IGhlcmUuCgpCb3RoIGNhc2VzIGFyZSBleHRyZW1lbHkgdW5saWtlbHkuCkFs
dGhvdWdoIHdlIGhhdmUgdGVzdGVkIHRoZXNlIHR3byBtZXRob2RzIGluIHRoZSBleGlzdGluZyBr
ZXJuZWwgY29kZSwKY29uc2lkZXJpbmcgdGhlIGV2b2x1dGlvbiBvZiB0aGUga2VybmVsIGNvZGUs
IHRoZXNlIHNwZWNpYWwgY2FzZXMgbWF5IG9jY3VyLCBzbyB3ZSBhcmUgd2lsbGluZyB0byB0YWtl
IHRoZW0gaW50byBhY2NvdW50LgpXZSBwbGFuIHRvIG1vZGlmeSB0aGUgY29kZSBsaWtlIHRoaXM6
CgogaWQgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlQHAxKHgpCi0uLi4gd2hlbiAhPSBlID0gaWQK
Ky4uLiB3aGVuICE9IGUgPSAoVClpZAorICAgIHdoZW4gIT0gaWQgPSAoVCllCgpEbyB5b3UgaGF2
ZSBhbnkgb3RoZXIgcXVlc3Rpb25zPwpUaGFua3MuCgpSZWdhcmRzLApXZW4=


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

