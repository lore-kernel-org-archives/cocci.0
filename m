Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29724C19F28
	for <cocci@archiver.kernel.org>; Wed,  3 Aug 2022 05:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ffAJdfn+j4CavVTPqg8mCGkqCSyPBfbEDYXH0r+IJmY=;
  b=OnmJ7n4vZnRmPOfIlHOkiOAmccSwynXJ6QhA2z4ZI4fdaIn+48h9qbDp
   F2nM4eW7gJ6oV9hrMClheZ/6v7ZZUw7nvgzpcZGKI3spyiIjgXD4DF4aI
   RmVLT7f+sTar5Qc81ZqBbJp2mHygjHXSW5xj+s40hdkaZfqxmJk6UfxTo
   U=;
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
X-IronPort-AV: E=Sophos;i="5.93,213,1654552800"; 
   d="scan'208,217";a="47801210"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Aug 2022 07:55:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8BE06E0236; Wed,  3 Aug 2022 07:55:16 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3BBB8E0235
	for <cocci@sympa.inria.fr>; Wed,  3 Aug 2022 07:55:10 +0200 (CEST)
IronPort-SDR: v+FfSnIkLImTypHT6iJyoUQHkF7p1kcNt7XYu+INH98OIXqeZMoCiwrav3hOlt6SzRoVYGHjn0
 zM6ZBT3EYaZvTiQhjVlPXm8E42geGw40DxI+HXYKOe34E8C3UcuCtKimlajJyLrHrRvQPz9WiB
 KFhTTSgcHc5N8znBnIbd5o5C99r+IhC278mcbAGeUeQYRQOaqxtm0w8ZXQi9dngl6RLvFF3W+I
 4osbEUeh5yAF9g26eRbR4z8jrwqNNCOlIVRH+bfcvn+UViZrLqx1zBPmNMEHHVDGn7sw0ZKyDk
 RHqTYmteINtaFHVEboscUuqS
X-IPAS-Result: =?us-ascii?q?A0AqCQBsDepif6veVdFaHQEBPAEFBQECAQkBgWaBOgIBZ?=
 =?us-ascii?q?YFXLwQLRYROgSONQ41bgQaGGIopgXsLAQMBDRIBLwQBAYl+Ah0HAQRHAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBDQsJBwgKBw4OBWABYQMBR?=
 =?us-ascii?q?IFPgU8lCwMxDYI1IoNiIhEdARseAxIIAQIFNwIkAREBBQEtKoVAAQMyA5pPg?=
 =?us-ascii?q?h+BBEKLMoEVBReBAYIJBoROChkoDWcDgVkCBxKBKQMBAYYzAhpHTAEBh2OBZ?=
 =?us-ascii?q?USBS4JEAQGFfYMJgkMiBJdjBAcDBAUBBg4DAwIgAQIBRB4CCQMjEQMLEBEVG?=
 =?us-ascii?q?AQIAQQDAQEBDgIFBwIGAwMCAgICBQECCgIBAgQDBgYCAxABAgQBCgQCAwgCB?=
 =?us-ascii?q?wMCBgQKBAIHAgIEAQUDDQEDBQIDAQEDAwIEAQIBAQMIAQMCAwMCAgICBQIDA?=
 =?us-ascii?q?gICCQMEAQcDAgMBBAMBAgoEBAMEAgIHAgcCBAcCAQIGAwUGAQECAQcBAQQKB?=
 =?us-ascii?q?AMDAwMCBQICAwIGEgYGAgQBAwQCCgICCwIHAQECAQEBAQIDAgcFCwEBAQMCA?=
 =?us-ascii?q?wYFAgEBAwgGAgEEAQUDAQQFAwcCAQUGAgkDAwkDAQEFAQMBBgMDAwIHAwECD?=
 =?us-ascii?q?AQIAwMCAwQCAgICAQMCBwUIBAIJAgICAQICBgIBAxoBAgMFAgIJCwEEAgIDA?=
 =?us-ascii?q?QMBAQIIBAkEAgMEAgEBAwIBAgIBBQIOBgEBAQECAwMBAgMBBgcCCAIcCgEDA?=
 =?us-ascii?q?wMCAgUCAgECAwICDAEBBAIBAgECBgEDAQICAwEDAQICAwIGCQIEAQUDAwICA?=
 =?us-ascii?q?wEBBQ8FAgQCAQIGBQIBAQEEAQMEBAYCAgEDAwIOAgQBBAECAQEjAwQCAwEDF?=
 =?us-ascii?q?wECAQIDAwMEBgcFAgECEwECAQEBBQECAQEDBAQHCgMCAgQDAwUBAQIDAgEBA?=
 =?us-ascii?q?QcMAgICEwITAwEGAQ4FFAMCBAICAQICCgMBAgIBAwIJAgECAQUgAwEBDyQBA?=
 =?us-ascii?q?QICAgIDBAcCAQQGAw0CAgEBAQUGDQMCAwgNAgcDAgEDBQMCAgQBAgQKCQECA?=
 =?us-ascii?q?gECBAUHAgEIBgUNBQkLAQECAQMHBAMRAgUDBQUDAwIBCgUCAwECAQEDBAEDB?=
 =?us-ascii?q?AYBAQIDAgIBBgICAQEDAwQDAQIGAgIHAgMCAQQCAwMBAQEEAgICAgIDAwgDA?=
 =?us-ascii?q?ggHBQEGAQIBBAMCAgECBwEEAQgCAQMDBQMEAQoDDwMFAwEDAwIUCgUBBQgGC?=
 =?us-ascii?q?QIEBQIFAwIEAgMDAgIIAwIEAwILAwIGAgICBwQPBwIDAgIFAgICAgIFBAMBA?=
 =?us-ascii?q?gICAgICBQIEAgEFAQICAQICAgQBAgIHBAIDAQMEDgMDBAICBwECAgEGAgcDA?=
 =?us-ascii?q?QIBBAMBAQQCBAECBQICBAEDAQIGAgQDCgICAwICAgYIAwMMCQIDBQIGAQECB?=
 =?us-ascii?q?wQCAgsBBgIHAgIBAgMRAQMCAQQFBQMDAwkCAgMCBAICCgEBAQECAgEFBQIEB?=
 =?us-ascii?q?w8CAgIEAgICAQIDAgIBAQICBAQJEgEBAgMGBAYFAwIIGAEGAgIBAQICAgMDA?=
 =?us-ascii?q?gYCAQIIAgQBBAUCAQICAgIEAQMGAgMBAQIBAgIDAwIBBAIEAwMBAQIBAgICA?=
 =?us-ascii?q?wICAgMCAgEQAgYGAQICAgICAwICAQIFAQIBAgQCBwICBAMCAQICBQICAgMBA?=
 =?us-ascii?q?QYCAgQLAQMCBwYBAwIHBQIDAQIDBAMDCwUMCAEFAQMBBSECAwICCQIIAgEFA?=
 =?us-ascii?q?gUFARkBBmSYPj5RAZVIkC+LOJMRB4JDgREFgT+IPZYaMahnln2iGIUtECMSg?=
 =?us-ascii?q?VUBgWtwgQGCN04BAgEBAQ0BAgEBAwECAQIJAQECkg+KZjwxOwIGAQoBAQMJj?=
 =?us-ascii?q?wYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:CtsRpKApG4U53hVW/xnlw5YqxClBgxIJ4kV8jS/XYbTApD8mgTICz
 GVLDG3QM/uIZ2HzKIx/bY7noU5X7Z+DnddjOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EnkZqTRMFWFw0nqPp8Zj2tQy2YjhWFvU0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoyyXpo1T6
 /Bwj4GhEl0GO7XjhN4tCSANRkmSPYUekFPGCX22sMjW1k6fNnW1nKwoA0YxMokVvO1wBAmi9
 9RCcGFLPk3F3bjshuvkE4GAhex7RCXvFJsWvnhmzHfaJfkjSJHHBa7N4Le02R9q3p4eQ6mDN
 6L1bxJ+UCrhPS12EWsrAdU4xOO2uUWlbBpX/Qf9Sa0fujCPlmSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyCTCE4T+M83bpn+yW2C2iB9tUG7q/+fpnxlaUwwT/FSH6S3Oiv8DkqG2bZuhCO
 hdO1S82grQIxBaSG4yVswKDnFaIuRsVWtx1GuI86R2Qxqe83+p/LjhUJtKmQIx23PLaVQDGx
 XfSwIy0XW0HXKm9DCPCpu3N/FteLABMdTdaDRLoWzfp9DUKnW3ephfGT9ImCa3sy9OsRmi2z
 DeNoywzwb4UiKbnNplXH3iX3VpARbCTFmbZAzk7uEr4v2uVg6b4NuSVBaDzt6ooEWpgZgDpU
 II4s8af9vsSKpqGiTaARu4AdJnwuavUbGOB2QQyT8J+n9hIx5JFVdAAiN2ZDBc5WvvohRe0C
 KMukVgMusENZSPCgVFfOtLuUZpCIVfc+STND6iINLKik7B+cwiI+CwGWKJj9zGFraTYqolmY
 c3zWZ/0Ux4yUP07pBLrGbp1+eJ0nkgWmDKLLbimnk/P+efPNBa9F+1ZWHPQNbtRxP3f8G3oH
 yN3bZTiJ+N3C72gPEE6MOc7cTg3EJTMLcmo95QLL7Dde1oO9aNII6a5/I7NsrdNx8x9/tokN
 FnkMqOB4Fag13DBNyuQbXVvNOHmUZpl/CA0OCUtORCj3H16OdSj66IWdp0We7g79bw7naQkE
 aVdI8jQUO5STjnn+igGacavoYFnciOtj13cMiegZg85YJM9FRfC/cXpf1e0+SRXVni3uMIyr
 qeOzATeRZZfFQ1uANyHOv2qxlK1+3ManbsqDUfPJ9BSfmTq8ZRre3Sh1K9pf5lUJEyalDWA1
 guQDRMJnsX3otc4oIvTmKSJj4a1CO8hTEdXGm/s67zpZyTX+2yUx5AZDLSFcDXbY2PD+Ku4Y
 NJTwfyhYuYMm0xHstYlHrtmkfA+6t/oq+MIxwhoBi+XPVGiC7clO3rfmMcW6fQLybhetg+7H
 EmI/4ACa7mOPcrkFn8XJRYkPrvfj6BKwmGK4KRnOlj+6Q924KGDDRdYMS6KhXEPN7ByKo4kn
 bostZJE8QC5kRZ2YN+KgjoOqzaJJ30EFrwk79QUWdCyzAUszV5GbNrXDSqvuMODbNBFM08LJ
 D6Ihfqd2+4NmBKaK3djR2LQ2ed9hIgVvEwYxlE1IVnUyMHOgeU63UEM/Dk6JuiPIs6rDw6u1
 qlX20xJyWGm+j5pgI1aXDnpFVgeXVuW/Uv+z1ZPn2rcJ6VtuqohM0VlUdthPmhAm46fQtSf1
 L6dwWfhFz3teakdGwMsDFV9paWLocNZr2X/dQPOIyhBN5Y/aDvhxKSpYALkbvch7dwZ3CX6m
 AWhwAq8hWAX+8LdT23XxrR2DYgtdS0=
IronPort-HdrOrdr: A9a23:lngedq/NnW1rU1dV+/Ruk+DVI+orL9Y04lQ7vn2ZKCYlFfBw8v
 rFoB11726WtN98YhEdcLO7WZVoI0msl6KdiLN5VdyftWLdyQ6Vxe9ZnO/fKv7bdxEWNNQx6U
 6tScdD4RTLY2RHsQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,213,1654552800"; 
   d="scan'208,217";a="20686758"
X-MGA-submission: =?us-ascii?q?MDEM6fI7rFRcTPbBIRRq8nninQ/5G5TaTlZ9rc?=
 =?us-ascii?q?JlsSHkNBwElE9bBIxMWwNParBCrn05DpS58z0vVvA5vLWbUoJu3SY+eA?=
 =?us-ascii?q?8bFL35hcfdsXQsLLE/IeT416I94vr4nPGDwceZvz8d4COXadrwKj9kJG?=
 =?us-ascii?q?6PqcTEkT9PCGXyzWDBq61O8w=3D=3D?=
Received: from mail-qk1-f171.google.com ([209.85.222.171])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 07:55:07 +0200
Received: by mail-qk1-f171.google.com with SMTP id c3so12165486qko.1
        for <cocci@inria.fr>; Tue, 02 Aug 2022 22:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ffAJdfn+j4CavVTPqg8mCGkqCSyPBfbEDYXH0r+IJmY=;
        b=kjjzblRkkWo+1nMLLo40Z+8Va5tfCP+In+tX3kbhgflEQ7PfhMcwkd5FooQwHXl7bt
         s4xoDaZkWBBxoKhnciYDbNmd/xHfDLwGwViJSfRy4lYlepo/R4rb81q2RaMomK/o4dp6
         SfSbhM8aL/AR9R15ZYBKdOK6bwYDQvpfb55T99H2j2brPsAw8emM6ASA2NPpyDyTDODj
         VsDKWLpxLpHk0srk9W3KNV7uRvkHWfAtqmgfgAqo8D1svFBXpe/7GIPS6YJ4jp8XDP+d
         xoUdQuJxf+Y+ktKQpSwGXZNN63bHX3T3StiI9XFlCF9ZRYG9Av0B3hqLHLEj+i7wV1RB
         NMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ffAJdfn+j4CavVTPqg8mCGkqCSyPBfbEDYXH0r+IJmY=;
        b=1GQWw8gGIcoK079RLghbkyUN/m5E05HmsdJ6BL4on/Ey8aOi1xupHxdl46f7qfputI
         c3ViO9+7ANyI+NO+C61x17ST1hXKK7NKoqc1HbbUXyeWztlb2nx9SAhWncBKYmdx+0qn
         OXOA39bsz+vCyQU0p9I9LT6kv8l/BAi3OU1kPSVFtEUSt2ClJ6xCf7kAbBBDK/ZBuDva
         9lNB10Q5IikuCCtY2ajLiMY/JJ1SgtAKqXHWKfnzKeTYv3dhUmZ7KMmML+TqZ9xcsg0Z
         OhYJA5+HPCkh2NyEjkd8z+s9HpzjDxJTYoTiMpXhBkoZ4rDqet0mFsiJqquoMGP8yvWA
         u2tQ==
X-Gm-Message-State: AJIora8kBUWHpIxp+MAsLpHxukXc9bB6AuughxKeeZtBtZH6kuvo0OqB
	WBJUhI4Cs7L9kS6n7wj0zjSxjycVrMUv8LWmCqilHYz2
X-Google-Smtp-Source: AGRyM1vvf3KU6rbnjYYp/A39EboVe8eWx9XFq8Gg4dy0T/8FCuhB8bNtIWTJN5zRu/ecWrOgDx2bDFaKF6Xsu7VeuXQ=
X-Received: by 2002:a05:620a:1498:b0:6b5:da0c:e774 with SMTP id
 w24-20020a05620a149800b006b5da0ce774mr16683362qkj.576.1659506104449; Tue, 02
 Aug 2022 22:55:04 -0700 (PDT)
MIME-Version: 1.0
From: Palani kodeswaran <palani.k@gmail.com>
Date: Wed, 3 Aug 2022 11:24:53 +0530
Message-ID: <CAASoEDQCExdJXmMJy55OPAVaetG9b91g7ecdXojDVoC0iC-CRQ@mail.gmail.com>
To: cocci@inria.fr
Content-Type: multipart/alternative; boundary="000000000000dbbcfe05e54fdf42"
Subject: [cocci] Can coccinelle be used for adding header files
Reply-To: Palani kodeswaran <palani.k@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 500
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/CAASoEDQCExdJXmMJy55OPAVaetG9b91g7ecdXojDVoC0iC-CRQ%40mail.gmail.com>

--000000000000dbbcfe05e54fdf42
Content-Type: text/plain; charset="UTF-8"

Hello,

I am new to coccinelle and am trying to see if it would be possible in
coccinelle to add a header file to a source file.

Our current coccinelle rules change function calls to a different function
that is defined in another header file that is not included by default.
Would greatly appreciate if someone could point to an example that can
accomplish adding header files.


Regards,
Palani.

--000000000000dbbcfe05e54fdf42
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>I am new to coccinelle and am trying to see =
if it would be possible in coccinelle to add a header file to a source file=
.=C2=A0<div><br></div><div>Our current coccinelle rules change=C2=A0functio=
n calls to a different function that is defined in another header file that=
=C2=A0is not included by default. Would greatly appreciate if someone could=
 point to an example that can accomplish adding header files.=C2=A0<br><br>=
<div><br></div><div>Regards,</div><div>Palani.</div></div></div>

--000000000000dbbcfe05e54fdf42--
