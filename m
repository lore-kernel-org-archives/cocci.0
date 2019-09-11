Return-Path: <SRS0=74vx=XG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A35ECDE27
	for <cocci@archiver.kernel.org>; Wed, 11 Sep 2019 06:58:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8951521A4C
	for <cocci@archiver.kernel.org>; Wed, 11 Sep 2019 06:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="fINEh+Rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8951521A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8B6vsdN011114;
	Wed, 11 Sep 2019 08:57:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A20AA7797;
	Wed, 11 Sep 2019 08:57:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6963176D9
 for <cocci@systeme.lip6.fr>; Wed, 11 Sep 2019 08:57:52 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8B6vpFc023739
 for <cocci@systeme.lip6.fr>; Wed, 11 Sep 2019 08:57:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1568185071;
 bh=UcUhmz3qCcQ/3lHCFDN2A44GQZDqKBHkY1A4WmUrKt4=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=fINEh+RxFq4d/2gyD4ToJkcT04HRkehgWTitF5Sm8ch7EbHUHO9kMuPGLh72e6jk4
 ILVbCgLrntqbi9dQCiSQARl/4fsV4brM4m8sCr5CSfpLm/R11sI4zLCEdPkEb5aWwA
 EZdSfiCsFe5ZPezvkRY3bIesw5BRvUcqrwP5MD4Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.183.158]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfzxX-1iSRF51LEB-00pfkN for
 <cocci@systeme.lip6.fr>; Wed, 11 Sep 2019 08:51:20 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dfc2d794-93b6-4f9c-a6c9-9af6b8708f9b@web.de>
Date: Wed, 11 Sep 2019 08:51:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:oGYi1FF33y+dhaGjYLjQsAQjUCN6y8iQnS0IDUbrn1PJs3Yqhmh
 osKwOMxPVOlyluQjFuKVuQD6GdrMN7khqsCKiCcIip7SmJCS+2ptfrcMw8V9ISUvwZ3qUX6
 rVlihnmqAJLEfhdnP/Cp5DAW7EVL98IHDj5ub3m8EVVmgUQelxa732Nh9A0jSHZ4qKCMlps
 PaA+ZfLtbfdaqmajb6kMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cDgn1zOCwLU=:0b/fVp7PjsvZnTNbqzj3hL
 4zD10KpYDW8mbLzymjNYhOW61mSOXci4h59Mpu3fKonWgw87MeHUr0MCDuXGC9BfH+sihyDw0
 I6q6FlTu4H/O4DbEy/gxedzccHjfEG9+m69iYfG08PQVtf/Eu9SNpgBNjqjEIKlYBAcMym7Io
 +gczH7IjEpyRoEgIuvTj9fjN1iLso8IA1mqiJ92WQqvK19yXB2tk9Bul7msCW9KUMUxh5VEqH
 eGiFnghQCHl60Ocws6ij3xt1YnYHFC89CmiI9Hn6Wo4mdSA7ZFgiqXmx3USkAmI+lx4oOSm9n
 nhTXMhiODxwUTbja/05lnEa2zsBF1PkdcRr2e/xPqzJipSrjruWQ/vBHPn9+WHEPiBqbg1Jas
 8B18ejHiceqU/9RAwKlUKjFT89yqfbhplBD/oc92TXJ1evmMTDTGcJ4mWzCuakkZqMb08yTqp
 OclCycwZM1X8kKQ5oHvscFNDFcNBJkSnLw7XEvAGr/V8q9gj7h9EUYyY5fYl+8hyfoYuYuei1
 3rLfFpl/Wy7sYLU3zvE5dBwVAMIzlLAnon5Hq3Sa8eV1xxhleU+KWPejSBjH7yXlWeg/H0YR7
 9lSGJ6uQozEPNKbyiCrAUVHo0BVA8cg6kOnx1cxtNkURMw8+AS4Exn7RuXImNhaU2gC1HSjed
 u2hiBg5GnvTSbYmoLuzEu4Equz8ai/eWNZd7fNYEKw4NgTrmPij+kk+kl2Leix1R9lhJBFpNs
 V31prDr3qBV0lr/NOfzNidgXjNgwUrIzLQqoCFLraRG6EqPeecY0N8ByZNZF2NUV7NPrJxENz
 sa6dKaLDwuL/tEtvPe1MjH6rrF5w8qsOB22eX/7PBf26B8CZR3AFIdkdJe17e4iLqudTPkbVi
 9F8T3ukJlyn2K9laILhxu5XL24CaRuQdGeIEmtH8e3cIij5XS4Ec1hVnDV1z/R24tdT8Wt3ae
 MkgcrFF6cNqDhPRvRG150yPK6SotBkKdjWV2q/GrixrB/DxERSM8PGBb8UTX6RsucYn2MvHR4
 U2MM79VxN3lond2BfYA8uX3+3DNywzioAZQb7x7bw2SbkS6nAL2gH8fWaiMDyo/2cZGSQd6/N
 YHWXTxhYoY1ZKt1GxX/pejVZwK+h7sPO0iFrIow1F5CGqOcETha5KHMStCdnVbQiRk0buZk4C
 QqCmPDCbuJQRWGlMs83fRcjS8KxqGKXfq9d3rdhWII4r+9tmxkONXmgGpeyFK2ieCeIveWc/9
 6ioqdwHe6mY2ZAJbC
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 11 Sep 2019 08:57:55 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 11 Sep 2019 08:57:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] =?utf-8?q?Adjusting_SmPL_script_=E2=80=9Ctests/nest3=2Eco?=
 =?utf-8?b?Y2Np4oCdPw==?=
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

SGVsbG8sCgpJIGhhdmUgdGFrZW4gYW5vdGhlciBsb29rIGF0IGEgc2NyaXB0IGZvciB0aGUgc2Vt
YW50aWMgcGF0Y2ggbGFuZ3VhZ2UuCmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2Np
bmVsbGUvYmxvYi81NjBjM2QwMmUyMDg1ZTgzZTliY2Q0MDg0MmVlYzdlNzc0MTQwMTMxL3Rlc3Rz
L25lc3QzLmNvY2NpCgpDYW4gdGhlIGZvbGxvd2luZyBjb2RlIHZhcmlhbnQgYmUgYSBiaXQgbmlj
ZXI/CihXb3VsZCB5b3UgbGlrZSB0byBhdm9pZCB0aGUgbWVzc2FnZSDigJx3YXJuaW5nOiBydWxl
IHN0YXJ0aW5nIG9uIGxpbmUgMToKbWV0YXZhcmlhYmxlIGZ1bmMgbm90IHVzZWQgaW4gdGhlIC0g
b3IgY29udGV4dCBjb2Rl4oCdPykKCkBACmlkZW50aWZpZXIgZiwgaTsKQEAKLSBpbnQgaTsKICA8
Li4uIHdoZW4gIT0gaQotIGZvciAoaSA9IC4uLjsgaSA8IC4uLjsgaSsrKSBmKC4uLik7CisgZigx
KTsKICAuLi4+CgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYu
ZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
