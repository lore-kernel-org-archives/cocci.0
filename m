Return-Path: <SRS0=E09L=Y5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A1DC49EAB
	for <cocci@archiver.kernel.org>; Tue,  5 Nov 2019 09:13:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59B820869
	for <cocci@archiver.kernel.org>; Tue,  5 Nov 2019 09:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="LNgtz64D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59B820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA59CgAf014807;
	Tue, 5 Nov 2019 10:12:42 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AA5EC77AE;
	Tue,  5 Nov 2019 10:12:42 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 82E4676FC
 for <cocci@systeme.lip6.fr>; Tue,  5 Nov 2019 10:12:40 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA59CdF2018604
 for <cocci@systeme.lip6.fr>; Tue, 5 Nov 2019 10:12:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572945159;
 bh=Ra8U2RbpLAChmY53Udw89cbzJ6HuiC702Ai3YubVLDo=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=LNgtz64DaeeWLlvYCBOo+u+hgRiM/wcJ5b4lu7JcshNX1rSL4g1RSsHEP4FPkHC+H
 59Gzulwceec+6o1CTuCV3/ySfCeyEUXay8r3XVDa8XeaeyR6qN1lDghcucaa8V+Wvp
 jnGc6Ldu/Dfy7bLM5nAosBiZOCfNn7TBDwGknviA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.164.204]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUnaG-1iQozS4AQe-00YAZT for
 <cocci@systeme.lip6.fr>; Tue, 05 Nov 2019 10:12:39 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <44a6d852-2e8a-f1d5-4700-c5c8b335a647@web.de>
Date: Tue, 5 Nov 2019 10:12:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:/CfWSIl0RK5x3bVnRbKKY1mIB8os3bTotAyDOP18/vYPtfxHain
 sGRtm6CnSMpxKvYvowI+EYLQdi91+I8K7OXdoakMEb6p/W6LMUJdCBs9Nf6M526X7lths6k
 N16BOU1T2MSY5WRaw1G/5WHk7AGbrR4cH0g9PqFBjJQmPb2DBRQrQGy22t6q1X/f8xgejxI
 cWUE/+HjkwuJJNzcNxmrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lg2v50umxnA=:4oCqIwetQ9UfT0yZoxHv5O
 jT2W6Hl+a1+qmZK7IR5vWGmDDc4QxVpC2acY6plI7HQTzIGAXVx64qP/p7F5klVyw9TCbpKI7
 ky167vtUVv/vSVrDEYqLKHffYIUJe79QykzCXOAz++vEq44McNQe/L+uHj5hYfVP9HdFDcpOA
 YU6VzRGX6B9/eb/i4M8ZVEkGqmB/3L1v7uzx+BXaXfBVIHLd+uOoRPonrVQTsMKLECJFuGxm3
 XlkGJN+ce4jiyBAv8YlI+oT9GFA9cJqSbE2g/t4AfR33aJygkj5D0UPdIlQuF9xLyC87h3alB
 bRD6vvLhMPY0etXul2D3o1biEEGUX/YBvrMQwCEzTXBwzg5jX+zFowiX/PEuijGT5/s7vTbrc
 yaz+iqjfMGKLj+AEqGVMWERtAx/ekuyiCHQbvU1kVQYJdIPHN+xZ9mp72bRc0Im7vP/FS+d8g
 vZBPO9LrgJsJLPNUR/p0d9+2uVbqc7TFNG1tvLrkURzm0Bd5A2nPL17sfJgUu/7Y+XsMk9/p/
 mmVZ1iw4TDSYud2s49WRHXoF57lWaisVaRz+d7+JKsDNZBDJ9A+VgZkgoL0yaUn2mNs7pro1M
 oDU67qumpOZLXIG71u6/+VuEa3AIT7kP8UR6ojY+FvLm1koNwxR2BsQbhE4ThX7LRhGseInYi
 5fTUTxutXyTqlk/8hPLO/aM+Q3AnQYbegmqaZ/EQ4KudK2rQbq6sBv2/0EfQDWIGWCsyr/EfZ
 2YFo0U1T4D9HMBbG8vzcI+WMbkL5+PqctuXpwICGhy54snkgvWi1ZY2+ZojHxsPQSefO4PTVu
 C5GrQSLDrO6k5RFwT9JbFfl1usXnMLt545zM361twlCUUvA5PP5Ywy+WI6TfGruL8Lg623T5l
 uRHAp9zQv6apY7Pm5FbGQr2ZEP5Eu9J/jjLzb+yp+iZPAREKEIFhYtcJndKtpeMIhoMRx6YfH
 SgMaDUIlMbFegmM53oFtPqMefX/otCjHv4293dPxN1anx0PRcIRWfV8tbseDYwOBQ1uSd5VWV
 rzK+XogJ2H7Tn/F3osqo0gLaR48f8qujp9wLJwdSjxWyFVmM9hiT9T/CToyRAR+2VKNK7Ff/s
 TO4IORKCLhBDLhZ7ngy32ZC/zDMZltyGTEnhh9ML/a0810zi4KOddW0eAPXMUkJoXOnBB4P66
 K+oq5EexuzPbpxcXD8hnRIiIUXwf9vf/5ionzlRlluVqR+H0IwKv6jji84YZsCJmLPbbo36u/
 2ULt9Hu6wb2jVWvzogE59QRxxUpL0PBwrbnJ6rB8wcKQeAHAYEvU4mDYfwg8=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 05 Nov 2019 10:12:44 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 05 Nov 2019 10:12:39 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking data processing around invalidate_aliases()
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

SGVsbG8sCgpJIHdvdWxkIGxpa2UgdG8gY2xhcmlmeSB0aGUgZm9sbG93aW5nIHNvdXJjZSBjb2Rl
IGFuYWx5c2lzIHJlc3VsdC4KCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9MaW51eC9uZXh0LXBh
dGNoZWQ+IHNwYXRjaCAtRCByZXBvcnQgc2NyaXB0cy9jb2NjaW5lbGxlL2FwaS9kX2ZpbmRfYWxp
YXMuY29jY2kgZnMvY2VwaC9jYXBzLmMK4oCmCmZzL2NlcGgvY2Fwcy5jOjMwNTE6OS0xMTogTWlz
c2luZyBjYWxsIHRvIGRwdXQoKSBhdCBsaW5lIDMwNjMuCgoKSSBoYXZlIGdvdCB0aGUgaW1wcmVz
c2lvbiB0aGF0IGEgZmFsc2UgcG9zaXRpdmUgaXMgcmVwb3J0ZWQgZm9yCnRoZSBpbXBsZW1lbnRh
dGlvbiBvZiB0aGUgZnVuY3Rpb24g4oCcaW52YWxpZGF0ZV9hbGlhc2Vz4oCdLgpodHRwczovL2Vs
aXhpci5ib290bGluLmNvbS9saW51eC92NS40LXJjNS9zb3VyY2UvZnMvY2VwaC9jYXBzLmMjTDMw
MzYKCkhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgaXQ/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0
CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xp
c3RpbmZvL2NvY2NpCg==
