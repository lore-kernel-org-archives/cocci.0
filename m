Return-Path: <SRS0=zifB=ZG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928C6C432C3
	for <cocci@archiver.kernel.org>; Thu, 14 Nov 2019 14:43:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EFF206D8
	for <cocci@archiver.kernel.org>; Thu, 14 Nov 2019 14:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gDNcIici"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EFF206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAEEgXQf000599;
	Thu, 14 Nov 2019 15:42:34 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2DF7E77DB;
	Thu, 14 Nov 2019 15:42:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2236777D4
 for <cocci@systeme.lip6.fr>; Thu, 14 Nov 2019 15:42:31 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAEEgSD6002237
 for <cocci@systeme.lip6.fr>; Thu, 14 Nov 2019 15:42:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573742547;
 bh=OUP2byyI30Q84lq/qYJW19CHzyOXe1nOIWmy/uYPUus=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=gDNcIiciTKNStw3Roso+HvJpZoA8J8HZkorxtqa7+Aby80A/2Q2RBE0zJ1K18McQU
 wYr73w5PlzOkMXgVy6Hjp3nyWInx119uZ6X99NUm4oXMoo9X+Ig+J6Yuhl5fafNy31
 zkfAPjryIYWIKTvY+4WLNKHCfo3vQgymCJTG4YME=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.120.12]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MK2JZ-1iTskY1V2L-001U1W for
 <cocci@systeme.lip6.fr>; Thu, 14 Nov 2019 15:42:27 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <94469840-64e2-8189-db8f-c25b7efde2fa@web.de>
Date: Thu, 14 Nov 2019 15:42:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:uWOA3TnO3kX1uCTUk3n1Zf9WvGS8UYHZ8RvpHHIHwO5RhdKOegU
 6bnYMSX3kA98LhQ5vpMh31KrIeUohc2PAQUSlNj0B8bx+rzqrJAChtcYOfYIrAf6YA5zQes
 TpnIQaecZoMs9dvE/GssM3J+Igpyda1JFFK7tMrTMkmjOsad1g0Op80y2nSLly+7kNRiTC0
 8wwzIu3eddPpktb26nA1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4fQw4GHuwcY=:m3FKpb5i/rlbngK3a7c1kY
 plhPrOVtjvp9YLQD6I6WAtJdmgIEiIwR0Z3RMDje5OmuookZ/E+pPKha7t+1uwe2wTGbon8lF
 FzzeyK5FBPne4xcagMEpiryf/td2aBGi6NYyeMyF9PdlBA8wuewJ4n6dmsBCJr+1q8PTYQol8
 yKy6+w0zEQKtxa+ATHTaqTaCVD6H6jb2yvUWZGpFnBtnYNULa1vVuxIavvUE2aawawatw0/fW
 I+k3NehjDJybbUAOHlaCHxwZ6O9mdZTX3BVCEhdF8ZQSIYsVqcA3ogo/krRwcyzWDuPVpR5Bg
 fUf+KtxPmawmqi4b9Z32BeK5L/4XiYCtnx+pw2mv+EMxgoluFmBgVg2/M4RIAujVYUq0TvN5R
 hw/7O7c/3GgMI8xQHDA+FjSge80rCjtycAc0Lirb238moJwknAWXLKta9h7MJ1P9Wl0OIWm9j
 QLDHdZypSxV3bR1BQBpD9XBq9AaSEiSR0ItTeQpPUt9GciBhqORW5S+RlOTm3qF747byqVxVc
 CzQT3hy0xhFZ/PBrx0lrMZxuGhEA0DZmnMAUH538s45+zc1mgOTeWG0J4f8muvOjaKg7LFm1V
 jk1O4KY6NVXWdJBXLru5zl5MiqiaB2lovmycxhDesx9mloF7DxKPOzkTHRwmOQlwvba2ieRlw
 u477bTWjbJ7RiadkvjuH6t/W2o5S8Edkq/++0Np9++aK2yumf0PY2pGElYw1Zx2U7LgfMQkNn
 tUDfWqLcNBztUOEWosIsmXwHwotcliXrPsj5w4Q+fcky4bG3riVsTuI0xhz+OAyoMTCw41uLX
 qgqSydQTEm502ndJCckqfAGgXg4K30lmjGHEkTvItNYha55yTBnfJ3ehseYqogzX/vehu2B6R
 YsZU2XrB+r4TFReDS8EHkUhIUqSaOLKJHcK5xR0CTH528S+uCw+qGqq5UMcGhv1EWenC9FmVu
 xeRVB8QLRcAw7GAcJylZPuaEuOgYT+hbIJoBA2d/qMcu7WzSyFPvgr3RQIuGVG9adR/k29tfG
 GHPX2DI68EQr0jH1YkqGXhU65kGEUJ31TBSFhqz/vzvaxLNsggbWUwKOAUmH5juJyO+lvCgp6
 2MXT8ZCZZ/vgYjxc5kzjjH1v/5srydrQnjOIGKwYKiV4n58Gt8zJERxA54RMEmfivkU5dLZkm
 xienY+VSHtwkruMNbBB0lmhwnsGgAzSMKERpNtz3C/D6pC07wi6u/CmV2mTDpS5fzyHBmAkbu
 KbnlMe1RfBhiUK4xrcVzoZ3/IUzb9bMaNt3e4vyNJd94PU8jU/3ylKkQ4PaE=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 14 Nov 2019 15:42:35 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 14 Nov 2019 15:42:29 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Using a metavariable type for function calls?
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hello,

Some metavariable types are supported by the semantic patch language so far.
Can it become helpful to let a customised function determine the concrete
value which should be used for a source code transformation specification?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
