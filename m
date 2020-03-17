Return-Path: <SRS0=qWDJ=5C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C335CC10F29
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2020 05:26:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E85C20663
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2020 05:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBrRHMNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E85C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02H5QAdj022184;
	Tue, 17 Mar 2020 06:26:10 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D05217808;
	Tue, 17 Mar 2020 06:26:10 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D7AE03B93
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 06:26:08 +0100 (CET)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02H5Q7r3021920
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 06:26:08 +0100 (CET)
Received: by mail-pf1-x444.google.com with SMTP id 2so11265069pfg.12
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 22:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=gNdDmm7vhorUwmARF+Xk8NDGpFpOZiompP4+GagtC60=;
 b=FBrRHMNV4JW3od0VEbPTXX7Nfbf7Ai20tSB3S5jqDh7jBcRlKrqNhiOVwBmfe9r2R1
 03jAo14NJoSHHkEKxK3YmAbQcygq4DlKNS58GotZGm+MSO9r15DMA4l5azR1IbeQfgvq
 GB5smphVxxi9hQeFSvMATY1eBzrsrvrhYl9wQwPSd3hmOJQVZePH2mgs7sc0UCWHbspM
 P44WH7fCBDTxlrbtXS/35JU6tldUVIGNjau+JDGszajr5yfrcvchUzxYESyS0LPbPmKQ
 g0Rvkg/ChULm9EMej+q23qXuTClEHctCN6SVkypn2hih1a72iNcZ253fX+Wg4RseFZ3b
 pnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=gNdDmm7vhorUwmARF+Xk8NDGpFpOZiompP4+GagtC60=;
 b=FX7Ogx5a6e28b8oTewjeCJLpMzruFDLHbxbZhDJ0rxrDtqbMI8hdg09QIJ/yRcBXTB
 /e0iEpd29agk8L7/RbWUoJNNOt1+fYSkHSIajMjHAUZLutTiMXHoJ8/mWFlWmVl1UgqF
 vxSUZk69EAaFPkPuVb0Cj27xKCgXbYz2q1qCV2afk8WEOlIsRRU9LYVYW3VpQFtz8FWZ
 +vdCHiCEgsZC9xKHajDw1UYY2RpRlTvXWl/dxydm92per6B328bAQ0w1REQqN2Vk6JVE
 opAOQnGxLq42uoPe0MBi1cJb+20L/fvHqoVTQJenKDvQPBNvSxlcX3YRYRLLnE25Nkaw
 CSUg==
X-Gm-Message-State: ANhLgQ153ix2X30eN2b1O8nZckRiZv9jXN4L9EPIeAAKu2ilm0g+ZFP2
 ik/Ae5S0qoma1R2YZ0veVBU=
X-Google-Smtp-Source: ADFU+vvP+yNEQbGSCzcCnT4050ff3M6YXyFHy1ZsZ4JQyp+dkqN04KQEuzmAiukJ94PdTqHEC5tsUg==
X-Received: by 2002:aa7:82c9:: with SMTP id f9mr3434133pfn.168.1584422766527; 
 Mon, 16 Mar 2020 22:26:06 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1672:6342:3ccf:a5d:a11e:f77e])
 by smtp.gmail.com with ESMTPSA id i2sm1339563pjs.21.2020.03.16.22.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 22:26:05 -0700 (PDT)
Message-ID: <ce189c1a9ac054d498ec9525ce5a8c408b9dbf98.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Date: Tue, 17 Mar 2020 10:56:00 +0530
In-Reply-To: <08714c77-6626-ecaf-a73e-ce864fff8de9@web.de>
References: <08714c77-6626-ecaf-a73e-ce864fff8de9@web.de>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 17 Mar 2020 06:26:11 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 17 Mar 2020 06:26:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH 05/26] parsing_cocci: visitor_ast0: Add cases
 for ParenType/FunctionType
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

T24gTW9uLCAyMDIwLTAzLTE2IGF0IDIwOjEwICswMTAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToK
PiA+IFRoZSBvcmRlciBvZiB0aGUgdGVybXMgaW4gUGFyZW5UeXBlIHJlcXVpcmUgaW1wbGVtZW50
aW5nIGEgc3BlY2lhbAo+ID4gY2FzZSBmb3IgUGFyZW5UeXBlLiBUaGlzIGNhc2UgaGFuZGxlcyBv
bmx5IHRoZSBmb2xsb3dpbmc6Cj4g4oCmCj4gCj4gSXQgc2VlbXMgdGhhdCB0aGlzIGNoYW5nZSBk
ZXNjcmlwdGlvbiB3YXMgcmVwZWF0ZWQgaW4gb3RoZXIgdXBkYXRlCj4gc3RlcHMuCgpXaG9vcHMs
IGR1bWIgbWlzdGFrZS4gMDQgaXMgZm9yIEFTVDAgdmlzaXRvciBhbmQgMDUgZm9yIEFTVCB2aXNp
dG9yLgpXaWxsIHNlbmQgYSB2MiBmb3IgdGhpcy4KCkNoZWVycywKSmFza2FyYW4uCgo+IERvZXMg
dGhpcyBkZXRhaWwgaW5kaWNhdGUgYSBuZWVkIHRvIHJlY29uc2lkZXIgdGhlIHBhdGNoIGdyYW51
bGFyaXR5Pwo+IAo+IFJlZ2FyZHMsCj4gTWFya3VzCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5s
aXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
