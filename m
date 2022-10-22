Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBB7C433FE
	for <cocci@archiver.kernel.org>; Sat, 22 Oct 2022 12:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5zCYLHs88IO5GzVzSMqtkq4qf8GcIlBxD70dCYz8s00=;
  b=J792Zsc8Q27KDropu+zpwgOGYkK36UHhG1n0h5iM6JYdtJ8P2mfw9GFo
   q60ep4p8CC2NzYdKI1hbyQAUR/cpTXDydEQDKV8boaNmS60AHp6yYIl5i
   XFfuKXRXDgrHavIwdS6Jlb+CM/ZCb5WVo0oDXcDvNBifq0poHgVg0jJCw
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.95,205,1661810400"; 
   d="scan'208";a="67868858"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Oct 2022 14:10:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 91FA2E013D; Sat, 22 Oct 2022 14:10:00 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E7557E004E
	for <cocci@sympa.inria.fr>; Sat, 22 Oct 2022 14:09:58 +0200 (CEST)
IronPort-SDR: 6353dd96_zvGeoLvt/DvEGbDKNxF/aDpFle7S2kPPwEyUpEGEpl9gjDi
 Q0gQ/5cyig7Gt+q6NDb40URqRPtGn4nd3Y0t3TQ==
X-IPAS-Result: =?us-ascii?q?A0A0EQCs3FNjfzbdVdFaHAEBASsLBgEBBAQBAQIBAQcBA?=
 =?us-ascii?q?RWBTwKCK4EBA1MuBFCETpEXA4xIkFaBfA8BAwEMARQBASMLBAEBhQUChHECH?=
 =?us-ascii?q?QcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBARgJGQcOD?=
 =?us-ascii?q?gUkhWgNgjUpg2UBAQEDEhEdARsdAQMMBgULDQICJgICIxEBBQEcBjWCXIJsA?=
 =?us-ascii?q?QMwAwQMnh6BBEKLMoEVBQIWgQGCCQaBQQEVQUqBbQoZKA1oA4FaAgEGCQEIf?=
 =?us-ascii?q?ywBiF6HAnonHIFJRIQPMD6CYgSBXhWDQoJmBJU9AQMFFA8DAwIhAxkrHQIJA?=
 =?us-ascii?q?yMPAwsJCBMXKAYDAQEMB0YEHB8DAQEPJAEBAgICAwQHAgEDBgMMAgIBAQEFB?=
 =?us-ascii?q?g0DAgMIARIDAgEDBQICBAECBAoIAQICAQIEBQcCAQgGBQ0FCQsBAQIBAwcEA?=
 =?us-ascii?q?xECBQMFBQMDAgEJAQUCAwECAQEDBgQEAQECAwICAQYCAgEBAwMEAwECBgICB?=
 =?us-ascii?q?wIDAgEEAgMDAQEBAgICAgICAwMJAggHBQEGAQIBBAMCAgECBwEEAQgDAwUFC?=
 =?us-ascii?q?Q8DBQMBAwMCFAoFAQMIBggCBAUCBQMCBAIDAgIIAwIEAwsDBQQCBxMHAgMCA?=
 =?us-ascii?q?gUCAgICAgUEAwECAgICAgIFAgMCAQUBAgIBAgICBAECAgcEAgMBAwQOBAMCA?=
 =?us-ascii?q?gcBAgIBBgIHAwECAQQDAQEEAgQBAgUCBAEDBgIEAwoCAgMCAgIGBQMDCggCA?=
 =?us-ascii?q?wUCBAEBAgcEAgILAQYCBwICAxABAwEEBQUDAwMJAgIDAgQCAgoBAQEBAgIBB?=
 =?us-ascii?q?wIEBw8CAgIEAgICAQMCAgEBAgIKEgEBAgMGBAYFAwIIGAEGAgEBAgIDAwIGA?=
 =?us-ascii?q?gECCAIEAQQFAgECAgICBAEDBgIDAQECAQICAwMCAQQCBAMDAQIBAgICAwICA?=
 =?us-ascii?q?gMCAgEPAgYGAQICAgICAgICAgEFAQIBAgQCBwIEAwIBAgIFAgICAwEBBgIEC?=
 =?us-ascii?q?wEDAgcGAQMCBwUCAwEEAwQDAwUGBQwIAQUBAwEeAwICCAIHAgEGBQEPAwICA?=
 =?us-ascii?q?wICAQQKAgMFAgQCAQQJBwIEAQIJAwIGAgcFGAECAgcEDAoCAgIFBgIEAQEBA?=
 =?us-ascii?q?QMBAgEBAgMEAgMCBAUBBQIBAgUEAgIBAQIFAgwBAgEHBgIHAgICAgMBBAIBA?=
 =?us-ascii?q?gEDAwIDAQEBAwYGBQQEAgMDBgICAgYCAgMCEgMGAgYDAgQBDQ8FBAUIAQIBA?=
 =?us-ascii?q?QcCBAIHCQ4CAQYBBQICAwICAQQBAgEGAwECAgICBQgFAwQFAwkMAwEBBAMCA?=
 =?us-ascii?q?QIBBAMCAwcDAgQEAwECAwQGBgEJAwICBgMCAgINAwQCAgECAQIDBAQGAgICA?=
 =?us-ascii?q?QICAgIDBAICAQEDAwMCAgIDBAIDAwsGCggCAgIDAgEFCwQCAwIBAwYJAgQCA?=
 =?us-ascii?q?gYBAgQCAgICAgICAwEBAwoEAgECAwICBgMGAgECAQIBCQUCAQkDAQIBAgEEA?=
 =?us-ascii?q?QMGBAECAgQJAgMHBQQGBAICAgIIAgIOAwMCAQEEAgIEBQICCwIBAgcCBQEBA?=
 =?us-ascii?q?wUHAgIBAgIBBAMBCQQBAgIDAgEBAwMRAwMDAQQCAgUDAw0JBgICAQMCAwENA?=
 =?us-ascii?q?wMBAgECAwEFBRcDAgEIBwMTAwIBAQMCAQICAwYEAQgCAgMDAwIBAgUCBAMDA?=
 =?us-ascii?q?QUCAQEDAQUDAg4DAgMDAwIGAQIBAQIDAgMBDAQFAQEBARYDAQIDAgQCAgEBA?=
 =?us-ascii?q?ggBBAMBAQIBAgMCAg4GAQQFlmGCEWhZBR02QHsBNgTBAIE1Y4MJi0WVAjKWa?=
 =?us-ascii?q?hSSE5chimyCVYIPkmqFEQIKBwYQIxKBLwM1gVtNIxVsgjZOAxkPhxyKdoUUh?=
 =?us-ascii?q?Uw/NDsCBgEKAQEDCYpVAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:2QU5LK3zgj55V5WkIyb1oAqjBJEkLtp133Aq2lEZdPWaSL3+qy
 nIpoVg6faUskdrZJhEo7q90ca7MBXhHPJOkOws1PKZLXDbUQiTXf1fBOnZsl7d8kTFn4Y3tZ
 uIMZIOcOEYZWIasS+Q2njbLz9P+qjizEnlv5ai856vd21XgmNbgjuRxjz1LqS+fmd7OaY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,205,1661810400"; 
   d="scan'208";a="67868848"
X-MGA-submission: =?us-ascii?q?MDHhDAB1ViyQSQ9yh2M1MWTpLsrhrpjUBmiFGs?=
 =?us-ascii?q?SFYaXgCpd889fLdTGaoOwRQuYaZtWkPAzJlkRr7BIP0gi7zq03dETTop?=
 =?us-ascii?q?NqR9fMd+Ma/QnBuxQZLURx/LZ/RvTAwMqhtCysfvcSWnjbqGrbg/U5TG?=
 =?us-ascii?q?TEKULjWkkUNzY7SCTJMDLrog=3D=3D?=
Received: from mail-wr1-f54.google.com ([209.85.221.54])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 14:09:58 +0200
Received: by mail-wr1-f54.google.com with SMTP id w18so8743865wro.7;
        Sat, 22 Oct 2022 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5zCYLHs88IO5GzVzSMqtkq4qf8GcIlBxD70dCYz8s00=;
        b=iDD6twm+ZUdx2bGaC2FkO6IVx2jahquou59jco2z/Ri6CTPP97jEzZ0uN/cQLshN7m
         Jo+E+3AL9oAXRkSOLDgnBXg0yNa1Kae2stg+P4aypLH2RZdlaSSnr1V6XYyxq6sCT9Ia
         rTXb8rYKz8Y/PANJl0AaZWo1QP+KT80/U4ukxmKLiH3SGD4JssTFO78GUrjh+8oeGDnk
         +BuijvI7nm06TQFiFZxzRgCGunZvG0b3vvGI6FYLYh7mBJaLoWm3VtK4gG/zm0zJhlHg
         gre6CmcH+HJR3VRE5Bn7znTNRyMaHxsbOwb2/Su6rDueKvJzv9X8FTXaD5yiKd5BBMDB
         QpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zCYLHs88IO5GzVzSMqtkq4qf8GcIlBxD70dCYz8s00=;
        b=rGGfJFFq0tyA4vo3Z6S7TxEnvJ5zmJ+vSG8fkvWk/TL5dYW5D+gMLCaMyx/jpQkVcF
         nNyQ1HJL8UzcI3hx13AwMHnHJOHO/hLk0pzWfRgwIxYu83r5C7gVV8xymlkMe+XQvLTH
         uiGvikO3MMyAuJB39lpTHpIFaf/DcIpwobwkqbmcTe8fJDPoS8T9pDpQxFrq1EOaNd69
         KdYWeCp8TDzb0DgOkK3V6/vyEci0shKBCIob/NvU7Pgf5M/t2MiXy0iSWv5ja/OzSAwy
         IydTPAMz/tScftgajlNM87nikR2WBTk5GJoSxlVClKeOdWnowTsjdKG9bEfoKIo8KVtE
         zz0A==
X-Gm-Message-State: ACrzQf0T3q3FtNwm7HSh/lMG+fgx/OgFjniLKErGM2MrZ9AHaGxobkKM
	x7kpxeiwzFQBN8L3sVqUWuhIkRIfXWM=
X-Google-Smtp-Source: AMsMyM4BllHAl19V3K1Z1bYAfpPPJ7mCAy7zqLhLQ4yT/xEgkGPFdTMuwEFfaudkZxrXbZRZN6DZEQ==
X-Received: by 2002:adf:dd0f:0:b0:236:2f7f:4cce with SMTP id a15-20020adfdd0f000000b002362f7f4ccemr8160657wrm.347.1666440598057;
        Sat, 22 Oct 2022 05:09:58 -0700 (PDT)
Received: from [192.168.1.191] (ip-89-177-205-85.bb.vodafone.cz. [89.177.205.85])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d4a4a000000b00236492b3315sm5927278wrs.104.2022.10.22.05.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 05:09:57 -0700 (PDT)
Message-ID: <eb2be587f68870a1394fef6cedb15d142a26a29a.camel@gmail.com>
From: Jan Tojnar <jtojnar@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Date: Sat, 22 Oct 2022 14:09:56 +0200
In-Reply-To: <alpine.DEB.2.22.394.2209052231030.3611@hadrien>
References: <alpine.DEB.2.22.394.2209050952300.2731@hadrien>
	 <20220905090915.3569051-1-jtojnar@gmail.com>
	 <alpine.DEB.2.22.394.2209051246490.2731@hadrien>
	 <CAFGSp1ud+X_xHa4zwhwPEzOvoC+4zwmONLi5HCQn76WHzfwoHQ@mail.gmail.com>
	 <alpine.DEB.2.22.394.2209051427090.2731@hadrien>
	 <CAFGSp1umoczUe4npSesAUOLgSq=9VkvLUOV3x1hSvSajqQkGfw@mail.gmail.com>
	 <alpine.DEB.2.22.394.2209051445570.2731@hadrien>
	 <CAFGSp1vuGyiT86c7vq9MmYWaP06vRLo4OLQTREpHK_fw8vfEyg@mail.gmail.com>
	 <alpine.DEB.2.22.394.2209052150160.3611@hadrien>
	 <CAFGSp1vDA7DBgmtQeYu255M_e9zQYCPVAryL15OikEz+Rf1qyQ@mail.gmail.com>
	 <alpine.DEB.2.22.394.2209052231030.3611@hadrien>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
Subject: Re: [cocci] [PATCH v2] Exit with non-zero status when spatch on a
 directory fails
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 666
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/eb2be587f68870a1394fef6cedb15d142a26a29a.camel%40gmail.com>

On Mon, 2022-09-05 at 22:35 +0200, Julia Lawall wrote:
> Not so clear what the impact of this is.=C2=A0 I prefer tabs to be used
> when possible.

I very much prefer tabs myself but the choice of tabs vs spaces is not
important. As long as they are used consistently. Unfortunately, that
is not currently the case, which leads to various issues:

Most importantly, when a developer edits a code with mixed indentation,
they will almost certainly adjust the indentation in one direction or
another. This means that the patches will include extra changes
unrelaated to the main contribution, making them more difficult to
review and retrospectively analyze.

Additionally, different contributors may have different visual tab
widths, which can cause indentation to =E2=80=9Cjump=E2=80=9D making it har=
der to grasp
the code nesting. Editors often allow to adjust this but users
would need to do it in their text editor, Git client, e-mail client
and maybe even GitLab. For example, the following image is what I saw=20
when I reviewed the patch earlier from this thread in my Git client:

https://imgur.com/VeM6jbN
(I highlighted the actual nesting of the syntax tree with red arrows.)

And that assumes all contributors use the same visual tab width.
If that is not the case, the nesting will be mangled no matter
how the developer viewing the code sets the width in their editor.

----

It looks like the original codebase used two spaces for indentation (as
seems to be the convention for OCaml [1]) but later, tabs started to
creep in.

[1]: https://ocaml.org/docs/guidelines#using-tab-stops
Though, their argument against tabs is as fallacious as always.
Their only valid point actually argues against mixed indentation,
which could just as well be used to deny using spaces for indentation.

Cheers,

Jan
