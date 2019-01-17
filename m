Return-Path: <SRS0=qCdB=PZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB87C43387
	for <cocci@archiver.kernel.org>; Thu, 17 Jan 2019 00:22:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A80206C2
	for <cocci@archiver.kernel.org>; Thu, 17 Jan 2019 00:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUeK1EcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A80206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0H0Ltow008821
          ; Thu, 17 Jan 2019 01:21:55 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3A51F76E1;
	Thu, 17 Jan 2019 01:21:55 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CD2BE7635
 for <cocci@systeme.lip6.fr>; Thu, 17 Jan 2019 01:21:52 +0100 (CET)
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:e43] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0H0Lp97005951
 for <cocci@systeme.lip6.fr>; Thu, 17 Jan 2019 01:21:52 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-vs1-xe43.google.com with SMTP id x28so5108821vsh.12
 for <cocci@systeme.lip6.fr>; Wed, 16 Jan 2019 16:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=2hUmBMH53mc/eXyTbx+sA3B1n7yb26Gavyl6y32QMgM=;
 b=ZUeK1EcUvsVb1iRcuWPumg6d9J8GPN5t9wRReDIn7e/MW/4L8q7sn7DEC08fGMWBF7
 PMBRKMpPsj+BPIy4S8LmDY5M1vKsrSVubCpcF1WXx8D8AvaFv3qFhEq3du/sQibxoLgb
 csU/Q54g47CHuGeAXWiBoDWvXSRAb6acODDYdQpuoiFQPfq+6evP9Oh5mUI5wG75zJDl
 VPjQv3YaEYyiEVd3hBijvpxmHbmVin93p8THvDeVUnwh7roKJjaFnqneDmyO4OTB4VFB
 GA5VKFQrxZAKRQ4a3izKMaPx9dem/tKWGF/lv5HdwVn6hHM25NP6lXuivR0HTm45/YMV
 /oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=2hUmBMH53mc/eXyTbx+sA3B1n7yb26Gavyl6y32QMgM=;
 b=o5jYQfsIiqc1/ViUJV9qUL268pH2Opr++qwH0DlW0zrKimifiqhzleQPhxsby8hkCE
 MRwTEXXhLX4pyx8IGSd9/F+/NxonEV2zZEX369YLCJi2ahHCXmVEF437UZm/PRPnhYRb
 yAvLWifeCAhc9hpvmOsaRn5qDcc656RaN6dSW+X0bpoB673R2E6pwFgqrYq8bXeXT52T
 S1sPZ+LqgkeDSHfYwh4ynH9cnmxQP2YK3MGS+iwNHXgZKm1ePsTPdUAccM8h7OfVJNRp
 hwMND465Na2mjXDqgjnF0SeREEBbJauGqr+6mIkJCIjdTwhp8LJl6kbHUz/xR56H6Yo3
 8U2w==
X-Gm-Message-State: AJcUukejcicmlrSAOiovMsBR0CnoeCnHcHhVkbpc71W3a6nxp2nZpprE
 22tnMQBM6OPMeNb79lQnRbVjG1QAwqWAMtnPeH4b6g==
X-Google-Smtp-Source: ALg8bN7RfOJiB6FeCnk1q7Bi3dbv/O67JA45f87uQ3F1QE5Xff/iaNhMWxONk+kljuCMtXDst1H8Sj3eu3qi/6cRspQ=
X-Received: by 2002:a67:848a:: with SMTP id g132mr4871764vsd.222.1547684511370; 
 Wed, 16 Jan 2019 16:21:51 -0800 (PST)
MIME-Version: 1.0
From: Kees Cook <keescook@google.com>
Date: Wed, 16 Jan 2019 16:21:40 -0800
Message-ID: <CAGXu5jJCrGmkfzMfPUWKU3GUdScP_coze80sSwWs+jsubt9RHw@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 17 Jan 2019 01:21:55 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 17 Jan 2019 01:21:52 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Confused by regex usage
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hi,

I have this .cocci:

/// Unchecked use of snprintf() return values can lead to bugs, especially
/// when returned or used to increment a buffer position. This is because
/// snprintf() can return how much it WOULD have written, had it not run out
/// of space. Instead, use scnprintf() which will report only how much was
/// actually written, keeping any overflows from happening.
///
// Confidence: Moderate
// Copyright: (C) 2018 Kees Cook, Google. GPLv2.
// URL: http://coccinelle.lip6.fr/
// Options: --all-includes --include-headers

virtual patch

@sum_patch depends on patch exists@
expression LEN, BUF, SIZE;
identifier FUNC !~ "^\(snprintf\|scnprintf\)$";
@@

(
  LEN =
-snprintf
+scnprintf
  (BUF, SIZE, ...);
|
  LEN +=
-snprintf
+scnprintf
  (BUF + LEN, SIZE - LEN, ...);
)
  ... when != LEN > SIZE
      when != LEN >= SIZE
      when any
(
  return LEN;
|
  FUNC(..., <+...LEN...+>, ...)
)

It matches net/sunrpc/addr.c:

--- net/sunrpc/addr.c
+++ /tmp/cocci-output-43547-394eff-addr.c
@@ -79,7 +79,7 @@ static size_t rpc_ntop6(const struct soc
        if (sin6->sin6_scope_id == 0)
                return len;

-       rc = snprintf(scopebuf, sizeof(scopebuf), "%c%u",
+       rc = scnprintf(scopebuf, sizeof(scopebuf), "%c%u",
                        IPV6_SCOPE_DELIMITER, sin6->sin6_scope_id);
        if (unlikely((size_t)rc > sizeof(scopebuf)))
                return 0;

But I can't figure out why. I was trying to exclude matches against
sc?nprintf, but the FUNC line appears to make things crazy and break
the "when" check. If I remove the FUNC portion of the pattern, it's
fine, but then I miss a bunch of cases I *do* want to catch, etc.

Thanks!

-- 
Kees Cook
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
