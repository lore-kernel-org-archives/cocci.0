Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DF8C4828E
	for <cocci@archiver.kernel.org>; Fri,  2 Feb 2024 11:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=j+sgLkEX1JSk34PGjcX9S19iaZVWVHrRDyoACIvpR4M=;
  b=Gp657dgH9YGgFIlXJOAwBw/RRdyL7l4JVKxDkEDUMIWQnk6YIsWuYXWh
   UzJh6BshGZURA4/ojVhpBjPnEkZ03XFf9vXwWU5ibCMuK3zOsASEOnK7N
   G0OBCdSVxubv9RFkCkuBetyuTny/jqR6INVdSgvu6KNJnWDYJXrP19xqp
   A=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@isovalent.com
X-IronPort-AV: E=Sophos;i="6.05,238,1701126000"; 
   d="scan'208";a="149965000"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Feb 2024 12:32:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0F070E0CD8; Fri,  2 Feb 2024 12:32:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1FEE8E008A
	for <cocci@sympa.inria.fr>; Fri,  2 Feb 2024 12:25:21 +0100 (CET)
IronPort-SDR: 65bcd120_K7qcfXKysC3BfyA5ikGfW4RPK57vQMxuC8WZU6PFVXPXV+v
 YI2BwHh+dglop48mSQiog4DrPXezwKqV/RSFZWg==
X-IPAS-Result: =?us-ascii?q?A0EgBgB+0LxlhivaVdFaHQEBPAEFBQECAQkBFYFPAoI3f?=
 =?us-ascii?q?FUzBAtIhFOPQ6AqgUA+DwEDAQ0UAhEODwQBAQMEjFYCHgcBBDEIDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBASAZBw4QJ4VsDYJVGIEMg?=
 =?us-ascii?q?R4BAQEBAQEBAQEBAQEBAQEBAQEXAg2BFBEEGQEBOCUPAiYCIxIBBQE9GoJeA?=
 =?us-ascii?q?YJfA6k4gQVCizt/M4EBggoBAQaxHYFhAwYUgQYuAYglAYFVh1qBIQ+BVUSBS?=
 =?us-ascii?q?oJ1gx8Cgi2DDoJohVaCLQOTCgkdAwcHECtLEQUdA4EGbRsQHjcREBMNAwhuH?=
 =?us-ascii?q?QIxOgMFAwQyChIMCyEFVQNABkkLAwIaBQMDBIEwBQ0aAhAsJgMDEkkCEBQDO?=
 =?us-ascii?q?AMDBgMKMTBVQQxQA00XHzIJPA8MGgIbGw0nIwIsQAMREAIWAyIWBDQRCQsmA?=
 =?us-ascii?q?yoGNgISDAYGBl0jFgkEJQMIBANUAyF0EQMECgMUBwsHeINHBBNEAgEQgTSFW?=
 =?us-ascii?q?QECAUMdQAMLYgs9NRQbKCebHAGDfYF9esNigQY0B4QUgVsGDIoalS8zqh+YV?=
 =?us-ascii?q?YsPgXVpmnMQI4FBATgugS4zGiOBAQaCME8DGQ+OLA0Jg1iPeUQyOwIHCwEBA?=
 =?us-ascii?q?wmJIoFGAQE?=
IronPort-PHdr: A9a23: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
 UdTh7z/KosXO8vw3EkwMjFH
IronPort-Data: A9a23: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
 b7Kq7Ox3l2r
IronPort-HdrOrdr: A9a23:zYrS3qwfOghgx/mf5qxQKrPwIb1zdoMgy1knxilNoH1uA6ulfq
 WV9sjzuiWE6wr5NEtBpTniAsi9qBHnhPxICOAqVN/IYOCMghrMEGgN1/qH/9QiIUHDHyxmuJ
 uIv5IQNDQ4NzZHsfo=
X-Talos-CUID: 9a23:/1G7X2NdVb172e5Dfy1erGpOHsEfcnTB7ivqCRWXCH5zR+jA
X-Talos-MUID: 9a23:5XxK+QuJ073O3DLUAM2nvDVtHe1qv7mVWWMosp5Fq5PdaiNTAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,238,1701126000"; 
   d="scan'208";a="78564241"
X-MGA-submission: =?us-ascii?q?MDEsuMFcOXQoc2dZWAk7IAPa0RxnXfRVQGYfBR?=
 =?us-ascii?q?aFD3AAuXn1vJtKPFBAcvIm4A+CT8PX+d+piRiW1lu6jPcN0tIm5gcuuR?=
 =?us-ascii?q?2dVj6jAKtxdfWaB9YWXb/IjIdvVjkwc1n2jRiJyCRnC7g3bXBydLc0vx?=
 =?us-ascii?q?h97acG0EyND3otuYsG2UeqVg=3D=3D?=
Received: from mail-ej1-f43.google.com ([209.85.218.43])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 12:25:21 +0100
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so281578666b.0
        for <cocci@inria.fr>; Fri, 02 Feb 2024 03:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1706873119; x=1707477919; darn=inria.fr;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j+sgLkEX1JSk34PGjcX9S19iaZVWVHrRDyoACIvpR4M=;
        b=WEbrDOdHBKFsOHjJahgS45+opPMdAti473b/Q0OqP5PzIvYWSIk5r0m2vB4WtPEwcR
         7CBzGVPZeVmGWFepOK4J71UOXetZj6/KegNpm0I+GxKh+bNUD+4edbhU3j0qbZDPqNNI
         kWdeIsJDiCV/mOaI+Tc7ex1HKIV8GBMyYzcDYZ2H1FMz1EASmSEqUJ4H0Jf0iqWUUHc/
         /fdqi4fPNwulSVl/2nMLRadOfGG8z+T+xdUm7rrsAK/ulo1ggDRwUUjbLSMoCNwz4vOf
         Plz5inSxHIQGksiYTBRHQwcKMnFE2SELo5a+mxRFcc98zzRw0KjRySxdO5BjnT86Yg8X
         ul1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706873119; x=1707477919;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+sgLkEX1JSk34PGjcX9S19iaZVWVHrRDyoACIvpR4M=;
        b=g7ncag8LCVNNzejxCcGHl5o/tLwjAVLozswYiheu3Nb5hYYMhFG2cSMKurLHPEDXo+
         GJmx32maEsjbAYMEay9HhtsK7Mkzh6rioEIMt/mABq7ZmfFy7qATh6THGRbyjtjbeXbx
         jwqd5lxLk1EHMFtehsOWhZkLqgNSvOFKQ/dkH9YbyX6YFmjvk1hCzoLqqUXGEdrP9BmV
         8m230qArO/f0aVguOC1LutQFKtA4JvJp0+v3kUyZ1UpMZtd7Fo9Vdga854zMwbHFEqrW
         df7xj0sWFoO35EjkiG7HFnn48XLmIdR3E4AINdhFf9diSfYfRhqzBMwDpjKmMplmftdO
         16LQ==
X-Gm-Message-State: AOJu0YwY7g+w2tWPgM9lu6BBtRZydtJ44nZG2IztT+9MTOjTaLu3B+rM
	VvZCzMObNz7pDJtBq3VNUaNV5U354aigFrMjMCs6inewXGMgczbTQaIQN6wXElfUBEK4zB3xZfS
	Gv03KGJpna0qANbbuMlHzPAGkrbwrc9oBzj5PVh4mJ6bwNc8ihFQ=
X-Google-Smtp-Source: AGHT+IFHms73/07zfjM06v8LOcFMGQ7jAJyFCxgJ3Qbb9Ax149HQWismtQu1UCuZE3lT08VusoOmwdItMLo1UbjWEqU=
X-Received: by 2002:a17:906:111a:b0:a31:6e92:6d2c with SMTP id
 h26-20020a170906111a00b00a316e926d2cmr5496556eja.59.1706873118666; Fri, 02
 Feb 2024 03:25:18 -0800 (PST)
MIME-Version: 1.0
From: Lorenz Bauer <lorenz.bauer@isovalent.com>
Date: Fri, 2 Feb 2024 11:25:07 +0000
Message-ID: <CAN+4W8jQeU70dRrEokYxomCBdM3cFmbxBe2mXnsTg4nijTJ3Sg@mail.gmail.com>
To: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Refactoring C preprocessor using cocci?
Reply-To: Lorenz Bauer <lorenz.bauer@isovalent.com>
X-Loop: cocci@inria.fr
X-Sequence: 1494
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/CAN%2B4W8jQeU70dRrEokYxomCBdM3cFmbxBe2mXnsTg4nijTJ3Sg%40mail.gmail.com>

Hi,

I work on a codebase which has a fair amount of preprocessor usage
(https://github.com/cilium/cilium). I'm trying to figure out whether
we could use coccinelle to automate refactoring of said code. For
example:

#ifdef ENABLE_IPV4
static __always_inline bool identity_from_ipcache_ok(void)
{
    return SECCTX_FROM_IPCACHE == SECCTX_FROM_IPCACHE_OK;
}
#endif

Here I'd like to strip the ifdef and add an attribute __maybe_unused
to the function definition.

A more complicated example:

void foo() {
#ifdef ENABLE_SRV6
    if (!from_host) {
        if (is_srv6_packet(ip6) && srv6_lookup_sid(&ip6->daddr)) {
            /* This packet is destined to an SID so we need to decapsulate it
             * and forward it.
             */
            ep_tail_call(ctx, CILIUM_CALL_SRV6_DECAP);
            return DROP_MISSED_TAIL_CALL;
        }
    }
#endif /* ENABLE_SRV6 */
}

Here I'd like to remove the ifdef and transform the wrapped "natural"
if to something like

    if (is_defined(ENABLE_SRV6) && !from_host) ...

Are such transformations possible with coccinelle?

A colleague has pointed me at --ifdef-to-if. From the description of
the flag it sounds like I wouldn't be able to distinguish a real if
from an ifdef?

Thanks for your work on coccinelle!
Lorenz
