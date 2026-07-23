Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605CAC53213
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ECPS5j1qCPcwB0YlL4FTJ27ue7WhDH56E/Wn/MeLYUc=;
  b=lW/cwTA5xAuw6aP/APKnRjchA1I+MTdHWUb3A7xBX/SzQwqQ/S5eIOYO
   a/MBfThkuGZT0Kumip0OcDY5mlMJm4MHif6c4hAu77z3Kyc4tGKM/EGre
   DyeY7CBe5UPgBdimhiFgIWfVwKdwxftVICn4lkLuDVFT+IW+wfLYpTf42
   k=;
X-CSE-ConnectionGUID: uL4MtJ9sTEK35J4Vj/BeKg==
X-CSE-MsgGUID: KDhLpFxURDmYmAomExqfmg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287733528"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:13 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id F080D803EC; Fri, 24 Jul 2026 10:54:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1472481964
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:42 +0200 (CEST)
X-CSE-ConnectionGUID: B3Bs0yl/RZuzKhilJFbXEA==
X-CSE-MsgGUID: VDJ3ammKSLOPoemXctLZZw==
IronPort-SDR: 6a626191_jLvuBN4FYpjV//H8zfzr3f09yxnZmG0BP3vknprIVZTsWrY
 YmenODLB4YPVzqRxRB8U6vLOUbYAfc3nTfSjHdw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HEBABZYGJqfDLYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKSIoE/PQIPAQMBCwEBTwIEAQEBAgSEfgKNYAIeBwEEMAkOAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQAQQBA?=
 =?us-ascii?q?YIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEFAixfAgEDEhULAQ0BGx0BAwwGEDsgAhEBBQEcBgESIoJggiMBBhABAzcCA?=
 =?us-ascii?q?bZXgQJCjDwWBQIWgQGCDQbaaAoZKA11gWMBAgIHCQEKAQGBNwGEdypdA4I6h?=
 =?us-ascii?q?SN1hAJ6J4EYgRCEfoIfgjmGMASDLpIqAQcHHxIIARwGCAICSBUSAwQDBAQBA?=
 =?us-ascii?q?gsTCQMDAg4CCAMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiEgIpCgMqCxIPA?=
 =?us-ascii?q?w0GBRUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItAwEDGQgJCAILBREYD?=
 =?us-ascii?q?AsFAgonAw8BCQMfAxQbCEUIBhYBGgcFBgs3FQUMEQECGwIhBB0RCAMBGAQEA?=
 =?us-ascii?q?gELAwEDARUECAkEDAIQChIVAw4DBw8CDQcuCwMCDgIJCAwXAgICBgIDAwMKA?=
 =?us-ascii?q?QIBAQEBAQEBCAMDAwIDGQcGAwQEAQQEAwMCAwUBAwMDBQICCgYJAQEBAQMCA?=
 =?us-ascii?q?ggDBwMKCQIFAxsDHAYBAgIDAgECAwYDBwgDDQMEAgMDAwQBAgIBAQECAwEDA?=
 =?us-ascii?q?wQDAQMDAgEDBwICAwMDCwECAwMDBQMFAQUDBQICAwUFAwUCAgoCAwMDAgEDA?=
 =?us-ascii?q?hwDCAMGAxIBEAMDBgEDBwMHAgQDCAQDBgIDCAMDAgkIAxYGAwMDAwUBAgICA?=
 =?us-ascii?q?wUDAwMICAQDAwQCAgMMAgYDAwMCAwMFAwMHAgQCAwYDAwMBAwMFAQIHAgMHA?=
 =?us-ascii?q?gELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEAgIPBAQFAwMHAQECAQIIBQYDA?=
 =?us-ascii?q?gIRBQgKBQYCAgIdAyEBAw8GAQkFAgEFDgcFAgIKEgMGAgMEBQUBAwEKAQsBA?=
 =?us-ascii?q?QIDAwUFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEAwIDBwMDAwMDBAMFBQMCB?=
 =?us-ascii?q?QIEAwUDBwIDAwIBBQoBBAUECgEDAwMDBQUDAgIDAwQBAgQGAwQCAwECCAQGB?=
 =?us-ascii?q?QMDAwUCAwMCAgIDAwUBBQIDAwMEAwMDCAcFAwMFAgkDAwkDAwsCAgMhAgUDA?=
 =?us-ascii?q?wMDBgMHAwMEAwMDBwcCAwIDBwMCBQIHBQMDBQMGAQMCAQMDCAsYAwsJCAcMA?=
 =?us-ascii?q?TwMBwokBAQMKgEGDhQFBCUZZwcHAo1oI4JAAYEOgiiBUQEBAZIakjSgIUkeC?=
 =?us-ascii?q?QEGAmCBZ4EKFQovm1+FfBozl1OTGZMrhV0jkXCSR4Q+AgoHBxEkEoEyOoFcM?=
 =?us-ascii?q?xojgQFtgUlQAxkPji0Wg2DMFTU1PgEHAgcPAoFzg3aJKoEggStJgUwBAQ?=
IronPort-PHdr: A9a23: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
 Zz16nwdg0Rsa9k6IaGWL61MnAA4uw==
IronPort-Data: A9a23:e6A8zqI8C5oljUMkFE+RJJElxSXFcZb7ZxGr2PjKsXjdYENShjwHm
 GAXDG2DOvbZZmH9eox+bo3k8EMBuZ7SyNVgGwForCE8RH9jl5b5CIXCJC8cHQvCd5yZFBoPA
 +Y2M4SbcphsFhcwgj/3b9ANeFEljfngqoLUUbCCYmYtA1c9Fk/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSss9JOGjt8B5mr9lU14ZwehBtC5gZgPa8R5weO/5UoJMt3yZ+ZfyOQrrZ8RbbSq
 9brlNmR4m7f9hExPdKp+p6TWlEKWLPbIT+VgXNQXaW46jAazsDl+vtT2FI0MC+7uh3R9zxD4
 IwlWa+YEG/FCpbxdNE1D3G0JQkuZPwcoOevzU+X6qR/x2WeG5flLm4H4EseZeX08c4uaY1CG
 GBxxJngoXlvisrvqI9XRNWAiewJd+PwZJIb/UtS0CP6DfciY77Jc4jjsIowMDcY3qiiHN7bb
 ssdLCJtNVHOPkUJNVAQB5Yz2uyvgxETcRUC8APT9fdxuTGNilEpuFTuGIK9ltiiSMZbkFvC/
 jqerjTRDRQTNdjZwj2Amp6prrWfwn2lBtNNTtVU8NZUrH/Iz2kWKyYycmO8rPyJgVKaaeBAf
 hl8Fi0G9vVrrBP6ELERRSaQq3mPtR80QMtVC+R86QeXy6OS7RzxO4QfZjtIadhjrM1vADJ3j
 hmGmNTmATEpu7qQIZ6AyluKhRnpEzNNPGtFXx0ZXygF4t3BjosDozuaG76PD5WJYsvJ9SYcK
 g1mQQA7jrQXyNYJjuC1oAiBjDWrqZzECAUy4207v15JDCsgPNbNi2+AswCzARN8wGCxEAPpU
 J8sxZD20Qz2JcvR/BFhuc1UdF1T2xp6DNEsqQUyRsF+pmrFF4+LcodX7zVzbEZvOYBsRAIFl
 HT74FsLjLcKZCXCRfYuP+qZVZ52pYC+To+Nfq6PPrJzjm1ZLlPvENdGPxPIhziFfYlFuf1XB
 Kp3hu71VCtDWfQ5kWvuLwrfuJdyrh0DKarobciT53yaPXC2PhZ5kJ9caAbePNMqpriJuhvU+
 Nt5Ps6HgUcXGu7nbyWdtcZZIVkWJDJpTdr7uu5GRN6lewBGIWAGD+OO4LUDf4c+ob9ZuN2V9
 V6AW2hZ6mHFu1v5FSuwZEpeNYzfBaREkSpjPAgHH0qZ5Hw4UIP+sIYdb8QWeJckxsxCzNl1b
 f0MIfeFDshuVRHr0mk6QLP7prNMbB6A2ACEZXKkRBMdfJdQYRPD1fG5Xwno9QgIVjGWs+lnq
 ZKe9wrre7gxbCU8M9T3MdWE0AmXr3sGveBDT2/kB8Z1Rh330Y5ILyfRsKcGE/sUI0+e+grAh
 hekPxgIgMLs/aon+8btroKZpd6LF+BeIBJrL1PD5+zrCRiAr3uR+q4eYuOmZjuHaXjV/p+lb
 uBrz/3RFv0LsVJJkohkGYZQ0qMMyIrzloBe0zhbMi3HX3azBpNkB0u2781Fm6lO571e4C+de
 EaE/PtEMrSoZuLhNnMsJzQeU+fS7sFMxwHu7sk0Ln7quw5x3r6MCntJMze21SdyEbpSMaEe+
 9kHhvI40QKEpyQPDsenlQFRrmSFEWwBWf4ot7YcG47atTAowVBjP73ZUy//346TYPpLIm0VE
 2axr/fEje4NwEDtTmcCTynR/OtChKYhvAJB408CKm+oxPvEpK4T9z9A/QsnSj96yk187NtyH
 WxwJWhZFL6r/Qo0tPNcXmupJR5NNCeZ9mP11VENsm/TFGusaUDgM0w/Pryr0H0C0mcBYAVew
 q6U+FzlXRnuYsv1+Ck4Amxhiv77SO1O5h/wo9+mE+uFDqsFT2Lc2IH2XlUxqjzjHc8Vr2/Er
 7Mz/O9PNIvKBRRJqKg/U4SnxbAcTS6fH1N7QNZjwbgoGF/NczTjyBmMLEGMIvl2HcLoynPhK
 cJSJZNobS+chQKutTEQAJAeL4BkxMAJ4MUwQZK1BGoknYbGkB9XnsPxzAbcilUvYe1SqucmC
 4aIdzu9Am2a3nRVvGnWrfh7AGmzYPhaRQjCxtKwwrwsFbsclc1vLXgd3qeFgHGOFA5B4Rivn
 RjiYpXOxLdI0rVcnIrLE4d/NjrpL/fOVOCCqly8iNFwc9nOE5bqnCEEpmb3Oz95OeMqZO12s
 rCWofjL01jjvr1rd0z4wby6CLtsyfu+eMF1I/DHBiBWsgXaUfC9/iZZ3X6zLKJ4te905+6lY
 lCdQ9Sxf9tEYOVt7iRZRAYGGilMFpmtSLnroB68iPG+ChI99wjjB/H//F/LaVBrTAM5C6fcO
 CTV5cn3vst5qb5SDiAqH/tlWp90AGHyUJscKuHei2OqMXmKsHij5J3ZihsS2RPaACKlEeH7w
 67/aDrQSRCQgJzMnfZl69FcnxtOAHhE1Lx6OgpX/tNtkDm1AVIXNelXY91MFphQlTe0z53iI
 i3EaGw5EyjmQDBYalPG7c/+WhuETPk7UjsjyufFI2vPA8t3OG+BPFel3iJp4nMzYjm6ie/6c
 ZcR/Xr/OhX3yZZsLQrWCjpXns8/rs42BFpRkaw+ryA2KxkbCLQOkndmGWKhkATZRtrVmhyjy
 XcdHAh5rYLSdaI1Ocllcn9RXhoeuVsDCtnugTinmL7ihmlQ8AGMJDAT9Q0+Pn3vofnm/IIze
 E4=
IronPort-HdrOrdr: A9a23:dRWGPq68IpB5pGgqwAPXwNvXdLJyesId70hD6qkRc202TiX8ra
 uTdZsgpHvJYVoqOU3I+urwW5VoP0mskKKdiLN5Vd3OYOCBgguVxepZgrcKrQeNJ8SHzIBg6Z
 s=
X-Talos-CUID: =?us-ascii?q?9a23=3A08bBUmnbpu2pUixP4Ep4uDWhIzTXOVeG5myIMkv?=
 =?us-ascii?q?/M1R0Wp6VSFuy1qlUvuM7zg=3D=3D?=
X-Talos-MUID: 9a23:n76tLgU4zuQ98j/q/AHApmprMcJL2ICJMEcAlKUNp+22BzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287666972"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGKkVa+4CsE3a2V05p1ob2WZUVckgAoa6JArn?=
 =?us-ascii?q?FeSEjR6kFtpDfJMhOSp+HH36XrA+rrjvghcyWj4Ks4igPV6idY0+O4OM?=
 =?us-ascii?q?g6uDE24MK/Q4cD4Jey+cdEgOwU0YjfMYBDej68zYpt3tag86ujOOjNRx?=
 =?us-ascii?q?NnzVxK0Loq3GLDh41jtuMDbQ=3D=3D?=
Received: from mail-pj1-f50.google.com ([209.85.216.50])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:41 +0200
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so820056a91.0
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832400; x=1785437200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECPS5j1qCPcwB0YlL4FTJ27ue7WhDH56E/Wn/MeLYUc=;
        b=SxLCUKrfhGHqwk+VxygHl+2Y0lMI98s1z9qzHyJM9pkwoTutoyrs+t6O0AgGLbuHdH
         AIT1QRTVzHCY9WkzdEB0MTZC3zFgbAee4HHydMjA1WgB5tpeWLT2hIn+aFk/6HKhCfdF
         w8aBvDxENENor4OmSEsaEz1VYeHR1d5xt6CiapqJwCTou2SBdUkEDE8Y7b5BSq4ZjPZm
         saf9kUg+fHeCGZ4Y3Epl5ukKJVXLMika4FIGG3+gDQ8Flx/uvAKeixuFMlfZZJQC4GEX
         x59wDqmWZHGMtG/TMtHOOu1WxcKfOXkZJq2C+vMiyQEszJOAc42+uGvoyu5R0/lxUyHd
         p6TA==
X-Gm-Message-State: AOJu0YxS61JOl/oBq2BdYBfBc5abL3iFLEIm6iBHyAUInckZ5/SJZeuU
	XCbsTptjuPdirk/8VTIA0eWxnsUINYtYd06Bgl4Tx2peTZi03X4g/4Bz
X-Gm-Gg: AR+sD11vnVTfbFrQiXAVFfABogLsfWR42rXxUB/TzdPV4AjhmmAb7JxhkeEL9oxkCi2
	xk2Oe6SRmKoEfSdpz6NDYZLO4X6bLiV0zEbLpraIffsYJ0elJu/0DyTCaUxfPO8nxXREkCdLKdi
	HKt800qsfdIrOmoDyOFuHegybKraHwfkRJtXdkZ5A4vQXedYYl8aPzisk2nc35lR70wSkRvb8nU
	YoKRPpQ+eQ9eTBuZEzN7NQJe0Rs6YoMfwSdagGgy6+GjiV5N2wd6BNtBH0h6PfVF/olsE1dhZ/y
	6WIPPtmnH42j4cW0rmxefvAsZy6J83VaFF3eaEW63tRk1jGAf1MwXm2o4lTcxzlwjdObTN9ayGs
	CgA+f2AF40RxiQFNRv9L63LgX7cUf1k1RsyYO3xApgGzEc39Ahgl/ClCKE94BbnDAThhvXNgU
X-Received: by 2002:a17:90b:5588:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-38ec6281ddemr4252308a91.0.1784832399932;
        Thu, 23 Jul 2026 11:46:39 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:39 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Jonathan Cameron <jic23@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: cocci@inria.fr,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 24 Jul 2026 03:45:17 +0900
Message-ID: <20260723184538.3888637-16-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 15/36] iio: remove conditional return with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3612
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/e99cgJ_FQoX-Jna9pSlUiw>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/iio/light/isl29028.c      |  6 +-----
 drivers/iio/light/tsl2583.c       | 14 +++-----------
 drivers/iio/magnetometer/ak8974.c |  6 +-----
 3 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index b88e7c4eae3e..ea38d797082b 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -405,11 +405,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
-	ret = isl29028_set_pm_runtime_busy(chip, false);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return isl29028_set_pm_runtime_busy(chip, false);
 }
 
 static int isl29028_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index a0dd122af2cf..a38a0130d854 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -456,12 +456,8 @@ static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
 
 	usleep_range(3000, 3500);
 
-	ret = tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_ON |
-					    TSL2583_CNTL_ADC_ENBL);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return tsl2583_set_power_state(chip,
+				       TSL2583_CNTL_PWR_ON | TSL2583_CNTL_ADC_ENBL);
 }
 
 /* Sysfs Interface Functions */
@@ -790,11 +786,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 		return ret;
 	}
 
-	ret = tsl2583_set_pm_runtime_busy(chip, false);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return tsl2583_set_pm_runtime_busy(chip, false);
 }
 
 static const struct iio_info tsl2583_info = {
diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index c7fdb7c2f543..c988d0e40cea 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -379,11 +379,7 @@ static int ak8974_getresult(struct ak8974 *ak8974, __le16 *result)
 		return -ERANGE;
 	}
 
-	ret = regmap_bulk_read(ak8974->map, AK8974_DATA_X, result, 6);
-	if (ret)
-		return ret;
-
-	return ret;
+	return regmap_bulk_read(ak8974->map, AK8974_DATA_X, result, 6);
 }
 
 static irqreturn_t ak8974_drdy_irq(int irq, void *d)
-- 
2.43.0

