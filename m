Return-Path: <SRS0=jkZ/=X4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD431C10F14
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 10:48:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6012086A
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 10:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="aiCZpWtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6012086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x93AmRrq022734;
	Thu, 3 Oct 2019 12:48:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3FF9577B4;
	Thu,  3 Oct 2019 12:48:27 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BDF3277A9
 for <cocci@systeme.lip6.fr>; Thu,  3 Oct 2019 12:48:25 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x93AmPw4008067;
 Thu, 3 Oct 2019 12:48:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570099702;
 bh=Dy8PM6FrgqON+Dh3RUN1f6zuRY5fNp/bjtDUSUkn8x0=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=aiCZpWtJ+RpPbUhyKcM47NW5meM9++lVn2fxjofMpNiM8IqmqC4GKD85AX+69ZVB/
 S21GQ55J7rc5cBhj/+6kS5et8bvsInxmhDbwsoT8VhxnP77ZpFPoVZQOhL0Z+m5BGz
 tgxI9Co6lc70VDeuqfb++rIWmVtikBxNTxQ+MF8Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.81.27]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFc1h-1iJ1Rj0NFt-00EeJD; Thu, 03
 Oct 2019 12:48:22 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <c0801ee0-c227-5d9d-50ff-3ad872621808@mykolab.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <36ca6616-5c40-66cb-60d6-5e7f4b39def6@web.de>
Date: Thu, 3 Oct 2019 12:48:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c0801ee0-c227-5d9d-50ff-3ad872621808@mykolab.com>
Content-Language: en-US
X-Provags-ID: V03:K1:zupXntcJNmocpclFfMKWeQvfxVlx9zKjUs8v8zO8svczqRWrW5u
 kkSwQhhYa58m5eHi2yzB7RtskgGN0ckLPVH8A3V6gUsQ5Jkek/OmuTSiKIvWTKr5SQEiG+W
 761Rb5g5PetmTgebR1N20mZDwFHtiklYmmKXMe8pZLATKsjiLQuEEvh94Xe2j0WTFyZExTG
 yLOGpk5JQH+OWjyvXuVTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MKL5AzU8HL4=:gl1UB4vjE5w/bQXEDZtiCf
 Uy+THzsHjDRqs3bZM3qifhxn2WGJuF0iR1yK/CMQaEuGjkISjDbKreIJ7Fcn8uOGXdQpTaywo
 Wq1OXb1w3M+KYTd0otgXxHr4ffROcxgGe21sv1kiE4edGvb6Szlx7mDSZHYukTOnaD3kt0Ak7
 H9pOX92XTC3Bcz0ioMftPr7yJ4U2z7C350VQ6h834VOsUk/ZyFrA4SZRFx3z3j1u3jJuMDmgB
 G6WW6XgS7PFVDOMQsn26MMionINTVr4GXur6f2DP9XKSCV2t7LMfI6lSUPv8VPt0dRTh0iVML
 D6V3hOp0YjbhZFwGoturvFD40cfNnhXIYgbXgv1daAuXrpwTSnoRN6j83+SQHSRmmdrmqbFjG
 /Zu/xIjwoaxlUI1mULdCTHg8hiJvvE9I+HrXS/Yu/kvUrZYYgrr1WGUyMVDjpBnQSfBG6mdH4
 DV7/X4Ad1E0LDS53bdDM6iFX7rRUFNR/4jbXe49dC78eCIdRIMGulGgHNI++25wz7ualtWyQm
 zEOK7kbhwPSz+GGm3eLNBdwEC9en6CXc2OnH3IZBTfzoOrBeynmiCk/iwMUnfg1R6F2OiNoWZ
 sF/kARA4fCJzV6Jwktbzv4If01RCA1+plvnBoclgXlcagNErRVketO4eVYOxPM1U5C0nYD/j4
 KKIbioNwBB3ktGoWefhpDrJeN6y/hQdWfdBcVk6Av0UG56FkEioGHJkMB5kroVTfXHHlqxbya
 RSbdd8G0Vgt+3aAhAjl1OBrnphTs1R6IIKIPzXRuS3FLVGk+VVByzpGumsw9yngd0cRDbgYzT
 hAYzJw/NtauefqLNcSbtZtj7nY7Nk84GE86qj5L59F3wvygGzE6Qyc8rCIwIKjlnl5KZEf1du
 4OM2gjYJ0LoKEoQ/pqipeCwZpjqi/pin0miGLKDg3TFx5dScdGwpqHPliL2k/iBrJjizXbBfS
 SO3mtRj96bMO7fe9uxnpv0SdTNAtzq+XRMEu82MCMu5Ag/eKMBw2uTFYOGILV6Co9JoVWi6mY
 jnRMuzvJvUWxosIZ2F1EyJVT2NMMaPYMWuIbDEhIx2M9nEo8IZtPgmhppcPMyviPgl6Q7+/zE
 afRVdNUqdoEIGo1qLKopzRmTDiBfo+9WEUfj4mhhm0K/uA5jbRNb2YwNxCaJnQ7J7uRaGHeoV
 xP5CX3vdyJ5+2aphQFO1ZxtuX2cnlP5TEsNZ+G6n4TU4PaSxW0sgCWlg1SUT+DVZH1t1KV2LW
 DqmCUkLw5FPfMlJnbT/PLM8VrhmVfIob8nY9ArUhZR4kZrJLZMJpGUOGjQMo=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 03 Oct 2019 12:48:27 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 03 Oct 2019 12:48:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Missing support in SmPL for wide char character
 constants and string literals
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

PiBtaW51czogcGFyc2UgZXJyb3I6CgpIb3cgZG8geW91IHRoaW5rIGFib3V0IHJlc3VsdHMgZnJv
bSBhIHNtYWxsZXIgdGVzdCBjYXNlPwoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVs
bGUvUHJvYmU+IHNwYXRjaCAtLXBhcnNlLWMgdW5pY29kZTEuYwrigKYKcGFyc2UgZXJyb3IKID0g
RmlsZSAidW5pY29kZTEuYyIsIGxpbmUgNCwgY29sdW1uIDE0LCBjaGFycG9zID0gNDkKICBhcm91
bmQgPSAnJ1wwJycsCiAgd2hvbGUgY29udGVudCA9IGNoYXIxNl90IHogPSB1J1wwJzsKYmFkY291
bnQ6IDQKYmFkOiAjaW5jbHVkZSA8dWNoYXIuaD4KYmFkOiB2b2lkIHh5KHZvaWQpCmJhZDogewpC
QUQ6ISEhISEgY2hhcjE2X3QgeiA9IHUnXDAnOwpiYWQ6IH0K4oCmCmNoYXIxNl90OiBwcmVzZW50
IGluIDEgcGFyc2luZyBlcnJvcnMKZXhhbXBsZToKICAgICAgIHZvaWQgeHkodm9pZCkKICAgICAg
IHsKICAgICAgIGNoYXIxNl90IHogPSB1J1wwJzsKICAgICAgIH0KdTogcHJlc2VudCBpbiAxIHBh
cnNpbmcgZXJyb3JzCmV4YW1wbGU6CiAgICAgICB2b2lkIHh5KHZvaWQpCiAgICAgICB7CiAgICAg
ICBjaGFyMTZfdCB6ID0gdSdcMCc7CiAgICAgICB9CuKApgoKCkhvdyBhcmUgdGhlIGNoYW5jZXMg
Zm9yIHN1cHBvcnQgb2YgVW5pY29kZSBkYXRhIHByb2Nlc3NpbmcKYnkgdGhlIHNlbWFudGljIHBh
dGNoIGxhbmd1YWdlPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
