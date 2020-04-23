Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485ECC83001
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:41:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8DB2085B
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko6BUx5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8DB2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SHfDHj021336;
	Tue, 28 Apr 2020 19:41:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F1BDD7807;
	Tue, 28 Apr 2020 19:41:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 73AF57763
 for <cocci@systeme.lip6.fr>; Thu, 23 Apr 2020 16:29:15 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03NETDCe020251
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 23 Apr 2020 16:29:14 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id 18so3019813pfx.6
 for <cocci@systeme.lip6.fr>; Thu, 23 Apr 2020 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=euZIJ/M801FkiIRohqJykf0KTV1d7R1eB6u3qEkTjI0=;
 b=Ko6BUx5ma8P13bvtmuvtoClR1kdW1PNfQ5Mdcb5ut/b6dbYDkx4snP1pcDRIaxOAWt
 OrjLtoxwLINDnrWAmg7a5CQU5PcYxBNmj260qRjWiFDyutI3obuDy12DDb+0FtQabOsJ
 /3rVzC3AOzR+z+YJlDXnT1BweMe1w5xONexIwTNdYDkMCNDJRsU1inGD2jUIRLgKCL0k
 1bpmI47cx+gGudFoSqsQaGbVCfn+4Mj1YLSG3N0PQxFoc3IwdALS/MkBBF2+D3kD6rLt
 XH+krkBwKgcXAWWSnTzI88j3+8S+pBK0gz36DD/o1UpqdI95hODX2seSYE5abCiWGtNs
 2Z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=euZIJ/M801FkiIRohqJykf0KTV1d7R1eB6u3qEkTjI0=;
 b=QCtkoLDt/ngt4/rkltcHyT/kjC/skkf/IbPq8k+4O9Iypcw9Tw4l+AmxMmTk3bkX22
 4oFzjNHIpVc/yHuRTFU+ApZr++ihS0MQ4OrjZFx6fM30r4musmFMv5RI8lQW4MIAtE4U
 t89fSKapvD7jPz2HUFDZaMzLRGN1u2CVR9p9aMfN+kTxwpr1KmXnJpSNP3voWR+hABif
 Ayugd7urV7lkQSdFC1I3IIpX7z5JqLqTkfhHBYf/7dteGIFPD32X6QQIDxNzPewaunjx
 J/qILHq8X9V5lC1Ld9szVvPB+ZiwAKZRuQotV1prRkgMGV72T3tHCPUdDsbGY0U2gxiK
 LZIw==
X-Gm-Message-State: AGi0PuadZ7XW9cr3FnJBgUNUJF18K3utTknDqlafNNrIq25T9ekRb4MJ
 REPeAgNwnZnPlFghiDDQZZk=
X-Google-Smtp-Source: APiQypLCBsvdXjd0LfkUeemwgs+0ri7ASlr6IwzFVhcmjfzaxZE5iJago8sKARkvbGq9vjBLA4PJvA==
X-Received: by 2002:aa7:96c1:: with SMTP id h1mr4085226pfq.212.1587652153207; 
 Thu, 23 Apr 2020 07:29:13 -0700 (PDT)
Received: from localhost (176.122.158.71.16clouds.com. [176.122.158.71])
 by smtp.gmail.com with ESMTPSA id h5sm2537837pjv.4.2020.04.23.07.29.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 23 Apr 2020 07:29:12 -0700 (PDT)
Date: Thu, 23 Apr 2020 22:29:09 +0800
From: Dejin Zheng <zhengdejin5@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20200423142909.GB1562@nuc8i5>
References: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:41:13 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 23 Apr 2020 16:29:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Tue, 28 Apr 2020 19:41:11 +0200
Cc: linux-fbdev@vger.kernel.org,
        Thomas =?utf-8?Q?Bogend=C3=B6rfer?= <tsbogend@alpha.franken.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ralf =?utf-8?Q?B=C3=A4chle?= <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Coccinelle <cocci@systeme.lip6.fr>
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

T24gVGh1LCBBcHIgMjMsIDIwMjAgYXQgMDE6MTA6MTRQTSArMDIwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6Cj4gPiBpZiBkb190YWtlX292ZXJfY29uc29sZSgpIHJldHVybiBhbiBlcnJvciBpbiB0
aGUgbmV3cG9ydF9wcm9iZSgpLAo+ID4gZHVlIHRvIHRoZSBpbyB2aXJ0dWFsIGFkZHJlc3MgaXMg
bm90IHJlbGVhc2VkLCBpdCB3aWxsIGNhdXNlIGEgbGVhay4KPiAKPiBIb3cgZG8geW91IHRoaW5r
IGFib3V0IGEgd29yZGluZyB2YXJpYW50IGxpa2UgdGhlIGZvbGxvd2luZz8KPiAKPiAgICBTdWJq
ZWN0Ogo+ICAgIFtQQVRDSCB2Ml0gY29uc29sZTogQ29tcGxldGUgZXhjZXB0aW9uIGhhbmRsaW5n
IGluIG5ld3BvcnRfcHJvYmUoKQo+IAo+ICAgIENoYW5nZSBkZXNjcmlwdGlvbjoKPiAgICBBIGNh
bGwgb2YgdGhlIGZ1bmN0aW9uIOKAnGRvX3Rha2Vfb3Zlcl9jb25zb2xl4oCdIGNhbiBmYWlsIGhl
cmUuCj4gICAgVGhlIGNvcnJlc3BvbmRpbmcgc3lzdGVtIHJlc291cmNlcyB3ZXJlIG5vdCByZWxl
YXNlZCB0aGVuLgo+ICAgIFRodXMgYWRkIGEgY2FsbCBvZiB0aGUgZnVuY3Rpb24g4oCcaW91bm1h
cOKAnSB0b2dldGhlciB3aXRoIHRoZSBjaGVjawo+ICAgIG9mIGEgZmFpbHVyZSBwcmVkaWNhdGUu
Cj4KVGhhbmtzIQoKPiAKPiBJIHdvdWxkIGxpa2UgdG8gcG9pbnQgb3V0IHRoYXQgdGhlcmUgaXMg
YSBzY3JpcHQgZm9yIHRoZSBzZW1hbnRpYwo+IHBhdGNoIGxhbmd1YWdlIHdoaWNoIHdvdWxkIGRl
dGVjdCBvdGhlciBxdWVzdGlvbmFibGUgc291cmNlIGNvZGUuCj4gaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC9sb2cvc2Ny
aXB0cy9jb2NjaW5lbGxlL2ZyZWUvaW91bm1hcC5jb2NjaQo+IAo+IEhvdyBkbyB5b3UgdGhpbmsg
YWJvdXQgdG8gZXh0ZW5kIHByZXNlbnRlZCBzb2Z0d2FyZSBhbmFseXNpcyBhcHByb2FjaGVzPwo+
ClNvcnJ5LCBJIGFtIG5vdCBmYW1pbGlhciB3aXRoIGl0LCBJIGRvbid0IGtub3cuCgpCUiwKRGVq
aW4KCj4gUmVnYXJkcywKPiBNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpo
dHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
