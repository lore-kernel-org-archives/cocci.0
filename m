Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5AEC83F17
	for <cocci@archiver.kernel.org>; Sun, 13 Jul 2025 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0gfjopNtknnXXkv1IZZAkLxR2DP2wj+SmF4q8hDEN6Q=;
  b=a+G/8n+wzcT09DOH6uaP10uxYOHMDLsVK6BPCoOFfv0ldlJD73GuF1rx
   oIWWIIFF4dZGaZo/CupxlNRjEUFxmMqvmTXpYpVey3lvRIXlbAmXKiXev
   cCkVY7Dj6gbw+v4cP7xNtkllYCoQfoy3LIwm5veoSVOOeEv+JvXg9cy3v
   4=;
X-CSE-ConnectionGUID: sMZbgddJRwuJda3MLNU8gg==
X-CSE-MsgGUID: pg/DKaj/Rsq1p1Mb3+4Epg==
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.16,309,1744063200"; 
   d="scan'208,217";a="231512192"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jul 2025 22:40:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A4ADFE0CCF; Sun, 13 Jul 2025 22:40:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D4FABE007A
	for <cocci@sympa.inria.fr>; Sun, 13 Jul 2025 22:34:18 +0200 (CEST)
X-CSE-ConnectionGUID: 1KoNlKA4SJqGZ95NwR7znw==
X-CSE-MsgGUID: pG0ncKLvQgmxpF7Zzwh9NQ==
IronPort-SDR: 6874184a_y1c1mgDeIUonfVQmG4CIeKgb/yGhIwXGeFEMgEHY45dYDW/
 hikLhzGWhy8cas/2Cl6AmcT0BrVqLQ6datuhoWA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EkAABZF3RofCyAVdFaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkOBAAZUMwRUhFWIHIc0giSLRzKGcIRYeYQIgVWBQD0CDwEDAQsBA?=
 =?us-ascii?q?UoHBAEBAwSFAAKMAwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABASIZBw4SKYV7DYJiAYEkYQIFAzsBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAg0fXwEBAQIBEhEdARsdAQMBCwYFB?=
 =?us-ascii?q?AU5AgIiEQEFARwGARIigmABgiEBBhABAw4kAwQNBqAXgQVCiz6BFQUCFoEBg?=
 =?us-ascii?q?g0G2l8KGSgNbgOBYgIBBgkBCoE1AYR1KVyCVgEqgTMCDoQaIINCeieBY0WBP?=
 =?us-ascii?q?IMDPoJhAQGCDYMugmkEgiJEPhQdijqGFocoAQcHMQkJEwYIAgJIBRASAwQDB?=
 =?us-ascii?q?AQBAgsJCgkDAwIOAggDAggGGQE/DAYEFQgJDwwfCgIIBBEKKCIEDisKAyoxA?=
 =?us-ascii?q?xIFGwgGAgIEBAIEAgoCCQICBQMEAgQNAwQBAQgCAgMqBAMGGwkIAgsFFBYCD?=
 =?us-ascii?q?AQHBzIDEAEFCQ0BAQIEAgIfAgEDCAYBAQ0CAgECAgECAgQCBAYHBAgBAQIBA?=
 =?us-ascii?q?gIBAQEEAQcBAQICAwMFAwUIGQEVCRUDBAUCAhICAgEHAQIBAQMZAgEDAwQBC?=
 =?us-ascii?q?wIBAQQbBBUCFiQCGQIBBQUFAQMECxAJAwIFBAICBgIEDgIHAgIaBAICAQMEB?=
 =?us-ascii?q?gMBAggCAgcEBAYDAQICBxcCBBEBAgEDAgIJCgQFBAMEAwICAgEMAwECAwICA?=
 =?us-ascii?q?QIBAQMBBQYNEgIBAw8IBAICBwICIRkBAgEBBgYDAwMKAwEKAQEGAgECEgUCA?=
 =?us-ascii?q?gIEAQICBgQlAQIBAgEBAQUCAQIBAgQCBwIBAgsBBQIGAQICCQECAQICAgECA?=
 =?us-ascii?q?QECBgIBFQECAgICAgMBAwYCAgICAgIJAgICAgUCBQMCAwUCBQIDAwICAwQDC?=
 =?us-ascii?q?QMDCAMGBAIDAQEBAgECAgIBAgEFAgMJAQEDAgECAgICAwYCBQUBAwsMAQECA?=
 =?us-ascii?q?QMFAwMEAwYBBgcEAwIEAgICAgQCAQUDAwIFAQsBAgQCAQMDAwQEAwECAgoHB?=
 =?us-ascii?q?QIEAQEBAQIBAgIKAwIFAQMDAREDBAEGBQUGAgcJAwICAwIDAgQDCQQCBAMDA?=
 =?us-ascii?q?gICAQEKAgIBAgEBAwMHBhABAgICAQ8CAwMEAwQGAwUJAQMHAQEBAQECFAMCB?=
 =?us-ascii?q?AEEEQgCAQEeARUCBwEEAyceAgIGAgICAgMCAgMDAwECAQEDBQEDAgMCAQIBB?=
 =?us-ascii?q?gIDAwMFAwEJBQICAwEDAQUBBAQCBwECAgIOAQMCAgkCBwkEBAIBExMCAgICA?=
 =?us-ascii?q?QICAQIHAQECAwIFBQgCAQEBAgIDAgsCAgECAQICAwIDAgYBCQgGAQIBAQUEA?=
 =?us-ascii?q?wMHAgMkAwMEBQMCAgICBwIEAxkCDQYBBAMFAwUDCAMGAgIDDwMHBgcCBwQCB?=
 =?us-ascii?q?AICAg4CAwMHBQICAwEBDQQHAQEDAgISAwEBAQIPAgICDAEBBAEBAQEBAQEEA?=
 =?us-ascii?q?QEBHgoOAgcEBgIBAwEBCgIEAgIEAwIKAhUCCQMjDwIBFAgTPQwHLgQEDCoBC?=
 =?us-ascii?q?QsUBwYlgQAQkFhahAVaInmCMwEBAZYGjVmhMjsJAQYCYIFngQoVCi6MHpU9B?=
 =?us-ascii?q?lWXPBSTAi6HZZBzIo1lmwsCBAEBAQMHBxEkEoEyOoFccIFugUlPAxkPjiEMF?=
 =?us-ascii?q?oNevSNBNQsxAgcLAQEDCYZNhz+BSwEB?=
IronPort-PHdr: A9a23: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
 SgLfE+dVkRpx7yURU1hCA==
IronPort-Data: A9a23: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
 tvfgIZ9bmB6bAfZmAQ=
IronPort-HdrOrdr: A9a23:Gl4FD6Di7A+US7flHelF55DYdb4zR+YMi2TDGXoBLyC9E/bo6P
 xG+c5w6faaskd1ZJhNo6HlBEDEewKlyXcX2/hsAV7BZniehILAFugLhvqB/9SjIVyEygc079
 YCT0EUMqyLMbEVt7ec3CCIV/kn28eO662liKPzyH13XRh2Z6wI1WtEIzfePEkzagcuP/QE/V
 mnifavZQDMRZ3aVKWGL0hAZOTKqtDPmNbDbQQdDxAqrCmi5AnYlYIS2iL54isj
X-Talos-CUID: =?us-ascii?q?9a23=3Am6RW1WuCgcQED7gFC/VvMwWs6It8UXr7yFT5f3S?=
 =?us-ascii?q?aEElbGeCzVmXP6qV7xp8=3D?=
X-Talos-MUID: 9a23:5eEf6Qkg/eDdpfcw/s8ndnp6G59u6IeKFnkClIUelZa2JzNwahGk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,309,1744063200"; 
   d="scan'208,217";a="231512010"
X-MGA-submission: =?us-ascii?q?MDH0wNlHZ5Wep7RSgiTO4S6X4oTqaOG5nzolUh?=
 =?us-ascii?q?KXF8Gnxv1HGrM0g4acNS9xXcC16jdUHvXsxp6FGGHV34v8Ky4N+q1bnA?=
 =?us-ascii?q?S/au0EAttFtvj87GIqF4WrXWHRr+bVjyBDbqRN/tkxikbArUyqQZFiku?=
 =?us-ascii?q?bTaOPeHdke7KfZN8OjSyW5Mw=3D=3D?=
Received: from mail-wm1-f44.google.com ([209.85.128.44])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 22:34:18 +0200
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4561514c7f0so5180795e9.0;
        Sun, 13 Jul 2025 13:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752438858; x=1753043658; darn=inria.fr;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0gfjopNtknnXXkv1IZZAkLxR2DP2wj+SmF4q8hDEN6Q=;
        b=TE4Wb31Y8L0c1ovhgZfl8kZMV8QG+2r77cFSiL3gKNQ+XfUzX4p4F0QS+Ua4FxW54R
         gtg4BVXmXma/QxVJerTv1MqH9NldTk9vW49uWnc84Du0mymSjZTZ1lUxoi/trAZEzVMF
         VENZU7X7r0p6RR3NCg0vDItvz9Ao+4coQdNRsnnRi4LRHflGd/Is5fmEGTe3mdGRiUPx
         oIx9MUU/G7G71o9evRAKwYnSnGrGFmjUzk9Z4vlV5wVyJo2wsuTFWobYWXL3rEIFQAmP
         yCJ35MhRDVIn+89/fANR5OF+mXpIMvNxS+s1rhZQSgsavQ6nFjloAw0opttw6bnSfTrR
         lXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752438858; x=1753043658;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gfjopNtknnXXkv1IZZAkLxR2DP2wj+SmF4q8hDEN6Q=;
        b=r5CKikFIp5kEoacUo532Oy1fs3U6/N96lC1g24roCLW034VCRI9rSLgUE0se4c9FZi
         YXfapT1ts8ZDed3AU3kB6LUBMhBSUP24BfbyCjIXDJSE5AzKco1i65cVYwQWpHWRjLJ9
         Tid0flT50URhuKtL1Tnpr7PO0V12r849spMBH+s/ZDQDaQoD2BAhLcbQxijv4a4lyOpV
         A1fMHbu4wtc8THuByZkqwkgsix2FyW0KGKKLfqFlxZRMb4TFHCKhCOYA8ajvpbRkEgdG
         q0vEKbXpeBAUxU6U96iAeDDGY2Wvc1bz972zWgG38y4oKtI9ppyTi+PNjoTBPLiyielg
         ZjdA==
X-Forwarded-Encrypted: i=1; AJvYcCWumvsKENkDUFVuCHK35yPH4yyWq1d0lBERXXaL8Lu9uasIz5m9MdF2pqLB1fXPl1bFtdji9AyiP+HXOWB9kg==@inria.fr
X-Gm-Message-State: AOJu0YzOGKw4kh7mt62DSvo6XDh7pdIlstLOMHx6djOesRx3jzlMp931
	3Vx0PBdwxyLWFseej/pCjMVGobzzQ8Rsu97GyDTNl062b/Vtju4k8ljXpNpEPAph
X-Gm-Gg: ASbGncvZHLv+ZwxnGcnTftGsQTNA3hZidsWBmw39h9ug0YndVabEScwWOieA8XIn9hu
	+hDC2UZco06r8uF/1YZRqdz1GJWx49XQ1bD001i3QMaXlCgleJAwRtmk8WBAbC02+hz2w5cCqHr
	hCkes5S28ImL8fTcKKqhogF1zy3APX2q8nj81G3z6OIwz5vdxoTAtzJNN6fyTioppDg/ib78MpP
	7+Yoyfv5Vt6Fe/12KJ0sbDBAp9CAUjOBkQyRm4qPjbhvls46hb1iwH13PSqhsFm3hgvHsUwUJrt
	xx5w2cqNQ0C8fjr/dz9mkJESIr11h1wRO3bFSdT9+mQBYOOWqUDobAojO6ZkRr6JDOxb5GOpnig
	h1z1ODLO87qQlhzkGMWI1eNKt0HwtMIx0Qs9Wa11Th5gq3TYZfKlX2RhdYfRY29AnRA==
X-Google-Smtp-Source: AGHT+IHKj59aHYrSMjuDMWKesGBs7JS2jJ8Sox1d2vauHb7A7QS38oNENE80390dWBS3brzzCwXo0Q==
X-Received: by 2002:a05:600c:3145:b0:44a:b478:1387 with SMTP id 5b1f17b1804b1-454f4255ce8mr116485005e9.17.1752438857347;
        Sun, 13 Jul 2025 13:34:17 -0700 (PDT)
Received: from [192.168.0.12] (237.28.156.89.rev.sfr.net. [89.156.28.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-456030270f8sm56363355e9.22.2025.07.13.13.34.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jul 2025 13:34:17 -0700 (PDT)
Date: Sun, 13 Jul 2025 22:34:08 +0200
From: devnoname120 <devnoname120@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>, Victor Gambier
 <victor.gambier@inria.fr>
Cc: cocci@inria.fr
Message-ID: <36bd1f45-5b07-4e06-bd56-22b7cb8f3131@Spark>
In-Reply-To: <61ad6417-fead-48e3-806f-957f3714d697@inria.fr>
References: <7c65be39-dfc3-4b9c-9acd-dd94d1225db8@Spark>
 <alpine.DEB.2.22.394.2506291925100.95572@hadrien>
 <55f3b1f1-2537-4bc3-88d3-d7da1136060a@Spark>
 <alpine.DEB.2.22.394.2506292109470.95572@hadrien>
 <1a234d32-e87d-414b-8566-490618417f6c@Spark>
 <c08d6fa1-e53c-d21-7892-1132133087fb@inria.fr>
 <5d6b297d-2139-4732-acbd-92270ecfd4e7@Spark>
 <61ad6417-fead-48e3-806f-957f3714d697@inria.fr>
X-Readdle-Message-ID: 36bd1f45-5b07-4e06-bd56-22b7cb8f3131@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="68741845_25e45d32_2820"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [HELP] Using macro `randomized_struct_fields_end` as
 context?
Reply-To: devnoname120 <devnoname120@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2863
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/36bd1f45-5b07-4e06-bd56-22b7cb8f3131%40Spark>

--68741845_25e45d32_2820
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Did you build coccinelle manually, or is this straight from your
> distribution package manager? If it's the former, can you let me know
> what your local changes are (the "-dirty" part of the --version output
> seems to indicate you have some uncommitted changes, they may be
> relevant). If it's the latter, could you tell me which one?

I'm running macOS Sequoia 15.5 (24F74) and I installed `spatch` using `brew install coccinelle`. I just reinstalled it to be sure, and I confirm that the `-dirty` suffix is still shown.

You can see the source of the package here:
https://github.com/Homebrew/homebrew-core/blob/7672fe8cd2689390ba6a1fb675b91d342ecb3d2a/Formula/c/coccinelle.rb

If I go to `/opt/homebrew/Cellar/coccinelle/1.3.0` and run `git status` it shows the following:

> On branch stable
> nothing to commit, working tree clean

If I use OrbStack to spin up an Ubuntu VM, run `apt install coccinelle`, then I can run the same spatch command without issues.

Thanks,
Paul
On Jul 7, 2025 at 12:15 +0200, Victor Gambier <victor.gambier@inria.fr>, wrote:

> Did you build coccinelle manually, or is this straight from your distribution package manager? If it's the former, can you let me know what your local changes are (the "-dirty" part of the --version output seems to indicate you have some uncommitted changes, they may be relevant). If it's the latter, could you tell me which one?

--68741845_25e45d32_2820
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<blockquote style=3D=22margin: 5px 5px; padding-left: 10px; border-left-w=
idth: thin; border-left-style: solid; border-left-color: =231abc9c;=22>
<div><span>Did you build coccinelle manually, or is this straight from yo=
ur&=23160;</span><br />
<span>distribution package manager=3F If it's the former, can you let me =
know&=23160;</span><br />
<span>what your local changes are (the =22-dirty=22 part of the --version=
 output&=23160;</span><br />
<span>seems to indicate you have some uncommitted changes, they may be&=23=
160;</span><br />
<span>relevant). If it's the latter, could you tell me which one=3F</span=
></div>
</blockquote>
<div>&=23160;</div>
<div><span>I'm running macOS Sequoia 15.5 (24=4674) and I installed =60sp=
atch=60 using =60brew install coccinelle=60. I just reinstalled it to be =
sure, and I confirm that the =60-dirty=60 suffix is still shown.</span></=
div>
<div>&=23160;</div>
<div><span>You can see the source of the package here:</span></div>
<div><a href=3D=22https://github.com/Homebrew/homebrew-core/blob/7672fe8c=
d2689390ba6a1fb675b91d342ecb3d2a/=46ormula/c/coccinelle.rb=22>https://git=
hub.com/Homebrew/homebrew-core/blob/7672fe8cd2689390ba6a1fb675b91d342ecb3=
d2a/=46ormula/c/coccinelle.rb</a></div>
<div>&=23160;</div>
<div><span>If I go to =60/opt/homebrew/Cellar/coccinelle/1.3.0=60 and run=
 =60git status=60 it shows the following:</span></div>
<div>&=23160;</div>
<blockquote style=3D=22margin: 5px 5px; padding-left: 10px; border-left-w=
idth: thin; border-left-style: solid; border-left-color: =231abc9c;=22>
<div><span>On branch stable</span><br />
<span>nothing to commit, working tree clean</span></div>
</blockquote>
<div>&=23160;</div>
<div><span>If I use OrbStack to spin up an Ubuntu VM, run =60apt install =
coccinelle=60, then I can run the same spatch command without issues.</sp=
an></div>
<div>&=23160;</div>
<div><span>Thanks,</span></div>
<div><span>Paul</span></div>
</div>
<div name=3D=22messageReplySection=22>
<div>On Jul 7, 2025 at 12:15 +0200, Victor Gambier &lt;<a href=3D=22mailt=
o:victor.gambier=40inria.fr=22>victor.gambier=40inria.fr</a>&gt;, wrote:<=
br />
&=23160;</div>
<blockquote style=3D=22margin: 5px 5px; padding-left: 10px; border-left-w=
idth: thin; border-left-style: solid; border-left-color: =231abc9c;=22>
<div>Did you build coccinelle manually, or is this straight from your dis=
tribution package manager=3F If it's the former, can you let me know what=
 your local changes are (the =22-dirty=22 part of the --version output se=
ems to indicate you have some uncommitted changes, they may be relevant).=
 If it's the latter, could you tell me which one=3F</div>
</blockquote>
</div>
</body>
</html>

--68741845_25e45d32_2820--

