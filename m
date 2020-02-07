Return-Path: <SRS0=Ekfz=33=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EEFC2D0B1
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:24:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8670F20715
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="UZ0XOZ70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8670F20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0176OhD2021451;
	Fri, 7 Feb 2020 07:24:43 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 91DF877EF;
	Fri,  7 Feb 2020 07:24:43 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 98F33772B
 for <cocci@systeme.lip6.fr>; Fri,  7 Feb 2020 07:24:41 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0176OekY022852
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 7 Feb 2020 07:24:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581056678;
 bh=DW6Q95ztzteCUrT63KMgo3QB8R/ky4NUDLRPDGxMmdM=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=UZ0XOZ70iuJ32lkVFeCwdpx7ybB0x7x1JGorV8EfiTH3Wy1tXdZid+1iDq3Q9Ukm1
 q2HN79Xp1P6W2Gyy4ci2Y16xKrKRDZJRZ5T33Sh8hSeZzcrl2YbvMjoW/C+VofwIMh
 ZRjqm49oAfHtN4NdiAnq78KLzY062rHEvqGnXnec=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.120.50]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXYjm-1j3vM01Xzq-00WUWT; Fri, 07
 Feb 2020 07:24:38 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
References: <132f414d-397f-fb9a-ff6e-5360df827147@web.de>
 <f7da90d8cc0e609a2a81e7a041cc98afedb215b6.camel@gmail.com>
 <964378a7-ddd3-a1f8-e567-f3c4392b14a5@web.de>
 <6e7b556fe05500b5c4f0852b5a7b65f9c762f5ad.camel@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <837bff06-4c16-7a12-3c85-f7859b8813cc@web.de>
Date: Fri, 7 Feb 2020 07:24:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <6e7b556fe05500b5c4f0852b5a7b65f9c762f5ad.camel@gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:BB4NwsPG91HSDjkwfdwbTme+84EvDgFrkirVIrUHT6qE4qN82vA
 aBbxoT5531wc0quLkYgv95SW6cCUGdd+Gu35gmZExA3n6QjQSkHycR6ZINI6M0FI1c1HVvE
 5dFAzK7l/COmrtmwE8ouHYNpXj0xoUbBgr/rnhAxHQDcoXKmblHaHhaDlkwlKm9tTETACZR
 q4pv4YxJBtVoyeFLCCAwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YAoJ8gbw5YQ=:vmu/Cz4FMjBb/8ehb3i7ME
 qOVbP5HY+2icPivUqfSq5dvM9PLNg5NDILcHbQAByhmh16jPZAwWiaYrAhXBRiDa8h93MCu31
 RgkoYHFHwPY/TPzNZwwjUs9WqHQ6K/YxFgY9qE4IBgr8gBRsU4M1R+xedkiyF0gswBzycu3FG
 EDYQceSr0z6QFJTVZAi+vvd9zuL4bkTDmBq5b8POvL9l6zov+PaJTbkcvxCp4U7TrTp9hNmgW
 0JDJ84Vhf8bVIx3Qcd/YWPSZn3ufYof4EV8sCbP3ar5pxTn19VkJKvkyFKEjy3q/MwNAXHPIS
 KDpSZEJRn0n/uo0Ol+PQwbLDKO3fsUYAuVPB/6QtI7ADWz+rDX7lj7uV0xHbzJhkVWRnLE2IK
 OKOCbilm8aF1R8QY+llXblthbzsN2MOuIFGdEYFFQ4DjDP5f1XET/qRs+rPALqa+pV3+84fAx
 92OSNRZdPy8GLoFp0Cpcl82qCy6HHwq3UEwr2bUVvQqqMLYgQf/scfZddCc35fY+7UBW2Yq5t
 iPxDABeSgOeZ4Uf1YUQJ90f8iCTR+VYDVtH9V3M+Vk5i07Wuwu3WJ+8hwYYE08bjC/CTbaV+Q
 DAcN37yTwGD/Z3lhPJ2SjUxb2GEUNJH9CldAN0x7/QYQY/XLV6u8pfD1yvOwZELgEYZjroWF3
 iBrKkAbRgptQLwYOKuLMknyhgh91oSOw26CzrpNHNItUENaMPyufxPxQHQTbRQ5/Nl4OMnjj9
 KA3buKY0VbdewPb6HqMlutgWmeP75Fi5GtWfA60eXlq0RLsqYUveQx0W0On/JHWXngJe6s18t
 U7g5XXMr88G/4r1F5sVUZKvadutIBdKVfWfDpfbPhSwhXWfzp4bjSQYnkuKLx0WfquI//rQBB
 WrQHZ2HEL5frh3uH8g00qeLPgS2D2ho9WC0Sd7ALrQi5iVp2/IOEiCsn7BL1mUBH391JPhmaF
 DLKTjItWXS4L6ThuLHLH9b+7yFESEtmzVFYSy0G+HVb+6pM3dF47fT2ZbMYF2CZYsX1NUrcbf
 zZ5/IvjkLJqsOjuKM7YfoGskNP0ZwuNZk0+nT2i/wn/weSccYHPzmNSEBArBlnSNEr+UIoXxr
 MQ/yWsmF6F2WRvKv+Gl5GHuIrwCxbwBf57OzKFn5gBztxC8UCma72RbVDMuYkfVoOF8W0V1a9
 x/y+nobSzXzVu+qQfXeBML0GZD2WaQbsd6sj8ljTadmkj5kWYevo6wChDkaV2YSWbQ85YEFb0
 m8e0bqCHgqfCf9OB3
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Feb 2020 07:24:43 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 07 Feb 2020 07:24:41 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [2/2] tests: Add test case to match const pointer
 variants
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

Pj4gKiBTaG91bGQgdGhlIHBvdGVudGlhbCBmb3IgZGlmZmVyZW5jZXMgaW4gdGhlc2Ug4oCcQVNU
4oCdIGJlIGNoZWNrZWQgYW55IG1vcmU/Cj4KPiBBbiBlZmZvcnQgaXMgYWxyZWFkeSBiZWluZyBt
YWRlIHRvIGRvIHRoaXMgYnkgbWUgYW5kIEp1bGlhIDopCgpJIGFtIGN1cmlvdXMgaG93IHRoaXMg
Y29sbGFib3JhdGlvbiB3aWxsIGV2b2x2ZSBmdXJ0aGVyLgoKCj4+ICogSG93IGNhbiBzdWNoIGl0
ZW1zIGJlIGNvbXBhcmVkIHNhZmVseT8KPgo+IE5vdCBzdXJlIHdoYXQgeW91IG1lYW4uIElmIHlv
dSBtZWFuIGhvdyB0aGUgdHdvIEFTVHMgY2FuIGJlIGNvbXBhcmVkLAo+IGl0J3MganVzdCBhIHBy
b2Nlc3Mgb2YgZGF0YSBjb2xsZWN0aW9uIGFuZCBkZWJ1Z2dpbmcuCgpXaGljaCBwcm9ncmFtbWlu
ZyBpbnRlcmZhY2VzIGRvIHlvdSB1c2UgZm9yIHRoaXMgcHVycG9zZSBhdCB0aGUgbW9tZW50PwoK
UmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9z
eXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
