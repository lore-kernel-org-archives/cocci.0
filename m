Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B38D2ED0F
	for <cocci@archiver.kernel.org>; Tue, 20 Jan 2026 10:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=l7blaIOjeaBAr4Ivp7n+vluOPX0aHr7KFgsKHjuq5Ek=;
  b=IGK3q+zd6Cd7+tsIzIHowRCpzeqotA9BammfBtDt2BIj4zpSRP2BwEBk
   M/08j2+29c5+D+Ymm5Jszr39eyTMcsglR7Y/aAj22XR9RMCTO8JCJn+gD
   ngCZBA2ZxNPtCJJvfpOaq9Im9q1y/FQWfWh2ktdtCakKtQO4Uii+K7vtY
   8=;
X-CSE-ConnectionGUID: +uUHkAVJTIuA+W31KXENcA==
X-CSE-MsgGUID: pHghYzsKTSCvzwPwneNZIg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259430380"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2026 11:48:36 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id EB36C83A05; Tue, 20 Jan 2026 11:48:35 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id AE12D81A43
	for <cocci@sympa.inria.fr>; Mon,  5 Jan 2026 15:49:40 +0100 (CET)
X-CSE-ConnectionGUID: 9Ed6/qBhQB+CSzxxJ5qBFA==
X-CSE-MsgGUID: jxlOSD9WRRKtquUX8U6o4w==
IronPort-SDR: 695bcf84_o/aOld1Gt/DO77vpd87RhHFeCu1ljyxPYoekMce1kHBLY93
 17XM3kBn4dQSOwP60hC7zZqUwrsWGQ0pSeCykTw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HmAgDPzltpfKvQVdFagQmEEYFmMwRUhFiIe4ZYgiScR?=
 =?us-ascii?q?YNSAg8BAwEMAVEEAQEDBIUAAoxpAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QENAQEFAQEBAgEBAgQGAQIQAQEiGQcOEimGTw2CYgGBJIEmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBHQINfgEBAQMSER0BATcBDwsLDQICJgICIRIBBQEcBhMihQMBBkoDpF+BB?=
 =?us-ascii?q?UKLPoEygQGCDAEBBtwogWYJCQELAYEJLog4GwEFbnyDfwGDfnonG4INgRU1g?=
 =?us-ascii?q?XNRMT6IHoJpgRKBFIEOhh2LR4FthiYmCR0DBwcODR5GDwUcA1ksAVUTFwsHB?=
 =?us-ascii?q?V5FQwECAYEFI0sFLR2BIyEdFxNgVECDSRgHaA4GgREZSQICAgUCQDqBaAYcB?=
 =?us-ascii?q?hwSAgMBAgI6VQuBdgICBIEuY3uCAQ+HNwGBAAUugRQiAj0DC2ILPTcUG0yVH?=
 =?us-ascii?q?oQNgnSxT5UXhCaEcJ0CM4QEk06TGZkGglihETmEdAIKBwcRJIFbI4FcMxoIK?=
 =?us-ascii?q?AhsBoIwTwMZD5c0vGxCNTwCBwsBAQMJhkiLVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:tiEeZK+pyHySG1kDysFuk+DlI+orL9Y04lQ7vn2ZESYlFvBw5P
 re+8jztCWE8Ar5PUtKpTnuAtjjfZqxz/FICOoqTMyftWvdyQ6VxehZhOOJrlHd8kbFl9K1oJ
 0QEJSWf+eRMbEVt6jHCUKDYrAdKZG8gdmVuds=
X-Talos-CUID: =?us-ascii?q?9a23=3AdXFkFGvkICYb8G3HGG+Lb38R6It0X3GDi276I3a?=
 =?us-ascii?q?SSk1SWq2FawKJ0o1Nxp8=3D?=
X-Talos-MUID: 9a23:Es2wlwTX+806lWd6RXTulDVFD+s53J6UK1wUjKg26/TaMnBvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,203,1763420400"; 
   d="scan'208";a="257026975"
X-MGA-submission: =?us-ascii?q?MDGyQRIuX3I0AcZLi7e4ZAQWuR/lHFMnYkC09h?=
 =?us-ascii?q?brmaNURrZ/Crxt/pgrzhZaR3bth8YQnJncS1xRVUdyidJMA1lekzpy84?=
 =?us-ascii?q?kZTUNg6BvE6YrMryPFWgOdK19wedryJ/uCn/zOP1pU9CSReANBhywpFQ?=
 =?us-ascii?q?D+VTnbsQwM0ONZj5eITOW38A=3D=3D?=
Received: from mail-lj1-f171.google.com ([209.85.208.171])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 15:49:40 +0100
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37e6dd536b0so135547871fa.2
        for <cocci@inria.fr>; Mon, 05 Jan 2026 06:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767624579; x=1768229379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7blaIOjeaBAr4Ivp7n+vluOPX0aHr7KFgsKHjuq5Ek=;
        b=p/Wtidkn/oZfFoaejh01jniagts8D1DInpQJXvlCO+kSWVI/fkTWIp6rwv62KqA/D4
         k2iTBKCRDE2iHBuTV7/rgDFD00HOZKqJ9Plv9Wf3/wPgQbdIFq1QtuiT73cn9RKXsOiS
         /z7ywk5dcRmrO5DpyGVXtPiFivWprLo7aMA4lnIQEC2yuf7fn63zb/5pfCddC+Loy9qQ
         Nio0w6TWBWl7YLSH3pDeavLN9b6D7/B6pnoYyP8X8qxLyO8rMC5sPRhi9LP0vTNhH+yN
         kCOYj6Gedwgv25MqOAmwH839++xeVbFc2qn7+QqPf7Ugc4jlMbUNZcuD0rosFvwg9l8z
         Rvfg==
X-Forwarded-Encrypted: i=1; AJvYcCWGHtfl6DOpkAqQN5jEDuYg6rqRTgQlY4pEI8Rub0KrStmUXe+k8bqxVsKuzAVDadO41ncrxg==@inria.fr
X-Gm-Message-State: AOJu0YzulQ96sSj2yY2msAFLil84CbLNYT0xsKmKLOw8KFQD75UMiLrP
	6vVFV3ZKVCU3dGvxAzvZc3rxyIUlQbBoca16DFb9d9gySLPwuwqb9nqSnfI+GMsm0dHuv+Dhyyf
	TUN4=
X-Gm-Gg: AY/fxX4LGuqav8TMQV3gR2Gbh7VXy8FcFlRB8Zy3envAIWaaneDUmmh1o01QEt8eI2d
	PN48jzgpWtxvdyfM8UcPL+im0nGDe7Og2jFNrV+TYxMkkxUPgxN67Wm6shIA9YHGIfPJj/H1tta
	CxJxIEuiU/N4FU58NQsUqm6P5dlNiVeiPUgd5sLRu8Agh0oAC3DjaV0Y2md2Xbfsz6FqYJs66Js
	ab0iNr0Uw1Kr3MmqHjBoGc7GDPBd2W2OpCWzmMnXjZcrn5NsMLuxF/ttCFEf36PtbG15oaLIZI9
	TLRIo1mZQxjOjNqZOav8HZxodn0EphbT9KeMRxn4HoJk763JEG+sYBhNK+4PWm5mInfB8JRsElm
	JGOI3kTAmcO+wIfk+pOTc0cqj5PLuu+CuCBj0U7II2eSB+PS5bb/UkPtswtKVuBlOKEhZHdREBq
	vyvgIpmmBp0aDYz9+4Af3BpFCbpikVTJuoAZs8Of5RzJpLm0tj66Gq
X-Google-Smtp-Source: AGHT+IEs6ppkXW2JnzWVp+5OkI9qkl3YlasTbJIjN+2kDKB+i4iUkr7ZMxYnzDEcm848Ke9Xb658RQ==
X-Received: by 2002:a05:651c:19a1:b0:36c:3b69:2cc7 with SMTP id 38308e7fff4ca-3812130f5e2mr142761941fa.0.1767624579024;
        Mon, 05 Jan 2026 06:49:39 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38122501558sm133635441fa.13.2026.01.05.06.49.37
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 06:49:38 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37ba5af5951so131254301fa.1
        for <cocci@inria.fr>; Mon, 05 Jan 2026 06:49:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+QOkb28za7swuhUcg2o5Iuf9kwGXBiitynyI6ZDqd466SM/vlEFKFDkfwVEZpvjBM7GiJHg==@inria.fr
X-Received: by 2002:a05:651c:b12:b0:37d:1911:7a45 with SMTP id
 38308e7fff4ca-3812169d85emr133285091fa.42.1767624577175; Mon, 05 Jan 2026
 06:49:37 -0800 (PST)
MIME-Version: 1.0
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
 <98a94966-14c6-45c4-99d8-471f65b292ea@web.de> <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
 <fdc397c4-8823-46c3-b471-382ebb483900@web.de> <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com>
 <66215b0-f6e-2cef-4022-4dd148fa2790@inria.fr> <CANiDSCvsBCrpwOFbwf93ighoMm+ca=jpHs6NAp9AHaEJj9neRg@mail.gmail.com>
 <1c92f6ab-9992-1f5-d911-f8cd52991c66@inria.fr> <CANiDSCvXUxdTxXZ9r3SvoVTnChkg1nRN7uAva8nHb6CTFt67KQ@mail.gmail.com>
 <5123b7fe-b5f6-4446-a792-b5d19873c181@inria.fr> <5c5a00f7-8955-483a-9efc-d003972c7a12@web.de>
 <CANiDSCvvO7+qtRUi6NyrKzdKZaSrKNgSUgnnJfOw7HYHHc8nvw@mail.gmail.com> <f5449c2-3ce0-1d89-4b74-c288ca2efe58@inria.fr>
In-Reply-To: <f5449c2-3ce0-1d89-4b74-c288ca2efe58@inria.fr>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 5 Jan 2026 15:49:24 +0100
X-Gmail-Original-Message-ID: <CANiDSCuWETFziv+DWSCHQVXTPg=wWVmj3zFaXWCydVz-0sYfHg@mail.gmail.com>
X-Gm-Features: AQt7F2rzu_tGsqzk5C-ccCvaQ4ICrchZUcKTjrhqF0NnLVa_dYGBus3L-ifuJH4
Message-ID: <CANiDSCuWETFziv+DWSCHQVXTPg=wWVmj3zFaXWCydVz-0sYfHg@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 3280
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/4LLhGwcgproAQzniWQMiNA>

Hi Julia



On Sun, 4 Jan 2026 at 22:29, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Tue, 16 Dec 2025, Ricardo Ribalda wrote:
>
> > Hi Laura
> >
> > Has there been any progress on this?
> >
> > I am stuck with an old Debian version in our CI and I would like to
> > update to debian stable.
>
> Hello,
>
> I made some improvements to the minmax semantic patch that made it go 4x
> faster on my test machine.  Maybe it will help.
>

Thanks for the file. Testing with 6.19-rc4.

You should be easily be able to repro with docker/podman. If you need
help reproducing, let me know

With bookworm and old minmax.cocci (baseline)
real    3m37.891s
user    77m19.816s
sys     2m12.033s

With trixie and old minmax.cocci
eal    9m8.442s
user    195m42.341s
sys     5m53.336s

With trixie and new minmax.cocci
real    8m19.803s
user    165m8.025s
sys     5m52.308s
With these extra warnings:
warning: rmaxif: metavariable func not used in the - or context code
warning: errcode: metavariable func not used in the - or context code
warning: rmin: metavariable func not used in the - or context code
warning: rminif: metavariable func not used in the - or context code
warning: rmaxif: metavariable func not used in the - or context code
warning: errcode: metavariable func not used in the - or context code
warning: rmin: metavariable func not used in the - or context code
warning: rminif: metavariable func not used in the - or context code
warning: rmaxif: metavariable func not used in the - or context code
warning: errcode: metavariable func not used in the - or context code
warning: rmin: metavariable func not used in the - or context code
warning: rminif: metavariable func not used in the - or context code

It is definitely better, but it is still ~2.4 times slower

Best regards!




-- 
Ricardo Ribalda
