Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C78EC433EF
	for <cocci@archiver.kernel.org>; Sun,  6 Feb 2022 17:59:19 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,347,1635199200"; 
   d="scan'208";a="19947261"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2022 18:59:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C8173E0382; Sun,  6 Feb 2022 18:59:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 20401E037F
	for <cocci@sympa.inria.fr>; Sun,  6 Feb 2022 18:59:13 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=efremov@linux.com; spf=Pass smtp.mailfrom=yefremov.denis@gmail.com; spf=None smtp.helo=postmaster@mail-lj1-f181.google.com
IronPort-SDR: 8tjueWWjuulHGfVRXtLk04zkL8L4cpLK4L7AsfWWcdtCBDAvoeQnfBPe/7wowE2SjxLTmIcxz/
 DSF+ZkM8NhVJs07mLgpPLuoY+9UJJ+SUo4rouQeHr4w64/8NYXJG3d7B0glDkAbwTARBiuNgkE
 d5UzN2ss7ZnkeZq5DvlynemSvtDLkJwQGqSm4wdv9dK15ipBNW2Hdc6ehp2+femyAD6+gjIAZx
 wDZvLNJw45HM2tSrol4hkZd3UB9XlvJRPDk8U4ldzyGKKxgoQFwWZvEIDwpOwLYY84ray/NnYB
 oO4i+TjFeAWeBi0fdnUywc/Z
X-IPAS-Result: =?us-ascii?q?A0BiAwDYCwBif7XQVdFagQmEAoFVKwSFIY5xgXefCwEDA?=
 =?us-ascii?q?QsBAUEEAQGIaQIdBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIDB?=
 =?us-ascii?q?AETAQENCwkHCAoHDg4FYAFFZIFPgXcIAwE9gjUihAQRgQsCJgI2AQUBLwgBA?=
 =?us-ascii?q?R6CYoMXBJ0jgh+BBD2KOHqBMYEBiX0JAQh+KoxQggocgg2BFSeEKoQpgksTg?=
 =?us-ascii?q?lIElBKCaDqhFVyeCoNQhA2bPQYPBS6WKxSBJZAplkqmRwIKBwYQI4FVUIEuM?=
 =?us-ascii?q?xoIGxWDJU0BAgEBAQ0BAgIBAgECAQIJAQECjXMBAQGOeT5rAgYLAQEDCZBPA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 4qW/J8=
IronPort-Data: A9a23:Buc2VqoPYqoeTKvogW7fUxyz66peBmIoYxIvgKrLsJaIsI4StFCzt
 garIBmGP/iDZDf0KIxxbIq+/EtXvpODxtI2GQdrrygwFSwUo+PIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHkZqTZMEE/Nszo68wICqtMu0YjR7z+l4
 4uo+ZWFYAH9glaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurSMEAcmBKSXv944dDJIHxl7MrUc05DIdC3XXcy7lyUqclPpyvRqSUU0ZMgWo7YuR25J8
 vMcJXYGaRXra+CemurqDLkxwJ57fI+ybNp3VnJIlVk1Cd43TJ7ZTqDN+5lU0TExnehBGP/fY
 4wSbj8HgBHoOkweZghNVcNWcOGAhSGnQTdig1Oup68azjKUlB5s7JnjGY+AEjCNbZwNwhzwS
 nj912/+CRobHMeOzCKMtHOqnO7G2y3hML/+D5W9//9uxVmRnykdUU1PE1S8pva9hwi1XNc3x
 1EoFjQGkfEy+3aiFf7HejqTsHK8uxEEAfF/HLhvgO2S8Zb87wGcD2kCazdObt06qcM7LQDGM
 HfZz7sF4hQ/4dWopWKhGqS89mztZHBERYMWTWpVEltfuoiLTJQb10qXFr5e/LiJYsoZ8AwcL
 hiPpSk6wrER1IsFjvXiu1/AhD2oq97CSQtdCuTrsoCNvl0RiG2NPdTABb3nARBoct3xor6p4
 iFspiRmxLpSZaxhbQTUKAn3IJmn5uyeLBrXikN1Ep8q+lyFoiD/JtEBsW0mfBk4a67onAMFh
 meD6Wu9A7cDbROXgVNfPupd9ux2l/G7TY29PhwqRoAWMsApHON4wM2eTRfIgzqFfLkEnqY4N
 pOWGftA/l5LYZmLOAGeHr9HuZdynn5W7TqKGfjTkkr6uZLDOyb9YepUaDOmM7FihIvZ8VW92
 4gEbKOilU4PONASlwGNrub/23hRfSZlbX03wuQLHtO+zv1OQj14W6SPkO9+J+SIXc19z4/1w
 510YWcAoHKXuJENAVzihqlLZOy9UJBhg2g8OCBwb1+k12JyM4mq5aYbMZAweOB/puBkyPd1S
 dgDetmBUqwfEGSZp2xFYMmvtpFmeTSqmRmKYHiobT05SJhqGF7E99riSQ3w+XRcFSGwr8Y//
 +at21qDE5oOTghvFujMb/erww/jtHQRgrMgW0rOP8kVc0LpqdA4Jyv0h/4xAscNNRScmWPHj
 VfIWU8V/LCfrZU0/d/FgbG/g72oS+YuTFBHG2T77KqtMXCCrGCt9pdaV+OTZT7QCTHv86K4a
 OQKnvylaK8bnExHupZXGqpwyf5s/MPmorJXw1g2HHjPaFj3WLpsLmPcgZtKv6xJg7tb4E64A
 xLWvNZdPrqNNYXuF1tIfFgpaeGK1Pc1nDjO7KRqfB+runcvpLfXA19POxSsiTBGKOcnOo0Sx
 +p86tUd7Bayi0Z3P9va3DpY8X+Aci4JX6k97M1IBYbqjk8vyAgHb8WMU2n555aAb9gKOU4ve
 2fGiK3HjrVa50zDb3tjSiSXjLQF3cwD6EJQ0VsPB1WVgd6Z1PU56xtcrGYsRQNPwxQbju9+N
 wCH7aGuyXliLdupuCRCY4xoMwRIBRnc/k6ojlVQxDSfQE6vWWjAamY6PI5hOazfH310JlBmE
 HOwkQ4JkgoGuOn+2yIzXQhurPmLoRlZ6FjZgM7+dyiaN8BSXNcm65NCoUIMqh36EYU6g0ivS
 SyGOgpvQfWTCBP8aJHXx2VXOXr8hfxEyKF/rSldwZ40
IronPort-HdrOrdr: A9a23:lik2W6l6ylzkgH5o/JcFqHWJZznpDfId3DAbv31ZSRFFG/Fw5P
 re+MjzsiWE8wr5OUtQ4exoV5PwIk80maQFh7X5Xo3SPjUO2lHJEGgK1+KLqFzd8kXFmNK1vp
 0QCpSWZueAamSSwfyKhTVQ0OxM/DBEysqVbCvlo0uFhDsEV51d
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,347,1635199200"; 
   d="scan'208";a="19947259"
X-MGA-submission: =?us-ascii?q?MDGPkrJ3XVmpaxGGTp3inWsMU/PHfqQSCPW9Le?=
 =?us-ascii?q?HNyNgQ8OsXMns6ThpD4wBKuW/1LViAB3lCAQV3Bmrl/lpUQCh0Iu0x0F?=
 =?us-ascii?q?gcOi7pZv+fxNjlQeWsqYpfKQiRDlJuKrW/d+33KWX/I+CggMI+ywARmP?=
 =?us-ascii?q?oMGwMfbBYZY3AVmbm3pW8DWg=3D=3D?=
Received: from mail-lj1-f181.google.com ([209.85.208.181])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 18:59:12 +0100
Received: by mail-lj1-f181.google.com with SMTP id u7so14983532lji.2
        for <cocci@inria.fr>; Sun, 06 Feb 2022 09:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=ZjdM7MjHncANHzr2k5kNmxFikXrdYnKWAjYL94/zYjc=;
        b=BM5zigMShDUzNTv0qDmXfnhPMViQzH0fISAlt55i+4bR7Lo/wt06KNUP37Vc/KdID4
         Ls3skAhy2rfHtF++y3KhiPAXDM9MSo5ENh+ZR4TBLfI5jSFh2uAV7AtQnelUEmwlwyBg
         Xd24jvLflqNpGoH6ZyyKIgj6UGb2l3G/o6wkLlSYMnI9WzoYrz9ZhVAeYOdelD4Kd44N
         Z/x3sE3bYyCo7s2AMNnBpSiUfKv+ofr00cBPYVJI1IZoOIejCbC9PcfS56QsoThL3xAr
         bQANhfaVSVWVK/ViDA/+JLvwrZBMmGAR8Z1w2FoqkKFCPQupnBknkglPlvEsTHEh8dCw
         59OQ==
X-Gm-Message-State: AOAM532IgEU97br9NLp9kup7lVNiJ2hEaylXxxFH10a/4LpCBgtKBofJ
	6v+LZaPywA/Rb+P1hXT4pFzTfFLYXyk=
X-Google-Smtp-Source: ABdhPJz+k8N7uGXPJE/BsCbJvhpF2ztRu+0Fh/XORE9tr3TdlLqE0f8dQe4f/JwyW/GZOUueEfVplg==
X-Received: by 2002:a2e:9b91:: with SMTP id z17mr6248279lji.20.1644170351032;
        Sun, 06 Feb 2022 09:59:11 -0800 (PST)
Received: from [10.68.32.40] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id y19sm1180458lfb.191.2022.02.06.09.59.10
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 09:59:10 -0800 (PST)
Message-ID: <cd9a37f0-9a90-1df5-cec7-853a783e5538@linux.com>
Date: Sun, 6 Feb 2022 20:59:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: cocci@inria.fr
From: Denis Efremov <efremov@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [cocci] spatch 1.1.1 segmentation fault report
Reply-To: Denis Efremov <efremov@linux.com>
X-Loop: cocci@inria.fr
X-Sequence: 122
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/cd9a37f0-9a90-1df5-cec7-853a783e5538%40linux.com>

Hi,

I'm observing a weird crash with spatch 1.1.1

$ spatch --version
spatch version 1.1.1 compiled with OCaml version 4.11.2
Flags passed to the configure script: --enable-opt --enable-ocaml --enable-python --enable-pcre-syntax --enable-pcre --prefix /home/work/.opam/4.11.2 --libdir /home/work/.opam/4.11.2/lib
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE

$ cat segfault.cocci
@err@
position p;
@@

amd_energy_is_visible(...)
{
*       return 0444;@p
}

@script:python@
p << err.p;
@@

coccilib.report.print_report(p[0], "found")

$ mkdir empty_dir # creating empty directory
$ spatch segfault.cocci empty_dir
init_defs_builtins: /home/work/.opam/4.11.2/lib/coccinelle/standard.h
0 files match
[1]    152475 segmentation fault (core dumped)  spatch segfault.cocci test


Best Regards,
Denis Efremov
