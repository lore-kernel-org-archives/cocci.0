Return-Path: <SRS0=PnfW=3F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0962AC33CB1
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 10:57:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AFE20730
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 10:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYotTzIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AFE20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GAuhlE018088;
	Thu, 16 Jan 2020 11:56:43 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DCD8E77E5;
	Thu, 16 Jan 2020 11:56:43 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 37E1D771F
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 11:56:42 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GAuaJY024524
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 11:56:36 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id k197so9700749pga.10
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 02:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=8o90uJGV9iAKEeOBMqcrdzpZLHVPTg9A7ldI6APNKjU=;
 b=WYotTzIEP7u60UAKHFKKjp3mXgyrxMLJIHpUldRo1LT8FyePG9Lxn9m1ZF8xNz75RM
 odKo/MNkJZr456ko8XqaFuaopIcwoMYjvNV/q735LAsdBw9j4CKbenHPG9qozl+lY7am
 wdHkLkWbaEjyEGLuW5Ky5xLO+0wReLq7RWGdEKKzWdwurMQHQGxRk2i+u/IPryWldG+7
 It8lbqE3VZ9wKhdyGbI9N2TkgEJuOf3FiIayUN3kS1Qz7/qQacrylvxf0cDinILXxoxV
 0VLesv9ExDMgu2NXxmAWLwYfKKTdplSO6lpPQ6O7BZcDnbPAMSaSpvUZSwpHQmRq8C1v
 pCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=8o90uJGV9iAKEeOBMqcrdzpZLHVPTg9A7ldI6APNKjU=;
 b=UWRqdkPhgQa4hHWgPQzalKM+Hw2NT8gPbQfnFXDi6CA97HVi1I+bmE6KdzT/YGyJhd
 HUGyDkXBMkIjuZHXFh0KARSH0m2K7HXAWkCYBQIlNPBNQGFIk2wiKWGo30geah6fu2dw
 EtwytsJMP215BL8LojxQorkv7QNjlSC1j25bJBABrRjijN9213LEq2bt4qKUrCyHb4s8
 waRXKn8WD1IxtIbz3M4YWHmLfVNalB65dF73Pqt4XT8yMpw2WOdGpdyBRrWMOmgS4hWs
 cJyQaQ4GaLY5QAclDDuLPXijFdha2Axl4uZpfqt3MHqu8AjPiod9tEMro1Rkz9ommCEa
 nHWA==
X-Gm-Message-State: APjAAAXvymM/Hvef25qKA4TVaXGuV2slXfON1q6AJnerJvgaLpyZhZTd
 S3u6wDHygp0ke5kYHPivdmA=
X-Google-Smtp-Source: APXvYqx56DybCF60xW1Q1q1WH3SjBUc3XZdWnPDEILy8oeewxqlrLc261maaNgDg3BiqOpr6P/FoOw==
X-Received: by 2002:a62:f243:: with SMTP id y3mr37330304pfl.146.1579172195697; 
 Thu, 16 Jan 2020 02:56:35 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:1677:7d6f:b2c8:b07a:d4f3:9a2c])
 by smtp.gmail.com with ESMTPSA id n4sm23783737pgg.88.2020.01.16.02.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 02:56:35 -0800 (PST)
Message-ID: <61e7b9f2d132e6bc9feb13ae8fc4636cd934f0b2.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Date: Thu, 16 Jan 2020 16:26:30 +0530
In-Reply-To: <1090dc9b-9556-f6ab-23dc-f7d0a8176220@web.de>
References: <1090dc9b-9556-f6ab-23dc-f7d0a8176220@web.de>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jan 2020 11:56:44 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 16 Jan 2020 11:56:36 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] parsing_c: Add space for tokens after *
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

T24gVGh1LCAyMDIwLTAxLTE2IGF0IDExOjQwICswMTAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToK
PiA+IEluIGNlcnRhaW4gY2FzZXMsIHRoZXJlIGlzIG5vIHNwYWNlIGFkZGVkIGFmdGVyIHRoZSBQ
b2ludGVyIHR5cGUuCj4gCj4gV2lsbCBzdWNoIGEgcHJldHR5LXByaW50aW5nIGRldGFpbCBtYXR0
ZXIgYWxzbyBmb3IgdGhlIGNsYXJpZmljYXRpb24KPiBvZgo+IGEgdG9waWMgbGlrZSDigJxNYWtl
IGNoYW5nZSBpbmZsdWVuY2UgY29uZmlndXJhYmxlIGZvciBjb2Rpbmcgc3R5bGUKPiBydWxlc+KA
nT8KPiBodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2lzc3Vlcy8zNwo+
IAoKTm90IHN1cmUgd2hhdCB5b3UgbWVhbi4gSWYgeW91IG1lYW4gdG8gc2F5IHRoYXQgdGhlIHJl
c3VsdCBzaG91bGQKY29uZm9ybSB0byB0aGUgTGludXggY29kaW5nIHN0eWxlIChpLmUuIHRoZSBy
ZXN1bHQgc2hvdWxkIGJlICJjb25zdApjaGFyICogY29uc3QgKiB5IiB3aXRoIHNwYWNlcyBldCBh
bCBpbnRhY3QpLCB0aGF0IHNlZW1zIGxpa2Ugc29tZXRoaW5nCmZvciBhIGRpZmZlcmVudCBwYXRj
aCwgcmlnaHQ/IFdoZXRoZXIgeW91IHdhbnQgQ29jY2luZWxsZSB0byBjb25mb3JtIHRvCkxpbnV4
IGNvZGluZyBzdHlsZSBvciBub3QsIHRoZSBzcGFjZSBzaG91bGQgYmUgYWRkZWQgZWl0aGVyIHdh
eS4KCkNoZWVycywKSmFza2FyYW4uCgo+IFJlZ2FyZHMsCj4gTWFya3VzCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29j
Y2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGlu
Zm8vY29jY2kK
