Return-Path: <SRS0=7QDM=YB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BEAC10F14
	for <cocci@archiver.kernel.org>; Tue,  8 Oct 2019 13:34:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4600820673
	for <cocci@archiver.kernel.org>; Tue,  8 Oct 2019 13:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="PeS+PC6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4600820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x98DYBkq012419;
	Tue, 8 Oct 2019 15:34:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9DFA677BA;
	Tue,  8 Oct 2019 15:34:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9F00477AE
 for <cocci@systeme.lip6.fr>; Tue,  8 Oct 2019 15:34:10 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x98DY9Kb023934
 for <cocci@systeme.lip6.fr>; Tue, 8 Oct 2019 15:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570541649;
 bh=269CbXlvPQz9OIUmyjrffCdPnae5Yc4T64N0eqUI6kk=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=PeS+PC6d4/3llGZYbhNwL5qBmIOLLf/wPDd83UAQKK9hLvz+DJ0JsfBzNGGXOfns8
 FEcLnxcV8BnOt/z5X+p2sT3AujEqVd6GjKYx/IlI/4M5VvqotEypePHPaemxM9XeMW
 SHOigsRIxBebMEgAjpsDGnyDOmpHMcLb4PZ5oea8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.6.73]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LnB1F-1hb4M13MQH-00hQby for
 <cocci@systeme.lip6.fr>; Tue, 08 Oct 2019 15:34:08 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a7405451-d478-8ea1-eb69-41fcad9cef0c@web.de>
Date: Tue, 8 Oct 2019 15:34:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:tcbYS9lq/aHY6VBeXuYWK+vYJ25Mvp7FmZEczrNAu4x5mzbquvE
 vjrYSw3QAJQ7KCUBc4nI+8Gu4qPjxp4JwSoUlshc2m+Z6kAQQPEUvTL1PeJrGk2hlR1PFIs
 eBbPidO7rG2NZOH3hQbuqDSRg13GnGy8zQ2x81fH9sx9kIHK265s6iSILVIz7G5zd/X17MR
 nUNblRsmssOH/BmCAF08Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OaAjRhNdMkk=:M7uZkzQQAnKBgxHx5FbOpc
 csKCamR3pbcBTVFy3kNQMB4oSKTstaa5deaFd3vCnmVbWootsX4M4u/Q2L6lrfbfR35QWEW5A
 sCYIbl3xOIU2W/LEsC6ltbfm1oA820WjDwv+53ACCQ1F9YI7C3e7W0Sv7wmLAV5sGQfjcJkXY
 ykFie8DTuIhpOd2A1sde+1H0JzFC2RwkD0Wx1QSGtp/BEQpAsXjLFaJ5GjplXsKhrrML06Vqq
 i1g6JsfLlkhHn0m2j5UeXJMNkIeKCt5biR/7dBVSWzzQstB7gygPffYgmmUMod+NP5d4cTj8M
 3lOa51vEdgk/bggsr+Dj7lKJWclMSEwq6pxTr2rogrqNzi326TTA5zQhpKKqEtdUTu39xdpyc
 f2xmAoLsbWIiOvM5QonQEBS4XUOeLmFfIyWlscPKxuehS5uiDmVhLfIxQfiD/6iTudpx3lS26
 GH3kjmZxhPjU4z5abQ7L9UwPjWcB2MBVTkPVEm3onn8cR9Ws482bkt3j71BIvu504nXDm0NVr
 M1XYMGBl2Xcgw5i6AI/44sjhTac6VG8EhZm7zWoJAarpZleN+tL2bD/ckq2Bm77V6H/AbRMTy
 yrdem9XH4o5uXkzCe961E9bwJyDMV6iLHFeRcTwvWBC+I1btgxatLnCj3qRp0SHen5hB2U99Q
 1Nd0wB+3+UCZSCf/IwZ7kwlT0YIpO5mJDlUwVD7DCzLLWRz24r8TfHhazgn/sDPZAEqOZBd7T
 z6qg4CUhdrsiZ5CyH3u16o7W+GBzBf6P2leVuo+h6BCAhapvdP/ztNX7jX7F0DgtJS6M5veop
 Z3vp8xesoeGUEYnAcvZ54/sVezRKVXnrz/1/56Dcc0feJOQKHf/804DD3qhq1oeyNmnNQ1Aqo
 ltKetgqlk3GH1U5vBqfWcVB5d5+yeWW6TOG8QGzXAHVys/QvFjN2FHTm6Tsr0uwHsFjqGxkuT
 BSc+mdXUp4Z3JdzYArt7eZyMrrZmsaP1Zk1MX1wi6+cjBWY5y7GAFBNRf8VLxKdeUG/8NDNpS
 F0psZwSoW7QAYdBHpwlWO6Tpf9a0U8R6JijKCHKFKU29m7YWtXaQhqkpkQZQyxRytFenXpCwI
 qkfE9FA1Cp+Etsqss7t3E9jgzrJPH360pPyiDNJPM5vtHBQPoameSqGYVTq+bG6UnQEPi4+/x
 kWkap/08cvGzh0EO5A57G4jhUij+0m/QMpvCOwZ9POiqyYLeS90eo5oLVO+G4Q+L24EwNwRtr
 /ifAhw4fEazjIitA/C9/W2xiWu5xhxHlt4u/UtAbKKnGmMi/0EFjelagXZZc=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 08 Oct 2019 15:34:12 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 08 Oct 2019 15:34:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking function annotations with SmPL
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

SGVsbG8sCgpJIHdvdWxkIGxpa2UgdG8gZmluZCBzcGVjaWZpYyBpbmZvcm1hdGlvbiBpbiBzb3Vy
Y2UgY29kZQphbHNvIGJ5IHRoZSBtZWFucyBvZiB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2Uu
CgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxk
cy9saW51eC5naXQvdHJlZS9pbmNsdWRlL2xpbnV4L3N0cmluZy5oP2lkPTkxN2NkYTI3OTBjNGJk
NjI0YzUxOTFiOGQ5ZWRkMTIxMjE3NDllODYjbjE4MgpodHRwczovL2VsaXhpci5ib290bGluLmNv
bS9saW51eC92NS40LXJjMi9zb3VyY2UvaW5jbHVkZS9saW51eC9zdHJpbmcuaCNMMTgyCgpQb3Nz
aWJsZSBzZWFyY2ggcmVzdWx0czoKKiBleHRlcm4gY2hhciAqa3N0cmR1cChjb25zdCBjaGFyICpz
LCBnZnBfdCBnZnApIF9fbWFsbG9jOwoqIGludCBicHJpbnRmKHUzMiAqYmluX2J1Ziwgc2l6ZV90
IHNpemUsIGNvbnN0IGNoYXIgKmZtdCwgLi4uKSBfX3ByaW50ZigzLCA0KTsKCgpTdWNoIGZ1bmN0
aW9uIGRlY2xhcmF0aW9ucyBjYW4gYmVjb21lIG1vcmUgaW50ZXJlc3RpbmcsIGNhbid0IHRoZXk/
ClVuZm9ydHVuYXRlbHksIEkgc3R1bWJsZSBvbiBhbm90aGVyIGVycm9yIG1lc3NhZ2UuCgpAZGlz
cGxheUAKaWRlbnRpZmllciBhY3Rpb24sIHRhZzsKdHlwZSBydDsKQEAKIHJ0IGFjdGlvbiguLi4p
CigKKnRhZyguLi4pCnwKKnRhZwopCiA7CgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2Np
bmVsbGUvamFuaXRvcj4gc3BhdGNoIC0tcGFyc2UtY29jY2kgc2hvd19mdW5jdGlvbl9hbm5vdGF0
aW9uczEuY29jY2kK4oCmCm1pbnVzOiBwYXJzZSBlcnJvcjoKICBGaWxlICJzaG93X2Z1bmN0aW9u
X2Fubm90YXRpb25zMS5jb2NjaSIsIGxpbmUgNiwgY29sdW1uIDAsIGNoYXJwb3MgPSA2MgogIGFy
b3VuZCA9ICcoJywKICB3aG9sZSBjb250ZW50ID0gKAoKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
