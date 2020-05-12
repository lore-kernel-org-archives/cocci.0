Return-Path: <SRS0=WbyO=62=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D51C54E4A
	for <cocci@archiver.kernel.org>; Tue, 12 May 2020 11:57:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB52A206CC
	for <cocci@archiver.kernel.org>; Tue, 12 May 2020 11:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="iExGvUr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB52A206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04CBvUFK010861;
	Tue, 12 May 2020 13:57:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D91467559;
	Tue, 12 May 2020 13:57:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EC7563E6B
 for <cocci@systeme.lip6.fr>; Tue, 12 May 2020 13:57:28 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:42d])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04CBvSL4019819
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 12 May 2020 13:57:28 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id e16so15010894wra.7
 for <cocci@systeme.lip6.fr>; Tue, 12 May 2020 04:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=YOuquaaoyvmn23lHH/wnuvQVVOmySrxOdGK16wMqBq8=;
 b=iExGvUr6A10z1XYTbnKkKmmHpzOBfg/gDRZ3Jcc8OGddYT+iW1J3t8LT4V/aift/t8
 aH0gJnoEvtx71J/a2k20e/zkfTkmkFzrFkYVw5sbxDM7lGudVjcN7fBr7ouhkA8C5NGS
 u5+sAlPfuFs6fS60QEwkWH5onSyBsaBE4BDhl13EZvjhFajHzLNsUab2LqjNHwXK6j09
 mAxCrSEnJUODHsATsKFehLKmzPgxnUYy8ee3M/Md2AMnzqgNYjlAigBn4Y+xMSu0eDd5
 6bWroW3dRrpaG7mc2ZvVtq4GHRMJRNI7yVIiCxv9ylFpDj28a/pvIr+wBBqMT/KtoN2p
 AAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=YOuquaaoyvmn23lHH/wnuvQVVOmySrxOdGK16wMqBq8=;
 b=oDCm1h0y/TcF96CqZpvLocQx8euQvBmbqcIZRBCUYOXea53l5Ym7Adihu5BxMn5cJI
 dgaU6OdMdSFqKqLNwwBicWfMc5mJNYKZ2XexBZi2Z2MuF3UErspyIBoVDnfY/a0cBCUW
 2QnjKYnQKiZvHDOPw+/HWDthalrbypB7/4i4ImYRRChrtX6N9QNM+7xWJqGLTgVG3jVn
 F26PQ1jq/GDRKSKc6oWG3mJKQuBMHqG/LNThhBuLDFZe0a9IlyHB/JP5hOM6ThcdTo2+
 0vu1nRO276CF6lPD6sraA12Ujm6YiQfdlZJgegebbssLE44OGzh7cIh0okuF3aorWRY6
 Bjow==
X-Gm-Message-State: AGi0PuYBzPHKDSere/F0IDiXPpNEjSmD8ehZkytpIU8IT3zUzCHTuxMl
 AEN7Q5GPOs7L//cspyF5MeTp9CV99/w=
X-Google-Smtp-Source: APiQypLlO9dqe4uFJvWnjL4oKeQFU6+bocTad6jhvfP3SDi+in9kr9CayqAA9OGuPB+VFZa34COKzw==
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr26534669wrp.81.1589284647699; 
 Tue, 12 May 2020 04:57:27 -0700 (PDT)
Received: from [192.168.178.29] (80-110-214-17.static.upcbusiness.at.
 [80.110.214.17])
 by smtp.gmail.com with ESMTPSA id e22sm7462502wrc.41.2020.05.12.04.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 04:57:26 -0700 (PDT)
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <fa30c7d6-5278-9575-517b-31658b1a37c3@linbit.com>
Date: Tue, 12 May 2020 13:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 May 2020 13:57:31 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 12 May 2020 13:57:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: [Cocci] Regression since recent parentypes patches were merged
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

SGkgSmFza2FyYW4sCkhpIGFsbCwKCkkgaGF2ZSBub3RpY2VkIGEgcmVncmVzc2lvbiBpbiBzcGF0
Y2ggc2luY2UgdGhlIHJlY2VudCBTbVBMIGltcHJvdmVtZW50cyAKd2VyZSBtZXJnZWQuIEhlcmUg
aXMgYSBzbWFsbCByZXByb2R1Y2VyOgoKQEAKc3RydWN0IHNvY2tldCAqc29jazsKc3RydWN0IHNv
Y2thZGRyICp1YWRkcjsKaW50IHBlZXI7CkBACnsKK2ludCBfX19hZGRyX2xlbjsKLi4uCi0gc29j
ay0+b3BzLT5nZXRuYW1lKHNvY2ssIHVhZGRyLCBwZWVyKTsKKyBzb2NrLT5vcHMtPmdldG5hbWUo
c29jaywgdWFkZHIsICZfX19hZGRyX2xlbiwgcGVlcik7Ci4uLgp9CgoKVGhpcyB1c2VkIHRvIHBh
cnNlIGp1c3QgZmluZSwgaG93ZXZlciBub3cgaXQgZXJyb3JzIG91dDoKCgokIHNwYXRjaCAtLXBh
cnNlLWNvY2NpIGNvbXBhdC5jb2NjaQppbml0X2RlZnNfYnVpbHRpbnM6IC91c3IvbG9jYWwvYmlu
Ly4uL2xpYi9jb2NjaW5lbGxlL3N0YW5kYXJkLmgKbWludXM6IHBhcnNlIGVycm9yOgogICBGaWxl
ICJjb21wYXQuY29jY2kiLCBsaW5lIDksIGNvbHVtbiAxMywgY2hhcnBvcyA9IDk4CiAgIGFyb3Vu
ZCA9ICdnZXRuYW1lJywKICAgd2hvbGUgY29udGVudCA9IC0gc29jay0+b3BzLT5nZXRuYW1lKHNv
Y2ssIHVhZGRyLCBwZWVyKTsKCgpJIGhhdmUgYmlzZWN0ZWQgdGhlIHByb2JsZW0gYW5kIGl0IGFw
cGVhcnMgdGhhdCB0aGUgZmlyc3QgYmFkIGNvbW1pdCBpczoKCmNvbW1pdCBjMjgwMzc1NjM1ZjYy
ZGZiZTA1MjcwOWU0ZTQ3YTgyMTQwZDMyY2U1CkF1dGhvcjogSmFza2FyYW4gU2luZ2ggPGphc2th
cmFuc2luZ2g3NjU0MzIxQGdtYWlsLmNvbT4KRGF0ZTogICBGcmkgTWFyIDIwIDEyOjMxOjMyIDIw
MjAgKzA1MzAKCiAgICAgQWRkIHBhcmVudHlwZXMgdG8gU21QTAoKICAgICBUaGlzIGFsbG93cyB0
aGUgU21QTCBhbmQgQyBBU1RzIHRvIGJldHRlciBtYXRjaCB1cCwgd2hpY2ggZW5hYmxlcwogICAg
IG1vcmUgdHJhbnNmb3JtYXRpb25zLiAgVGhlIHBhdGNoIGlzIHZlcnkgbGFyZ2UsIHNvIEkgaGF2
ZSBsZWZ0CiAgICAgdGhlIGRpZmZlcmVudCBtZXNzYWdlcyBhcyB0aGV5IHdlcmUgcHJvcG9zZWQg
aW4gdGhlIG9yaWdpbmFsCiAgICAgcGF0Y2ggc2VyaWVzLgoKV2hpY2ggaXMgdW5mb3J0dW5hdGVs
eSBodWdlLCBhbmQgc2luY2UgaXQgd2FzIHNxdWFzaGVkIHRvZ2V0aGVyIEkgcmVhbGx5IApjYW4n
dCBiZSBhbnkgbW9yZSBzcGVjaWZpYy4KCkFueXdheXMsIGlzIHRoaXMgYSBidWc/IE9yIHdhcyBJ
IGRvaW5nIHNvbWV0aGluZyB3cm9uZyBpbiB0aGUgZmlyc3QgcGxhY2U/CgpUaGFua3MgYW5kIGJl
c3QgcmVnYXJkcywKLS0KQ2hyaXN0b3BoIELDtmhtd2FsZGVyCkxJTkJJVCB8IEtlZXBpbmcgdGhl
IERpZ2l0YWwgV29ybGQgUnVubmluZwpEUkJEIEhBIOKAlCAgRGlzYXN0ZXIgUmVjb3Zlcnkg4oCU
IFNvZnR3YXJlIGRlZmluZWQgU3RvcmFnZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZy
Cmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
