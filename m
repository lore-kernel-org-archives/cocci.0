Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E11C433FE
	for <cocci@archiver.kernel.org>; Thu, 20 Oct 2022 05:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hgAWqUzazXjS3lmAN/UdFIaj0dxGzDouzHwo9p4jIFM=;
  b=MmMIkrLW/T02L5u/6wlfbBUHzFBPRU8bTVKDx6lagtWxuI6rJplQS/Un
   nCCyOrQRvWKkuRsTiAV0O9YCuqAfjXZ+x2zQs+dzk122A1eIMkN1w7MDH
   zQqOuKRiBAPstgunY+wSMcZaZ7QRFhtOnb8G3znNj75/PY5DPA9d2lesA
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@zx2c4.com
X-IronPort-AV: E=Sophos;i="5.95,198,1661810400"; 
   d="scan'208";a="66067909"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Oct 2022 07:02:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7D8B4E0152; Thu, 20 Oct 2022 07:02:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 30D09E004E
	for <cocci@sympa.inria.fr>; Thu, 20 Oct 2022 06:56:32 +0200 (CEST)
IronPort-SDR: 6350d4ff_zsfEorAWeg3dbfZ6VC4MY7JI8CXQeTCKFbYvgIMf4gHPz0u
 gAskg7Dc/mHaBAKCrCMdQimQVEIPX61psLT58kA==
X-IPAS-Result: =?us-ascii?q?A0AuCgDA01BjkNlUsotaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?VGBQwIBAQFjgVcuBAtFhE6IfoV0oU4BAwENFDAEAQGJeAIdBwEERwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEBAQEWCR4QDgUihWgNgjUih?=
 =?us-ascii?q?BUdAQE4JQ8CJgIkEwWDM4MhAwOsVYEygQGCCAEBBoZtfgmBESoDAQEBAYhXg?=
 =?us-ascii?q?zaDSIEhgimBS4hDgwqCZpUpCgMEBgU4AQIBQx1AAwtqAw1kIFgOCSAcKA0FB?=
 =?us-ascii?q?hMDIG8FQg8oL2krHBsHOFQqKBUDBAQDAgYTAyICDSkxFAQpEw8tByNxCQIDI?=
 =?us-ascii?q?moDAwQoLAMJQAclJDwHWD8DAhAiPAYDCQMCIlaBJA4YBQMNFyUIBTcbBAg8A?=
 =?us-ascii?q?gUGUxICChEDEg8tSA5KPjkWBid6Dw4WA5oNpjKfBwcDg2KDTZx1MoNkkwSSJ?=
 =?us-ascii?q?5cap3SCHC2BLnCBAQaCME4cD5ISin0iNDsCBgsBAQMJik0BAQ?=
IronPort-PHdr: A9a23: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
 ICnqQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gY2TKauUhvhcKqAsPXm3bzW27skDUtV00zEX/kB9WHVpm6yj+v
 xG/c5rriMc7Qx8ZJhOo6HlBEDtewK4yXcX2/hyAV7BZniBhILAFugLhuGMrQEIcBeOj9K1u5
 0QC5SWy+eQMXFKyej/6Am8V/A6wNeG96iswcPT1W1kQw0vS4wI1XYfNu9WKC1LrcB9dPkEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,198,1661810400"; 
   d="scan'208";a="31917853"
X-MGA-submission: =?us-ascii?q?MDH6IOxQkdMvRV+QXMOSm4VLEqez1nHlDSswi5?=
 =?us-ascii?q?8X7giP7k34rf7X3JfjZaVXE99/VKDEfq8Tpn0WGUag17VpjIpdsr3MWq?=
 =?us-ascii?q?ggsycXLnKLt2+J+KvEu4qmh5W+Pvinmp1aNZeyZ0EYg93oVJzZcF7H4O?=
 =?us-ascii?q?HZ5aYB9b/VIh5DItM2wp+ZdA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 06:56:32 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 61D566131F
	for <cocci@inria.fr>; Thu, 20 Oct 2022 04:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81877C433C1
	for <cocci@inria.fr>; Thu, 20 Oct 2022 04:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1666241787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=hgAWqUzazXjS3lmAN/UdFIaj0dxGzDouzHwo9p4jIFM=;
	b=od3TY1NcsVSfve86mAR+Xb6BzvkBxtbP/EXM66R3wjLwiLmi1nL4gFhveEi2NC74KiqVBD
	my5cEnyKKEZXJlLNjMSj5HicIN+7Vs/h1lQbONC9yDxVbNTPrHcpX5PWTlpwPc5bg3ZonF
	DQcCyytBgYmdUCXymZ3o4tKht/V07Lw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8f9b54b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <cocci@inria.fr>;
	Thu, 20 Oct 2022 04:56:26 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id d187so19631743vsd.6
        for <cocci@inria.fr>; Wed, 19 Oct 2022 21:56:26 -0700 (PDT)
X-Gm-Message-State: ACrzQf1jvcFRR1VkV27z8sb+MWbl8gsvbf2zq8rNwFcJZTZkbcXOVhji
	9WZh1asR0O7xMha9foRWJGtng36NWMWbo7uDhNw=
X-Google-Smtp-Source: AMsMyM4QSZiNDy79CRMnHQtbd9+cXul6DsmKki7X5A7WCrqiWzWTjwhTHG78IFUYI3gYnlLzVPaek1cEajuoo/x/Dg8=
X-Received: by 2002:a67:ed9a:0:b0:3a7:718a:7321 with SMTP id
 d26-20020a67ed9a000000b003a7718a7321mr4696324vsp.55.1666241786009; Wed, 19
 Oct 2022 21:56:26 -0700 (PDT)
MIME-Version: 1.0
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 19 Oct 2022 22:56:15 -0600
X-Gmail-Original-Message-ID: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
Message-ID: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
To: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] "not supported"
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 656
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/CAHmME9rTWvUxsM-sFZh1r%2BD5gb-8rbHmeWiFEfobkjxDRrZO1Q%40mail.gmail.com>

Hi,

I'm trying to generically replace constructions that look like this:

@@
expression E;
type T;
identifier I;
@@
  {
-   T I;
-   do {
-     I = get_random_u32();
-   } while (I > E);
-   return I;
+   return get_random_u32_below(E + 1);
  }

But trying to run it results in "not supported". Any idea what's up?

Also, it'd be nice if there was a way for Coccinelle to figure out
variants of that, such as I >= E in a succinct way, and maybe other
different loop constructions that amount to the same thing.

Is there any way to express what I'm after?

Thanks,
Jason
