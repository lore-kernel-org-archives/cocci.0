Return-Path: <SRS0=mWdE=DZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9437C433E7
	for <cocci@archiver.kernel.org>; Sun, 18 Oct 2020 11:38:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1FE2208FE
	for <cocci@archiver.kernel.org>; Sun, 18 Oct 2020 11:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Tx6+6aAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FE2208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09IBbaEa006903;
	Sun, 18 Oct 2020 13:37:37 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DCF3F7797;
	Sun, 18 Oct 2020 13:37:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 91F0174CE
 for <cocci@systeme.lip6.fr>; Sun, 18 Oct 2020 13:16:38 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09IBGbuN020664;
 Sun, 18 Oct 2020 13:16:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603019797;
 bh=SxEl3W3ideaALgxtlbazOr2xwEEBuQ+tAQ0FULtIbNM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Tx6+6aAFoP26S0SDwTgSwW0f00z8f60f0uq2ZjiDM+sDFJFwWI4xQLpUdXRrYA01P
 RDKQQcHwLHpgF7JfCMKbnhdafPz+QX30oFRQBA+QbB1WO4jjPwo2jkaAkQYew6E3Nw
 lPRuen++UyTIfGzDw+1gUzrf9Qe9HZKCpkk2lSnU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from sonne.localnet ([93.133.46.65]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MTPel-1kuGPb42pb-00SNUk; Sun, 18
 Oct 2020 13:16:37 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Date: Sun, 18 Oct 2020 13:16:34 +0200
Message-ID: <1727796.Akdtb4oiQ5@sonne>
In-Reply-To: <1980390.yx7ZeylQeb@sonne>
References: <42184243.d196fk2T0j@sonne> <1980390.yx7ZeylQeb@sonne>
MIME-Version: 1.0
X-Provags-ID: V03:K1:PKRsQvezp9zzNYy2ivBI5qnj9m7b7T0oTxtVwobf5rQwD6rMSGw
 i7XAECHqvv9WUcsffuB0r5DxeYnRbPQuOi5UvQXRK1GhgprKGLl6sA1n8lEYhildNV3M6bH
 8eT8o21hLqMCK0mvCvHy4ssmK+hx1i5lPnRrJpJfKrBRXnND2d9F1dhmpCbJ8ImjSjNiKSz
 wFmuFPV9AI35xtOgp6d0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e//HLxO95L4=:5nfqZc7F19PWL6ea8RF2ow
 ZvN6O7DZJApYj2SQQDYfnGqxizhoGpu9Q7yFM26a/HT8eCviZDiGuu2kNAOj1hGUcFXZvLJUK
 xnz7Cvnfl28rHcJH61wxszZrz6Cd2DulYRttSnRZ4T8+3l8u4yuYvxn424hwHFelKks6t6Xin
 VahvxWfa4JE3kKg67dueQwLYVK94uIu7PvV7BHZjIH/MMKCErp3dZ3znWm8BQ6TufuZRvsTdV
 txFqTk8M3sWrMBggz9sKS0xVDd2FYcx680kVd7TTPkawsR7i1lC/gEKND0MMCi7hZjtdRzLOT
 ioUViuGPpwPAPZFt5vIOBtuQxWSl0we7j2XB05q0N58ly81oPvVVDlfqGfMOPgeKPH0+UfNRJ
 X44YI8bAs8PujMY+f4ODRKdNsHrRyy2m25/vVs8bFPaFLjlT4wXWDYTAGLycEYlr7w+pnxQ4R
 5GFAxBe9CZRGVF7ylr4XncgUyfCA+NwbCZ/l5zBt+KSQRUCQlblvobcRvyineiNzbcPfZwSVi
 V3mgUw49puFRXV3oZc9srQXQoBqW7EWO5RBPFsnWg5KocNcckY7ZWvfIdhqWfeInQJlgnlPyv
 xobWnU1WUOmHbzOfit8RujfQ/Fdl0kEF4xIICeO0qlr2qRSl2/521ycpx3Evk40qqbzdNwTtA
 LjWJRQtrSMiv8vrKWeL9EL/6bFQbN467tSLfxaP3Of4FAJ0NiZ5yA4xYfkbgsKcZT0t89t3WV
 ZWBPmGTOdTDatCeK/DlyuALuQTO+PKF2YtNRo14J7q4hMRTaEioeMCANJOpKnTDVteAztrx4X
 MLCey/UL4oMc7pokJtSwlxFPaJJJY/hRgbEDMk/IdSy7As0/ea90y6hu3TYXNFpmhV9XGGU/H
 yKSz/qrkJt+oZ+KUsxXg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 18 Oct 2020 13:37:37 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 18 Oct 2020 13:16:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 18 Oct 2020 13:37:36 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [Cocci]
	=?utf-8?q?Determination_of_an_usage_statistic_for_macro_c?=
	=?utf-8?b?YWxscyDigJxmb3JfZWFjaOKApm5vZGXigKbigJ0=?=
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

PiBXb3VsZCB5b3UgbGlrZSB0byBsb29rIGZvciBzb2Z0d2FyZSBjb25maWd1cmF0aW9uIGFsdGVy
bmF0aXZlcyBmb3IgYmV0dGVyIHBhcmFsbGVsIGRhdGEgcHJvY2Vzc2luZz8KCkkgd291bGQgbGlr
ZSB0byBzaGFyZSBhbm90aGVyIHNvdXJjZSBjb2RlIGFuYWx5c2lzIGFwcHJvYWNoLgpJIGhvcGUg
dGhhdCB0aGlzIGNvbnRyaWJ1dGlvbiBjYW4gdHJpZ2dlciBmdXJ0aGVyIGhlbHBmdWwgc29mdHdh
cmUgZGV2ZWxvcG1lbnQgaWRlYXMuCgoKQGluaXRpYWxpemU6cHl0aG9uQApAQAppbXBvcnQgc3lz
CgpkZWYgd3JpdGVfaWRlbnRpZmllcihzb3VyY2UsIGxvb3ApOgogICAgbmFtZXMgPSBbXQogICAg
Zm9yIHggaW4gc291cmNlOgogICAgICAgbmFtZXMuYXBwZW5kKGxvb3ApCgogICAgc3lzLnN0ZG91
dC53cml0ZSgiXG4iLmpvaW4obmFtZXMpICsgIlxuIikKCkBmaW5kQAppZGVudGlmaWVyIGZlLCB4
OwppdGVyYXRvciBuYW1lIGZvcl9lYWNoX25vZGVfYnlfbmFtZSwKICAgICAgICAgICAgICBmb3Jf
ZWFjaF9ub2RlX2J5X3R5cGUsCiAgICAgICAgICAgICAgZm9yX2VhY2hfbm9kZV93aXRoX3Byb3Bl
cnR5LAogICAgICAgICAgICAgIGZvcl9lYWNoX21hdGNoaW5nX25vZGUsCiAgICAgICAgICAgICAg
Zm9yX2VhY2hfbWF0Y2hpbmdfbm9kZV9hbmRfbWF0Y2gsCiAgICAgICAgICAgICAgZm9yX2VhY2hf
Y29tcGF0aWJsZV9ub2RlLAogICAgICAgICAgICAgIGZvcl9lYWNoX2NoaWxkX29mX25vZGUsCiAg
ICAgICAgICAgICAgZm9yX2VhY2hfYXZhaWxhYmxlX2NoaWxkX29mX25vZGU7CnBvc2l0aW9uIHBv
czsKc3RhdGVtZW50IHM7CnR5cGUgdDsKQEAKIHQgeCguLi4pCiB7CiA8Ky4uLgooZm9yX2VhY2hf
Y2hpbGRfb2Zfbm9kZUBmZUBwb3MoLi4uKSBzCnxmb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zf
bm9kZUBmZUBwb3MoLi4uKSBzCnxmb3JfZWFjaF9jb21wYXRpYmxlX25vZGVAZmVAcG9zKC4uLikg
cwp8Zm9yX2VhY2hfbm9kZV9ieV9uYW1lQGZlQHBvcyguLi4pIHMKfGZvcl9lYWNoX25vZGVfYnlf
dHlwZUBmZUBwb3MoLi4uKSBzCnxmb3JfZWFjaF9tYXRjaGluZ19ub2RlQGZlQHBvcyguLi4pIHMK
fGZvcl9lYWNoX21hdGNoaW5nX25vZGVfYW5kX21hdGNoQGZlQHBvcyguLi4pIHMKfGZvcl9lYWNo
X25vZGVfd2l0aF9wcm9wZXJ0eUBmZUBwb3MoLi4uKSBzCikKIC4uLis+CiB9CgpAc2NyaXB0OnB5
dGhvbiBjb2xsZWN0aW9uQApmZSA8PCBmaW5kLmZlOwpwbGFjZSA8PCBmaW5kLnBvczsKQEAKd3Jp
dGVfaWRlbnRpZmllcihwbGFjZSwgZmUpCgoKVGVzdCByZXN1bHQ6CmVsZnJpbmdAU29ubmU6fi9Q
cm9qZWt0ZS9MaW51eC9uZXh0LXBhdGNoZWQ+IGdpdCBjaGVja291dCBuZXh0LTIwMjAxMDE2ICYm
IFhYPSQoZGF0ZSkgJiYgdGltZSBzcGF0Y2ggLS1weXRob24gcHl0aG9uMyAtLWpvYnMgNCAtLWlu
Y2x1ZGUtaGVhZGVycyAtLW5vLWluY2x1ZGVzIC0tZGlyIC4gfi9Qcm9qZWt0ZS9Db2NjaW5lbGxl
L2phbml0b3IvcmVwb3J0X2Zvcl9lYWNoX25vZGVfbWFjcm9fY2FsbHM1LmNvY2NpIHwgZWNobyAi
JChlY2hvICdjYWxsJyAmJiBjYXQpIiB8IGNzdnNxbCAtLXF1ZXJ5ICdzZWxlY3QgY2FsbCwgY291
bnQoKikgZnJvbSBzdGRpbiBncm91cCBieSBjYWxsJzsgWVk9JChkYXRlKSAmJiBlY2hvICIkWFgg
fCAkWVkiCuKApgo1MjMgZmlsZXMgbWF0Y2gK4oCmCmNhbGwsY291bnQoKikKZm9yX2VhY2hfYXZh
aWxhYmxlX2NoaWxkX29mX25vZGUsMTU4CmZvcl9lYWNoX2NoaWxkX29mX25vZGUsMzU5CmZvcl9l
YWNoX2NvbXBhdGlibGVfbm9kZSw4MApmb3JfZWFjaF9tYXRjaGluZ19ub2RlLDIyCmZvcl9lYWNo
X21hdGNoaW5nX25vZGVfYW5kX21hdGNoLDE2CmZvcl9lYWNoX25vZGVfYnlfbmFtZSw1OQpmb3Jf
ZWFjaF9ub2RlX2J5X3R5cGUsNTMKZm9yX2VhY2hfbm9kZV93aXRoX3Byb3BlcnR5LDYKCnJlYWwJ
MG00Nyw3NzlzCnVzZXIJMm0xOSwyODVzCnN5cwkwbTEsNTQxcwpTbyAxOC4gT2t0IDEzOjEzOjAy
IENFU1QgMjAyMCB8IFNvIDE4LiBPa3QgMTM6MTM6NTAgQ0VTVCAyMDIwCgoKQ2FuIHN1Y2ggZmFj
dHMgaW5mbHVlbmNlIHRoZSBzcGVjaWZpY2F0aW9uIG9mIGVmZmljaWVudCBTbVBMIGRpc2p1bmN0
aW9ucyBhbnkgbW9yZT8KClJlZ2FyZHMsCk1hcmt1cwoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1l
LmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
