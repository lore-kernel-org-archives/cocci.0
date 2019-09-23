Return-Path: <SRS0=+zv9=XS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70415C3A5A6
	for <cocci@archiver.kernel.org>; Mon, 23 Sep 2019 08:51:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702A620820
	for <cocci@archiver.kernel.org>; Mon, 23 Sep 2019 08:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="De/sH8ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702A620820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8N8ofl7013546;
	Mon, 23 Sep 2019 10:50:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 10AE6779A;
	Mon, 23 Sep 2019 10:50:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 561707796
 for <cocci@systeme.lip6.fr>; Mon, 23 Sep 2019 10:50:39 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8N8ocUB018483
 for <cocci@systeme.lip6.fr>; Mon, 23 Sep 2019 10:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569228638;
 bh=HMd5fdHJlswtL1UNsk0onBKa0Sq5GGnNQBA6eNFggaA=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=De/sH8acNgiP9dYEbhJaxCfzrsaPCsjOaTdXrroXNimWPWcrKvyISox+kJgj6FUvd
 NaeAkTcUFYUpLGiL+1alyyNu+SuN1SKL/mNK4sL4DBTgLBJoEsTOzzSqhsZIToPtG8
 4WUODZ6RZTxfHDlZMx6nCV3+QEL16WnhNR886qPU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.187.72]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWj7r-1ifs3x1kS3-00XqGz for
 <cocci@systeme.lip6.fr>; Mon, 23 Sep 2019 10:50:38 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
Date: Mon, 23 Sep 2019 10:50:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:vk6Le5O72SkcVn6y/Qjm/4ipDU9S0WeNabp7sXZ5YA3CzQKQX86
 gLfqtCo3LeB5SSZ5hcuyenO8484oBNsqSXnWvoKYnFm2cPsXOnZRn/EAAymyFYpUqAcxy/9
 i9hEgXaOFQ6fPISH2cCFWerLFWnwm+PeZAjIzrN4CLEbgo7wuadULrkIT7/1eIPyhoB878X
 7IFhni/lf7fxvQt9cZj3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:suzKHOvpy+w=:eAopyss1de0nMIDQKsqYI/
 JIQPSWa4/zv/Mjjeat/tmbRm4FNHlE+T9guWFgjChkj/KK8y7gNJ/LxXdM+yA66vPqeZ0MFOg
 TEKO7/jmTHjUG2KOhbu5nvxuUge0jxMifFJGOsmfsYF8NSNyNCDZ32cl4irItMmYo+LiK7iEY
 CiziCSpVUZQA+lzjtE1CEO/Qpeya8lfiq33fygBu866qEpq7CVrF/AI3kP/5I6JfOuSun+uH1
 u3kE+8NPQxu7UTyD6AOVsPWNJrvkKAer87Fuh+XX2p5eH76BnUY9Ppx1wHV97Ia284kE75MJZ
 xcn17/IbFAyHV9nXJ7jftVOMiTrqc3AMPn/INTSpYFcvIQ+agYGBEK2AakgpImRQhLuvknmJ/
 AHVImX/EATs2vXQgJJMJw9vbDh3fty58xDonuNIrhIuxBC95/FF+pWomuQfDXUydPP2lgLyEl
 gM5Z33jtUtdyTUxM5FdbbiCPuXSPxI9f/+P/Fp+Lh9xp2R/GfIqR8W1DaknG0910oBtuct5ne
 FHYFDo+3d8uSYsTokrmDLeTPEHKTx1U29QphJP5xQg/m22Dal5ARfHerN8qR1G3+Vx7HAZCWA
 xMURpk8DAdOCMjYJHxiIGwktyb/N4CyzH3IhQCU5WZufhSZ6wG7lTUuYZUaijLIdtxs5py1Ka
 i5wnkvWLecFQWugoZtu3uc7YiuoFT3yjvnKAgZ5uQQ5SL+ls7I0raywwP1WPLMJbc1zppcPr7
 62YuWvgsDZ1UwuET4shJdcJihKWqRnY6MtLdJA/ibUOHjApaANgQ0b4qcHPQ8l2StCpWutCkv
 4D8KTNPW68sgffdxej24BJkoLDj4vIfnmZI0rNKOU6O5+Mfz969XjEWPNrFwx+qYur+ahC9q9
 HTPw59G1CVPQzWQrpRISiNs9Nh9lQB4Vp4qGY9Q0tlCScDZSWgNfnvNclushzZURubPfm+SnF
 2kngsDl5BKnF89K15l1SdcKQKfMh3LttoVyhnp+y2rvRLSViyokEGplGtB09G8n1m6+/kbw5Z
 xLQ3p3ZN8NTvz+IDbKyioXEH+p2EL/u/kvl4Ww3TKQ78C1Ynnu2BVb8IzxT3XCe7UIGtuFqVs
 CsrVK2kGomMEOIQgnV8Tjq1jIlojXS44tutbpJIvdN1r1W1YcHZfHgu+bvkLU/DRXsiOc1RPK
 QMRrvkOll1m+TOTNiEp6Yah1uAJyMLgM+Zmnp0oBEHFJmX1lxyyQnQivTqprQKg1lfX9lewWZ
 saqgV9/Zfyp2L5n/01VX+jD7t8Ixz0DuzkHn60eazUAY5ZvMVTfrBY4rrPUI=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 23 Sep 2019 10:50:41 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 23 Sep 2019 10:50:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Reducing source code around return statements with SmPL?
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

SGVsbG8sCgpUaGUgZm9sbG93aW5nIHNtYWxsIHNjcmlwdCBmb3IgdGhlIHNlbWFudGljIHBhdGNo
IGxhbmd1YWdlCmNhbiBwb2ludCB2YXJpb3VzIHNvdXJjZSBjb2RlIHBsYWNlcyBvdXQgZm9yIGZ1
cnRoZXIgY29uc2lkZXJhdGlvbnMuCgpAcmVwbGFjZW1lbnRACmV4cHJlc3Npb24geDsKaWRlbnRp
ZmllciByYzsKQEAKLXJjID0geDsKIHJldHVybgotICAgICAgIHJjCisgICAgICAgeAogOwoKQGRl
bGV0aW9uQAppZGVudGlmaWVyIHJlcGxhY2VtZW50LnJjOwp0eXBlIHQ7CkBACi10IHJjOwogLi4u
IHdoZW4gIT0gcmMKCgpVbmZvcnR1bmF0ZWx5LCB0aGlzIHNvdXJjZSBjb2RlIHRyYW5zZm9ybWF0
aW9uIGFwcHJvYWNoIHNlZW1zIHRvIGJlCnRvbyBnZW5lcmljLiBQbGFjZXMgd2lsbCBiZSBzdWdn
ZXN0ZWQgZm9yIGEgY2hhbmdlIHdoaWNoIHNob3VsZApiZSBrZXB0IHVudG91Y2hlZC4KClRoZSBy
ZXBsYWNlbWVudCBvZiBhc3NpZ25tZW50cyBzaG91bGQgYmUgcmVzdHJpY3RlZCB0byBsb2NhbCB2
YXJpYWJsZXMuCkkgZ3Vlc3MgdGhhdCB0aGUgbWV0YXZhcmlhYmxlIHR5cGUg4oCcbG9jYWwgaWRl
eHByZXNzaW9u4oCdIHNob3VsZCB3b3JrCmZvciB0aGlzIHB1cnBvc2UuCkJ1dCBJIGdvdCB0aGUg
aW1wcmVzc2lvbiB0aGF0IGl0cyB1c2UgdHJpZ2dlcnMgZGVzaWduIGNoYWxsZW5nZXMKZm9yIHRo
ZSByZW1vdmFsIG9mIGEgdmFyaWFibGUgYnkgYW4gaW5oZXJpdGVkIG1ldGF2YXJpYWJsZSBpbiB0
aGUKc2Vjb25kIFNtUEwgcnVsZS4KV2hpY2ggYWRqdXN0bWVudHMgc2hvdWxkIGJlIHRha2VuIGJl
dHRlciBpbnRvIGFjY291bnQgZm9yIHRoaXMgdXNlIGNhc2U/CgpSZWdhcmRzLApNYXJrdXMKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGlu
ZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWls
bWFuL2xpc3RpbmZvL2NvY2NpCg==
