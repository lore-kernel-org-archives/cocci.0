Return-Path: <SRS0=bkjO=YR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D6ACA9EAF
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2019 06:20:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43F821655
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2019 06:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43F821655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9O6KZtW007117;
	Thu, 24 Oct 2019 08:20:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AD3ED77BB;
	Thu, 24 Oct 2019 08:20:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CA02177B9
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 08:02:25 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9O62MXk029804
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 08:02:23 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id 5D6A011FAB000689523C;
 Thu, 24 Oct 2019 14:02:20 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
 by mse-fl2.zte.com.cn with ESMTP id x9O627fR064659;
 Thu, 24 Oct 2019 14:02:07 +0800 (GMT-8)
 (envelope-from zhong.shiqi@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019102414023406-106879 ;
 Thu, 24 Oct 2019 14:02:34 +0800 
From: zhongshiqi <zhong.shiqi@zte.com.cn>
To: Julia.Lawall@lip6.fr
Date: Thu, 24 Oct 2019 14:04:20 +0800
Message-Id: <1571897060-32374-1-git-send-email-zhong.shiqi@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-10-24 14:02:34,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-10-24 14:02:11
X-MAIL: mse-fl2.zte.com.cn x9O627fR064659
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Oct 2019 08:20:35 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 24 Oct 2019 08:02:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 24 Oct 2019 08:20:34 +0200
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        cheng.shengyu@zte.com.cn, zhongshiqi <zhong.shiqi@zte.com.cn>,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v2] coccicheck:support $COCCI being defined as a
	directory
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

UHV0IGEgbW9kaWZpY2F0aW9uIGluIHNjcmlwdHMvY29jY2ljaGVjayB3aGljaCBzdXBwb3J0cyB1
c2VycyBpbgpjb25maWd1cmluZyBDT0NDSSBwYXJhbWV0ZXIgYXMgYSBkaXJlY3RvcnkgdG8gdHJh
dmVyc2UgZmlsZXMgaW4KZGlyZWN0b3J5IHdob3NlIG5leHQgbGV2ZWwgZGlyZWN0b3J5IGNvbnRh
aW5zIHJ1bGUgZmlsZXMgd2l0aCBTdWZmaXggb2YKY29jY2kuCgpTaWduZWQtb2ZmLWJ5OiB6aG9u
Z3NoaXFpIDx6aG9uZy5zaGlxaUB6dGUuY29tLmNuPgotLS0KQ2hhbmdlcyBpbiB2MjoKICAgICAg
ICAxLmZpeCBwYXRjaCBzdWJqZWN0IGFjY29yZGluZyB0byB0aGUgcmVwbHkgYnkgTWFya3VzCiAg
ICAgICAgPE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4KICAgICAgICAyLmNoYW5nZSBkZXNjcmlwdGlv
biBpbiDigJxpbXBlcmF0aXZlIG1vb2TigJ0KCiBzY3JpcHRzL2NvY2NpY2hlY2sgfCA0ICsrKysK
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zY3JpcHRzL2Nv
Y2NpY2hlY2sgYi9zY3JpcHRzL2NvY2NpY2hlY2sKaW5kZXggZTA0ZDMyOC4uYTFjNDE5NyAxMDA3
NTUKLS0tIGEvc2NyaXB0cy9jb2NjaWNoZWNrCisrKyBiL3NjcmlwdHMvY29jY2ljaGVjawpAQCAt
MjU3LDYgKzI1NywxMCBAQCBpZiBbICIkQ09DQ0kiID0gIiIgXSA7IHRoZW4KICAgICBmb3IgZiBp
biBgZmluZCAkc3JjdHJlZS9zY3JpcHRzL2NvY2NpbmVsbGUvIC1uYW1lICcqLmNvY2NpJyAtdHlw
ZSBmIHwgc29ydGA7IGRvCiAJY29jY2luZWxsZSAkZgogICAgIGRvbmUKK2VsaWYgWyAtZCAiJENP
Q0NJIiBdIDsgdGhlbgorICAgIGZvciBmIGluIGBmaW5kICRDT0NDSS8gLW5hbWUgJyouY29jY2kn
IC10eXBlIGYgfCBzb3J0YDsgZG8KKwljb2NjaW5lbGxlICRmCisgICAgZG9uZQogZWxzZQogICAg
IGNvY2NpbmVsbGUgJENPQ0NJCiBmaQotLSAKMi45LjUKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1l
LmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
