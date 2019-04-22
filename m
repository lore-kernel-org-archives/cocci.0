Return-Path: <SRS0=lOWR=SY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC149C282E1
	for <cocci@archiver.kernel.org>; Mon, 22 Apr 2019 09:27:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2299D206A3
	for <cocci@archiver.kernel.org>; Mon, 22 Apr 2019 09:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="EfZnuRjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2299D206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3M9Qu9n002442
          ; Mon, 22 Apr 2019 11:26:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9FC9B7725;
	Mon, 22 Apr 2019 11:26:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0993E7261
 for <cocci@systeme.lip6.fr>; Mon, 22 Apr 2019 11:26:55 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3M9Qs7L017417
 ; Mon, 22 Apr 2019 11:26:54 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1555925214;
 bh=HGILgIRwslXFYdmsEqx25gW26aa0BjtpROWj/u6IR3Y=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=EfZnuRjRg535PhQVaVwPV5yTAc2qV0oMANEtP2K7M00BT9ujIKUlyscEUvW8qpgOB
 39/85wSyag2wf6JAUGxJf7HpiGdMidRLiW6x7ovA/Ls9fO2jI9VEfpCHuAwrm5CTDa
 oGRjaimwnyPpaqFuL5BwbTx8YjDSjvRtQmL0Hd5E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.90.186]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMWA2-1hBMsV46sI-008Ft0; Mon, 22
 Apr 2019 11:26:54 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <b3a94631-55c3-2162-ff7d-ff3482f66641@web.de>
 <alpine.DEB.2.21.1904220953540.3142@hadrien>
 <4d1dbbfe-5d37-7938-6cf3-35f3db8d745b@web.de>
 <alpine.DEB.2.21.1904221105120.3142@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b09012f1-679e-6503-b040-488979614f24@web.de>
Date: Mon, 22 Apr 2019 11:26:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904221105120.3142@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:yDChctg2dvWa6ddBYANxZNo0LttZxstZkrW/EeyrzKg5v17HU9R
 3Oh3H5Lv0+RfCJJg32fHYTCM7BK3YDbZKXytAW0v12nFli1TV9qpGTiRRkfT8khtr03hkFt
 BI8ioK/ha9x2mnsyx9boNbf0kzIPRrb5JmgBQdK2nRqgR1lOlt0J0HkDk6bB+b5lCCNC1gH
 fS3OqEpNR0q5rzf7mgSEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R2NFbMnIHJo=:wqoWDakRxIbW4BNkunDjkI
 AGZtUSSeoW+nzVouXy+7cLN5tR8wstfN9P1Z3xUF9f4Bna3tdbdfQJx+PrWEMDXVeg0nPzZ5V
 avCs6EzVlH07pNUXj4ZjN9eOjFBWwTnaJW5Nr3MtzDY8XHIcjbjKSyfjhFmXZHyGLYZ2HfsIn
 Y3uiZe9jrGKMeBAefAnFTRU5h4+Zgn4UpiJvBGiytGg93xirdjTLoiaEvA1FiFbGsqMUtC9/k
 LlM3GTDdONrCJBJi0vPZtZ8GLmncxDSEIuA9dGscr/4Y9YhkcwMpv/PCPGDLpQIE7ZX3s2yvC
 R+dCAC+/O5Lny/vwvlI4+7eDQwWcyRW9eBDWDq3JKfGqobx1kVDi+jjN+0TwL+3RiOjJgA4qC
 ru+byJ/22VSosnWT2m6+jxT/X6g1O7zpo+wy4D7RrnJ30WyBCLS/tLnCeZeccY+eacQgyb/Ci
 IfGkwFroyVAYTTVpiF5mzJkK4EUS6I28/tdvXBLsfsUXMft1SEpBiwRZ4HRbBqWirGH3pTRFz
 oo86hVLqDvk/qJngNwZVAzMMibh+3oX00zNjXgHJMQspJ9CpcpkH1vFHrEHJXUGtr6tEvJCyn
 pflh+LlrG0EeOT8MN+WiFkSajhslt2SlEEWLA5Slv5WQaITOSUmpkU5mEylHK+hV/DzYP9mKm
 KfIAHpHU5Eoz9f5L4iuqRjNqx2tutyyq3EM34tZ8CaPzVKNYB79ZWg/vunSULtxAsOXSaUxg7
 qupqelA7QyN496A2udmX49W2Z2m1sOBMrTEJpXFi4bxFF8w6/jSfyHoSUlT3vq/i0mYZ4R6mh
 Ouy9r8FtqnC+jPJn6t5uLus9s07+sW+jqdVzv9mbFUiNQ1yFddcZFeLx0A9CD+OHb4ld9Zwsv
 +gVJNKc+YOSqH7LUV808oJl8kt9XaX9qYLbPYsizL1vyl2DFP+wXHN19x3re3omhFo8YzMq+Z
 PoaDe2Xsd6g==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 22 Apr 2019 11:26:57 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 22 Apr 2019 11:26:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking uniqueness for source code positions during
 SmPL data processing
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

Pj4gV2hlcmUgZG9lcyB0aGUgYWRkZWQgbnVtYmVyIGNvbWUgZnJvbSBmb3IgdGhlIGlkZW50aWZp
ZXIg4oCccmVnMeKAnT8KPgo+IEl0J3MgaW4gdGhlIHNvdXJjZSBjb2RlLCBhdCBhIGRpZmZlcmVu
dCBwb3NpdGlvbiB0aGFuIHRoZSByZWcgcmVzdWx0LgoKWW91IChhbmQgdGhlIHNjcmlwdCB2YXJp
YW50IOKAnGxpc3RfZHVwbGljYXRlX3N0YXRlbWVudF9wYWlyc19mcm9tX2lmX2JyYW5jaGVzNi5j
b2NjaeKAnSkKYXJlIHJpZ2h0LiBBIGJpdCBvZiBleGNlcHRpb24gaGFuZGxpbmcgY29kZSBjYW4g
YmUgcmVwZWF0ZWQgdG9vIG9mdGVuCmluIHR3byBmdW5jdGlvbiBpbXBsZW1lbnRhdGlvbnMgZnJv
bSB0aGUgc291cmNlIGZpbGUg4oCcc3R2MDI5Ny5j4oCdCmFjY29yZGluZyB0byB0aGUgTGludXgg
Y29kaW5nIHN0eWxlLCBjYW4ndCBpdD8KCldpbGwgc29mdHdhcmUgZGV2ZWxvcG1lbnQgY2hhbGxl
bmdlcyBiZSByZWNvbnNpZGVyZWQgYXJvdW5kIHRoZSBzaG93bgpzb3VyY2UgY29kZSBhbmFseXNp
cyBhcHByb2FjaCB0b2dldGhlciB3aXRoIHRoZSBTbVBMIHNldHRpbmcg4oCcZm9yYWxs4oCdPwoK
UmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9z
eXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
