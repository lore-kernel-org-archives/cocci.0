Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56EAC54E67
	for <cocci@archiver.kernel.org>; Thu, 28 Mar 2024 08:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PNNdcuo8eY3igQ+HimEvQtjjBUf+p64TCpzb72MWuPM=;
  b=hFGDO0qyhkH0dYnBsB6NG6ovCtiqemLasL6WR93sDoYzdt9FxnvsYA+F
   eMfO/uUbeOTS7eYYC72UtGmp93hq11jpL663tew5DCu++uLrOeJjVZIk7
   qlDA8KKB6xpinSAIY6yd7VjZ5SD+pd55arkAVxINZHKZ4TRUCR1AnHrG+
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.07,161,1708383600"; 
   d="scan'208";a="158860743"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2024 09:41:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 90C13E02E4; Thu, 28 Mar 2024 09:41:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8E3C8E0131
	for <cocci@sympa.inria.fr>; Thu, 28 Mar 2024 09:41:31 +0100 (CET)
IronPort-SDR: 66052d3b_TW5Om8HZt4lA3BV4Fs7ZsZCzOlOCQOrUx1En4y15OzV0nlf
 1wCAs3ciQZQC3HD06I7z99VPSOP7nwdjDf07zNA==
X-IPAS-Result: =?us-ascii?q?A0HIBAAILAVmfzLQVdFagQmBT4I5gVEzBAtIhFaPRYM4i?=
 =?us-ascii?q?mCHTopGFIEsPg8BAwENRAQBAQMEjQYCHgcBBDIHDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEIAQEFAQEBAgEBAgQGAQIQAQEiGQcODimFbQ2CYIEmYQIFAzsBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAix1ER0BGx4DEhAPAiYCI?=
 =?us-ascii?q?wERAQUBV4UJAQMxA6JTgiGBBUKLO4EVBQIWgQGCCwavXQoZKA1sA4FeAgcUg?=
 =?us-ascii?q?QYuhGAlgwUdAYFWh2KBIYFkRIEVNYI9CAEvhEeBB4MOgmgEhUmDY5UnhwUmC?=
 =?us-ascii?q?AEGFwMHBwcEBQQcBgUFAkMJCAUKEgMEAwQGAQIFAwUTAgIEEAUCAQEVARoBC?=
 =?us-ascii?q?wQKAgcBAhUDAQEBCAEDBA8BAgMDAQEBAQUCAgECCQICAwUEBAEMAwMCCQEEA?=
 =?us-ascii?q?QMEAQsCAQMEAgICAgECAgMCAgYCAwIEAQMDAwMBAgEDAQEKAwMCCAMDBQECA?=
 =?us-ascii?q?wICAgQCAgICAgMGBAUCAQIDAgYGAwEDAgUCAwUBAQQIBgEDAgMCBwsCAQYCA?=
 =?us-ascii?q?gEEAhMBBAEBAgMFAgIGAwMDAgMCAgYFCAMCAQECAQQDAQIBARcCAgwHAwEFA?=
 =?us-ascii?q?gIDAwcBBAEBAwcBAwMCAg4CCgUFAgcDAhwCAgIPAQIBAgEDCwMHAgIBAhACA?=
 =?us-ascii?q?gECCgcDBQUBBQEEAgECBgEIAgISBQYGAQEEAgsDAgEBAgICCwIFBQMDBAIPB?=
 =?us-ascii?q?wUCAQIEAgEBAxAIBwEPBgIDBAICBQIBAgsEEgIQAQQCAgIFAQUCAQECAwUGA?=
 =?us-ascii?q?gEDCAICBgMHAQIFBwUHAQcEAgwCCQEBAQIBAgMDAgMEAgEDAwQRAQwDGwIBA?=
 =?us-ascii?q?gQLAQEFBAIGAgMIAwMaAwgDAgECAwEFAQIBBAUEBwMCAwMDAwMDAwgEAQoDA?=
 =?us-ascii?q?wMBBAEHAwoBAg8LBgECCAUIEAQBBAICBAcCAwQDAwICAgMDEgEDAwMCAQMBA?=
 =?us-ascii?q?gUCDwYHAiQDAgICBwMEBQICAggCAwIEAwINAwIDAQUDDAUBBgQCAgQKAwIBB?=
 =?us-ascii?q?QMXCQQCCREGAgINAgwGBQEEAwIBAwMDAgQCAgMBAgICAgIDAQIKAgEHAgUDB?=
 =?us-ascii?q?QICAwIBAQEBAgIEAwEOBwIDBQUCAQUJAwMCAgQDAQICAwICAgMBBAUUAwQCB?=
 =?us-ascii?q?QoDCAICBwIOAwEFAgEBAgICAgEBAgIDCAISBAIBAgMCAggCAgcBAQIKCQMBA?=
 =?us-ascii?q?QQEBAMGAgIFBA0DCAUBAQICBAEKAgkPBQICAwMCAwEBAQIKAwkBBQICAQMCA?=
 =?us-ascii?q?gQEBwEGAwUDAwQEAgMDAgwBBQEFAQUBBQQCBgEUAhQCAgsFBgMGDgMLBAQBA?=
 =?us-ascii?q?gIFBAYMCQQCAgIGAQIRAwECAQcBAwMCCgEEAQILCAEFCAIMBAIBBAIDBhACC?=
 =?us-ascii?q?AUGBQICAQECAgIBCAYPAwYHAgMCBgMFBQMDAgICBwQEAgECAgIBEwYEBAIDA?=
 =?us-ascii?q?gMEAQUEBAMCFwgNAgUHAQkLCAwBBAYCBAIEBwMIBQUEAgMEBBEHCwMCAwQCA?=
 =?us-ascii?q?gYDEQIDBAIKAgQEBwIDAQQNBgQECgILAwcBAQIFAwMJBwYCAwMFBAMGAgUDA?=
 =?us-ascii?q?wMCAwINAgICAQkBAQECFAIDDgIEAgECBQUMBBMCAgMCBggCAgIHAwMEAgMGC?=
 =?us-ascii?q?wIBEAMCAgICBQMEAgIUAwkEAgQGAgQBBgMDAgQGBQoEAgIFAgEBAgoCAQ8KB?=
 =?us-ascii?q?AMEAwUDBwkCBQUDAgQCAgcJAQECAgIDAwMDAgMCAgMDAgcDAwMHAwUDBAIDB?=
 =?us-ascii?q?gUHAwUFAwICAhQBBgIFCgYDBwYLBQUHAgYCBAgDBQICAwMDAwIGCggDAwMCA?=
 =?us-ascii?q?QYCAgMDAQIIAw8GAgIDBQYDAwMDBggDAwIGAwMCAwIDAgMDAQMCAwICAwICA?=
 =?us-ascii?q?ggCAgMCBQQFAgIDBAIIGgICAgIDAwgDAwoEAgIEAQQCBAIEAgYDBAMCAQcCB?=
 =?us-ascii?q?QMCAwIHAgIEAgICAgMCAgYIAgIDAwMCAgIBCQIFAQEGAgQDAgMFAwkDBAUCA?=
 =?us-ascii?q?wgBAQICBwcDAwQDAQIBBQQCAgYFAgMCAgQEBAUDAgMCBgYCAQMCCgYDBQMDA?=
 =?us-ascii?q?wMCAwMCAwMCBQIIAgIEBAUEAgcEAgQDAwMBCgIGAwICBQEBAgIFAwIEBAcCA?=
 =?us-ascii?q?gIHDwMCBwUCBQcCCAEGBQICAwIIAQICBgEGAgQBAgINAQECAgIDBAMDBwIEA?=
 =?us-ascii?q?wIIAgMDEQEDAwkGBQQFBAMJBA8CBAEIAwEBBAgCBAMCDAICIQIFCwQEARIKC?=
 =?us-ascii?q?AMBAQMBAQICAgICDgMCAwICAwoCAwIKAwYEAgIGAQEBBAYBBAIBAgkEDgkFC?=
 =?us-ascii?q?AgBAwIBCgECEgUPAgkDAwYEAhAGCgUDAgMFAQIFFQMIAwIJAgQMAw0CAwMCB?=
 =?us-ascii?q?gMGAgYBBgMHCwEBCQgFAwMDAhYBAgIQCAYGDwcCAwMEBA8DEgIGDgMDAgMCA?=
 =?us-ascii?q?QICAgMFBAUCBwMDDQUCAgcDAggFAwcJBAoCCAUBAgYDAgICAgUNAQEBAQIDA?=
 =?us-ascii?q?gUDBwkICAQFBAMBAQYGDCgCAgMEEAMJAwYLAQUFAQMCAgIOAwUDAgMGBgEQB?=
 =?us-ascii?q?AEFBAkCBQcGBQIBBQECAUMdAgkDIw8DCwkIEz0BCwcyBDQBFBQHJwEGIQpWq?=
 =?us-ascii?q?EoWlQqdcZUBB4QWBaE+M6owmGKochEjEoE2AjGBXDMaI1AxgjZPAxkPjiwWg?=
 =?us-ascii?q?1ijPkUyOwIHCwEBAwmJIoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Tp/v2K1nT+knRuK5PbXcJQqjBL8kLtp133Aq2lEZdPU1SL3+qy
 nKpp4mPHDP+VUssR0b+exoW5PgfZq/z+8W3WB5B97LNzUO01HYSb2Kg7GSpwEI2BeTygee78
 pdmmRFZ+EYxGIVsfrH
X-Talos-CUID: 9a23:Ta+aumyWDDYC5RYW7W1GBgUeQu87WHLb4E2XOlGAAl9oV+TFcXifrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AHr5q1wwjSjEX9GI4keYMhaYkPoaaqIuiEFgxn5Q?=
 =?us-ascii?q?bh+anO3cpIRqflxCQG6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,161,1708383600"; 
   d="scan'208";a="158860734"
X-MGA-submission: =?us-ascii?q?MDEiSulYlmuDFL6qy8YTzqtCnRBtkJhPcI00hW?=
 =?us-ascii?q?sffFtF+qxEt51+48GoHor82tn28htKr1NLbQKnvwZPQ+R+aqymihsImz?=
 =?us-ascii?q?AE6IuNvFFYPrHT7hMajjiOGMHqbkXVOmD6TgvzWOlBv7asTigA5bAjRj?=
 =?us-ascii?q?HCfcgiI5x3blRYrb+Etn/VsQ=3D=3D?=
Received: from mail-ed1-f50.google.com ([209.85.208.50])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:41:30 +0100
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56c36c67deaso778276a12.0
        for <cocci@inria.fr>; Thu, 28 Mar 2024 01:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711615290; x=1712220090; darn=inria.fr;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PNNdcuo8eY3igQ+HimEvQtjjBUf+p64TCpzb72MWuPM=;
        b=d0TXndnTXCfXl98boy3ET580vSR5FP5hDqVefMdtSmrs94MTkdnXXLs6+Oqdvv9/Rb
         IldIMY49cZ3JWqECrYp1red+O8bp56Yf8UI17d4GBImBQ9FKhFGSY/fONw5T08jvvJ02
         YPljsV30UM3P+Msu0hDS1R5bjNp1/yLuIumy6UgpdcYoBzyONjBVT4/WJ1G0F258xk6T
         EncejcvTHZXsoWMX2qUJ2BhtnbktfBedAAuA3aZ6sgR9yVi05Uj/AMfWQPmhvcfGuWrk
         Jt4GBl6b2I4qfLSerMWp/HSZ9dOPqrZrFYUoL9KxuXGVGyDmChhmHA4Yw+re0E3jWDFX
         9GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711615290; x=1712220090;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNNdcuo8eY3igQ+HimEvQtjjBUf+p64TCpzb72MWuPM=;
        b=H2/1IBwKQ4BLt8cqL66PDG/tWmrtV58B5AoBxfFKLI8AQyp5TEoH+ut1OsADwPY0ls
         PegxSyIniUUBs1JOu/ndpypS48UEHze0b/XX9J06+wgGvTqTL+KlvARLzBoFARNCQpks
         lx1wBc7HGq2c28M1PEYB2e8x1hO3FSzYk4HhQ1Dpay/XiMQeM1sTXZbKY6UoTj6klnm8
         tg7EEbLIjZcwkSlPYSZhz9dpeM9sAUzgYCK67e80nOqP+c4KOG7FQhNjhDhmJflsgXbA
         a9JCL8SDcoaHefL4QUBGCtsXC6Uxv7RHWCvsNSA5yg1Dhk7WzkOe4RIODI1Kfp71qnRL
         F6Jg==
X-Gm-Message-State: AOJu0Yx64RcfVPEjzNRYqkfJ6aYs+nGy4xtavTkZ/N5NuYDncEEdWEP2
	i8OD8/HXZBfJNeMKas9D0oscoWbB9JYt7SV/TJ3VNWwyaDpefCYpZkGfuxhddIwwxliNYZYVelz
	xgkbPusl6hWbumD7mRRq51+6rW5rcVNka9rs=
X-Google-Smtp-Source: AGHT+IF1lrWKR2W/XYEX4p7oUf1gtsq62I/jEudLGU5BazOsKCT9af3N7KUwaq/1aTybpk9XjuTiBoKHmyHBlefqK28=
X-Received: by 2002:a17:906:1984:b0:a46:e8c1:11ac with SMTP id
 g4-20020a170906198400b00a46e8c111acmr1134734ejd.18.1711615289857; Thu, 28 Mar
 2024 01:41:29 -0700 (PDT)
MIME-Version: 1.0
From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Thu, 28 Mar 2024 09:41:18 +0100
Message-ID: <CA+MoWDqtRxQQ08k53_bP6L96FReUx8AxV2BU7dHWC-hfEr_kow@mail.gmail.com>
To: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Subject: [cocci] Returning statically allocated nested structs
Reply-To: Peter Senna Tschudin <peter.senna@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1623
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/CA%2BMoWDqtRxQQ08k53_bP6L96FReUx8AxV2BU7dHWC-hfEr_kow%40mail.gmail.com>

Dear list,

I am trying to come up with a semantic patch to detect uses of nested
structs, more specifically:
 - the nested struct is statically allocated
 - the statically allocated nested struct is returned by a function.

Here is an example:

struct inner {

    /* some inner struct stuff*/

} inner;

struct outer  {

    /* some outer struct stuff*/

    struct inner i; // The kind of nesting I care about
    struct inner is[SOME_MAGIC_NUMBER]; // The kind of nesting I care about too

    struct inner *ip; // Nah, this is boring. I don't care about boring
} outer;

void sillyfu() {
    struct outer ou = { }; // initialization does not matter.
    struct outer *oup = NULL; // Nah, this is boring. I don't care about boring

    /* some serious silly stuff */

    return ou;
}

I remember that there are some details for detecting structs
effectively, and as I am investigating a code base with over 1.2M
lines of code, I would like to ask for pointers of where to start.

Thank you!

Peter

-- 
                         Peter
