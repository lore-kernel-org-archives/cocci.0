Return-Path: <SRS0=iFQY=6H=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C2FC2BA19
	for <cocci@archiver.kernel.org>; Thu, 23 Apr 2020 11:10:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0781920706
	for <cocci@archiver.kernel.org>; Thu, 23 Apr 2020 11:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="O48r8Ny0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0781920706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03NBAfvT000552;
	Thu, 23 Apr 2020 13:10:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5E3C97815;
	Thu, 23 Apr 2020 13:10:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CF63A7763
 for <cocci@systeme.lip6.fr>; Thu, 23 Apr 2020 13:10:37 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03NBAbme000367
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 23 Apr 2020 13:10:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587640223;
 bh=yYnePFBnYjm0+kKDqtFx9/+WaHiU9Mt4y2pqq8GgQto=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=O48r8Ny0ZYNu+ieo0BcnpP8xohl+xKASLTyz7k1sW14pT/vAWAPMNOBs2VJK+Ztrl
 6fWXumet4o/atIKHTCT0lA1amDf9K8Gnu3VOqjMAaz8ElqIDK/FZkeIQZmN8uzObVp
 wLDyJhEmKeCDiz7edeQsdy/WBR7Rf/oThLEFM6KE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.69.235]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9MDO-1jMasD11kE-00CmPa; Thu, 23
 Apr 2020 13:10:23 +0200
To: Dejin Zheng <zhengdejin5@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
Date: Thu, 23 Apr 2020 13:10:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:GkMP8tA8DoXrcGs23WXOvhxS73pgENm3HVMc8sKZzC1R/HE6m0i
 jmxSJ13ymfTtQTeeMYX9H3SQ9zWrJ+A3iMWOY+rRiaot9G1QRnKtZmCj68JYJp2+k2EFMUk
 UomjJesOteW03oZ7Prh0vDzPc4d1jWh0xquPyuirb5LIRsS4yM8UFYH2f5N26Cbx3cdH5Yw
 GL1f2yxRCUmQGVaKzg4EA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Sg4nlms0HE=:2GkcY30Cf6kiC0qUAVS49l
 y/dU4eb+XYNwpr+wqy11BrOis35xPOnubGdtnZxFL1SdrTyewwk8U3spocOuUEx3OeOPRoN5d
 Xu9E5y6SudDCG9PQNE6lA/4p5nNfJcF9rZpT4olR+N5DyKgwkRO70Kdm25W6pGjXgAtWB4dEm
 KZmQgPWCwFmib7iuSVlE/K0YMX8LB++Pf4Tz3J29cIngQ9gnBhVzvm11igPgGUwcPSlIIygFX
 +gnYP5Ybll8zuJDvnMMwPZP4xQ/fPdKdSWEDt6ylLGMjrcaPniVs7mBCQoeCnstfRQNC32RtO
 /b0u/4HTSpV3TR1rjMExtchEsxH42OpXlblOG6KM/Z9InkW6EI0N9Z3auKL+qRuOrymzXv5jQ
 t+MqITBGJx05YVYImF3FKn0PBLEWoAjSX3T/f0mzbOZSDomZ/Lj3uq+/PIZRcnqn9Q3FW1WLg
 H8EUlZYTyo36VMEE9jk77ACTm90MXn8cU7F6Xbtzq7qw2sLNT5GBD+UkTOkHvk9sexvYwzchA
 VzxnxE/QsD06DWnj/dR54BcH3HRULh8LP9QF+RnfqxP07Xo9DKWmVt/RzHzwBpQpIhMv4tFiL
 666vm0/X6mgbm3hk3e2vhI0FCpRKeC4gjFil3CyLghKxpU3ErMxPoCWcrDG9LEBYZMcBhr7Ds
 K1972ASYlbV+qMivslga/iWEAMzvY2ucDbtsTewgjUlVN/dEr6DqNJBTekvs8fnaCYejNRyPx
 N0GOwELWkmG2PSsBrv8AP1rGdiu7gFcWMLP1+TCa3al8bfrdm3XcmAP7KzhyAGxyI3ibe2BV6
 U3ziTlNtv1OQqwlv7/Fl13ndU20T9TVNNsnvbpG4fKdoOOtiTLvIOfU+uyzLr8vENZmGStuno
 OjwuZYDzlqk5H4YtgxZUgnC9kcu9kfLkmbX9vej2XWKtyXCC4Y7C5wTrm2qG+dJbPuPn894yv
 SLu4AFhOhvu+AoeXRPBmfdQtew3/k4sOD6LJd/avFsosT4DB70X1TxmhKKvc6R0SI6+cTsATK
 d9iuHOUCAfOtQd0pWw+HXHoUOLGCU9GyBh8Gd1e29c1+B3hvZd5PMvUH15+W7Cb87h0Geg9bH
 N8SK3nLi2vYuPSgtgEiYWqiSAxX7kox+7BnIwMPeBqPIZtX6YjuoK41600sGpL+8xuUmcG4es
 GHV9SEv4T9da9MQuDpACg2OeSvLbx8QdpXt8i5/dbZGhPUXVNukyys2BeyQXEL4uek436fqmt
 3/XBRMaFdw6b+u7KV
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 23 Apr 2020 13:10:41 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 23 Apr 2020 13:10:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?UTF-8?Q?Thomas_Bogend=c3=b6rfer?= <tsbogend@alpha.franken.de>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Cocci] [PATCH v1] console: fix an issue about ioremap leak.
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

PiBpZiBkb190YWtlX292ZXJfY29uc29sZSgpIHJldHVybiBhbiBlcnJvciBpbiB0aGUgbmV3cG9y
dF9wcm9iZSgpLAo+IGR1ZSB0byB0aGUgaW8gdmlydHVhbCBhZGRyZXNzIGlzIG5vdCByZWxlYXNl
ZCwgaXQgd2lsbCBjYXVzZSBhIGxlYWsuCgpIb3cgZG8geW91IHRoaW5rIGFib3V0IGEgd29yZGlu
ZyB2YXJpYW50IGxpa2UgdGhlIGZvbGxvd2luZz8KCiAgIFN1YmplY3Q6CiAgIFtQQVRDSCB2Ml0g
Y29uc29sZTogQ29tcGxldGUgZXhjZXB0aW9uIGhhbmRsaW5nIGluIG5ld3BvcnRfcHJvYmUoKQoK
ICAgQ2hhbmdlIGRlc2NyaXB0aW9uOgogICBBIGNhbGwgb2YgdGhlIGZ1bmN0aW9uIOKAnGRvX3Rh
a2Vfb3Zlcl9jb25zb2xl4oCdIGNhbiBmYWlsIGhlcmUuCiAgIFRoZSBjb3JyZXNwb25kaW5nIHN5
c3RlbSByZXNvdXJjZXMgd2VyZSBub3QgcmVsZWFzZWQgdGhlbi4KICAgVGh1cyBhZGQgYSBjYWxs
IG9mIHRoZSBmdW5jdGlvbiDigJxpb3VubWFw4oCdIHRvZ2V0aGVyIHdpdGggdGhlIGNoZWNrCiAg
IG9mIGEgZmFpbHVyZSBwcmVkaWNhdGUuCgoKSSB3b3VsZCBsaWtlIHRvIHBvaW50IG91dCB0aGF0
IHRoZXJlIGlzIGEgc2NyaXB0IGZvciB0aGUgc2VtYW50aWMKcGF0Y2ggbGFuZ3VhZ2Ugd2hpY2gg
d291bGQgZGV0ZWN0IG90aGVyIHF1ZXN0aW9uYWJsZSBzb3VyY2UgY29kZS4KaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC9s
b2cvc2NyaXB0cy9jb2NjaW5lbGxlL2ZyZWUvaW91bm1hcC5jb2NjaQoKSG93IGRvIHlvdSB0aGlu
ayBhYm91dCB0byBleHRlbmQgcHJlc2VudGVkIHNvZnR3YXJlIGFuYWx5c2lzIGFwcHJvYWNoZXM/
CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczov
L3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
