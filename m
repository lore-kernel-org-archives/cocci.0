Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB88ECAAD5
	for <cocci@archiver.kernel.org>; Mon,  5 Sep 2022 20:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1/CSZliGEG7b87tWE/OyRdvmIwKwuX3MSVamtvlK4Lc=;
  b=r5o3Pds0B3dqsZ5cgR5tVvgdnn25r4WC492L1szfC6Z7XN+51hoPoAcW
   mugl051UM5i4/y6g5GxLR2/3qeezWjUNHaymx1qSqpBUCs4MAxUgvV9rU
   s67+0ll3WrKsjayyXnv4gfZW95Q1BsAyF1BnOKaqGaHmcpfAet1ALaPe/
   o=;
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
X-IronPort-AV: E=Sophos;i="5.93,292,1654552800"; 
   d="scan'208";a="51409546"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2022 22:22:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5434DE779C; Mon,  5 Sep 2022 22:22:05 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9941EE015F
	for <cocci@sympa.inria.fr>; Mon,  5 Sep 2022 22:22:02 +0200 (CEST)
IronPort-SDR: LEbfkDUXR/LWLz+T5J3U4kMG8yjW0ag4NwRXWIoL0/jPG1/YmBEJVQjSi2RzTIpUuPo+O2TZPW
 Mjd9en8IKPsz8T8/9dDXVSqlWWwW8UCtVGLDLaemTIidfcakw5f0IAleLs8L5OD6DbUUaPcbc7
 pPjEu7mXzTIMJpr/Adl63VU7ykU+iCjFgx9L6kVTe1w78SE4XidQwZ1dJJfJwDMrP8sLxxILlb
 VYSv83U0sCxytV+e0pZ5nRzJsYFtji+DLOLNit5eCguvbzGa0C6VCvXFIxhTg3csB3bN7DE2xl
 71woZDJc2gPdkUc7kfWGf0v6
X-IPAS-Result: =?us-ascii?q?A0AdBgDBWRZjfyqgVdFaHgEBCxIMQINzMwFNVS8EC0WET?=
 =?us-ascii?q?o5rgiUDjD+GGowoCwEDAQ05CQQBAYUGAoRlAh0HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQEARMBASEZBw4OZQFhAwFEgU+BdAsDMQ2CNSkBg?=
 =?us-ascii?q?2QBAQEDEhEdARsdAQMMBgULDQICJgICIgERAQUBHAYTIoJcgmwBAzADEJthg?=
 =?us-ascii?q?QRCizKBFQUXgQGCCQaBQQGDDQoZKA1nA4FZAgEGEn8siEKDIYNCeiccgUlEg?=
 =?us-ascii?q?UuCRDA+gmIBAQKBXhWDQYJlBJchAQMHAwQGBQ8DAwIhAQIBRB4CCQMjEQMLE?=
 =?us-ascii?q?AgUFyQGBgEEAQEMAgEEAQUDAQQFAwcCAQUGAgkDAwkDAQEFAQMEAwMDAgcDA?=
 =?us-ascii?q?QIMBAgDAwIDBAICAgIBAwIHBQgEAgcCAgIBAgICBAIBAwkBAgMFAgIJCwEEA?=
 =?us-ascii?q?gIDAQMBAQIIBAkEAgMEAgEBAwIBAgIBBQIOBQEBAQECBQECAwEGBwIIAhwKA?=
 =?us-ascii?q?QMDAwICBQICAQIDAg0BAQQCAQIBAgYBAwECAgMBAwECAgMCBgkCBAEFAwMCA?=
 =?us-ascii?q?gMBAQUPBQIEAgECBgUCAQEBBAEDBAQGAgIBAwMCDgIEAQQBAgEBIwMEAgMBA?=
 =?us-ascii?q?xcBAgECAwMDBAYHBQIBAhMBAgEBAQUBAgEBAwQEBwkDAgIEAwMFAQECAwIBA?=
 =?us-ascii?q?QEHDAICAhICEwMBBgEOBRQDAgQCAgECAgoDAQICAQMCCQIBAgEFIAMBAQ8kA?=
 =?us-ascii?q?QECAgICAwQHAgEEBgMNAgIBAQEFBg0DAgMIAQwCBwMCAQMFAgIEAQIECgkBA?=
 =?us-ascii?q?gIBAgQFBwIBCAQFDQUJCwEBAgEDBwQDEQIFAwUFAwMCAQoFAgMBAgEBAwQBA?=
 =?us-ascii?q?wQGAQECAwICAQYCAgEBAwMEAwECBgICBwIDAgEEAgMDAQEBBAIBAgICAwMIA?=
 =?us-ascii?q?wIIBwUBBgECAQQDAgIBAgcBBAEIAgEDAwUDBAEKDwMFAwEDAwIUCgUBAwgGC?=
 =?us-ascii?q?QIEBQIFAwIEAgMDAgIIAwIEAwILAwUEAgcEDwcCAwICBQICAgICBQQDAQICA?=
 =?us-ascii?q?gICAgUCAwIBBQECAgECAgIEAQICBwQCAwEDBA4EAwICBwECAgEGAgcDAQIBB?=
 =?us-ascii?q?AMBAQQCBAECBQIEAQMBAgYCBAMKAgMCAgIGCAMDDAkCAwUCBAEBAgcEAgILA?=
 =?us-ascii?q?QYCBwICAxABAwEEBQUDAwMJAgIDAgQCAgoBAQEBAgIBBQUCBAcPAgICBAICA?=
 =?us-ascii?q?gEDAgIBAQICBQQJEgEBAgMGBAYFAwIIGAEGAgIBAQICAwMCBgIBAggCBAEEB?=
 =?us-ascii?q?QIBAgICAgQBAwYCAwEBAgECAgMDAgMCBAMDAQIBAgICAwICAgMCAgEQAgYGA?=
 =?us-ascii?q?QICAgICAgICAQIBBQECAQIEAgcCBAMCAQICBQICAgMBAQYCBAsBAwIHBgEDA?=
 =?us-ascii?q?gcFAgMBBAMEAwMLBQwIAQUBAwEhAwICCAIHAgEFAwUBDwMCAgMCAgEECgIDB?=
 =?us-ascii?q?QIEAgEECQcCBAECCQMDBgIHBRgBAgIHBAwKAgICBQYCBAEBAQEDAQICAQIDB?=
 =?us-ascii?q?AIDAgQFAQUCAQIFBAICAQECBQIMAQIBBwYCBwMCAgIDAQQCAQIBAwMCAwEBA?=
 =?us-ascii?q?QMGBgUGBAIDAwYCAgIGAgIDAhIDCAIGAwIEAQ0PBQQHCAECAQECBwIEAgcJA?=
 =?us-ascii?q?g4CAQYBBwICAwICAQUCAQYEBwEDAgICAgICBQgFAwQFAgMGR5VzgwQPCiwgg?=
 =?us-ascii?q?h06wTthgnuLLZR7Mqh2lweNOZRzhSUQIxKBQyOBW00jFWyCNk4BAgEBAQ0BA?=
 =?us-ascii?q?gEBAwECAQIJAQECjh2DcoUUhUxCMQswAgYBCgEBAwmKUgEB?=
IronPort-PHdr: A9a23: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
 10DxraqdOwu
IronPort-Data: A9a23:epiFb6CZWYWKXBVW/wDlw5YqxClBgxIJ4kV8jS/XYbTApD8j3jdRz
 2MfCGqPbKveajOgKdxza9y+8E9Q68LUy9JkOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EnkZqTRMFWFw0nqPp8Zj2tQy2YnhXlvX0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYox6DmOtgl
 PVVjrPqRyMRFPXHvLxEcCANRkmSPYUekFPGCX22sMjWyESfNnWwmbNhC0Y5OYBe8eFyaY1M3
 aZAeXZdM1ba2brwnOjTpupE3qzPKOHpIIQdvHh65T7cBPciB5vERs0m4PcChmZp2J0RQZ4yY
 eIzeR5UUU7MRCR3FX0vFakMpP73tz7gJmgwRFW9/PJruQA/1jdZ1LHyOd7RUs6LQM9PlwCZo
 HjH9iL3GHkyP9uUwjut6WOpnuaJnCXhWYtUGqfQyxJxqFiax2hWDxRPEFXn+7+2jUmxX98ZI
 EsRksYzkUQs3GehSeLsAz2gm1HesDokcYJbN7VjyzjYn8I4/D2lLmQDSzdAbvkvu8k3WSEm2
 ze1czXBVW0HXFq9GSL1y1uEkd+hEXNKcjJaNEfoWSNAsoaz+thi5v7aZo87SPbdszHjJd3nL
 9m3QMUWgrwSiYsM3vz+8wydxT2roZfNQ0g+4QC/soOZAuFRNNPNi2+AswKzARN8wGCxEAfpU
 J8sxZP20Qz2JcvR/BFhuc1UdF1T296LMSfHnXlkFIQ7+jKm9haLJN4Oum0mfhkzbJtVIVcFh
 XM/XysBtfe/21P6PcdKj36ZVqzGMIC7SIy9Dq2MBjawSsEpKVLblM2RWaJg9zm1zBJEfVAXN
 pCcfsKhZUv2+ow2pAdas9w1iOdxrghnnT27bcmik3yPj+DCDFbLEuxtGAXVPogEAFas+lq9H
 yB3bJvUlX2ykYTWPkHqzGLkBQtXdiNjVMGv85M/myzqClMOJVzNwsT5mdsJE7GJVYwM/gsR1
 n3iCEJe1nTlgnjLdVeDZnx5OeHgWJ9+qTQwOil1ZQSk3H0qYICO6qYDdstvLeN3qrA7lfMkH
 eMYf8igA+hUTmuV9jkYa677ptMweRmugzWIICf4MiM0eIRtRlCS99K9Jlnv+SACAzCZr8w7p
 7H8hArXTYBSFQtnBcfSLvmoygrp73QanetzWWrOI8VSKB28qtg0d3Spg6Zucc8WKBjFyj+L7
 CqsAE8V9bvXvos40NjVnqTb/YqkFu1JGEAFTWTW6LCBMzaDojiuzIpGZ+a/fT7HUVTy9qj/N
 /5eyOvxMaFekVtH79h8HrJswf5s7tfjveUBnAFtHXGOaF3yT708eD+J2s5AsqALzbhc4FPkV
 kWK89hcGLOIJMK1TwJLdVR9NryOhaMOhz3fzfUpO0GmtiV5y7yKDBdJNB6WhS0BcbZ4bNE/z
 eE6tJJE4gCzkEBxYNOPjyQR8G3Va3JcCeMosZYVBIKtgQ0ukwkQbZvZAy7wwZeOd9QcbRVwc
 2HM3PLP1+ZG207PU3svDnyRj+BTspID5UJRx1gYKlXVx9fIi5fbBvGKHejbk+iU8vlG7w63E
 m1iNkkwIqzXujk03o5MWGejHwwHDxqckqA0J53li0WBJ3RElESURIH+BQpJ1E8c+mNYODNc+
 dl0DU77BC3ycpiZMjQaACZYRj+KcTC13gLHkcGjWc+CGvHWpNYjbrCGPQI1lvcsPS/9aIAra
 wWnECacpJAX7RItnpA=
IronPort-HdrOrdr: A9a23:kJPrqKvwnZiw/QVGs95hfoOT7skDQ9V00zEX/kB9WHVpmwKj5r
 mTdZMgpGTJYVcqKQkdcLW7UpVoLkmskKKdjbNhX4tKGTOW21dAT7sC0WKB+UyFJ8SWzIc0vp
 uIMZIfNDSaNykcsS+V2njfLz/i+rW6GWKT6Ns2A00DceiiUc9d0zs=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,292,1654552800"; 
   d="scan'208";a="22916574"
X-MGA-submission: =?us-ascii?q?MDEKJ1hecmjun6wl4mEGnvagfyKHzQBTXfEFx/?=
 =?us-ascii?q?NRQfy0lydSYYq4jqFolPJ9qFAfYIq2BN3ccCn65rRNhbbdFnnWkU5cQk?=
 =?us-ascii?q?2nuvG4nOTBmFLbDnIHcrFm4Z4YkLej0i+zYtJIvN82Ig2pMEA1CLAD4V?=
 =?us-ascii?q?wUbX2zGIpst4oty7JdBG0NQA=3D=3D?=
Received: from mail-oa1-f42.google.com ([209.85.160.42])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 22:22:02 +0200
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1278a61bd57so5112505fac.7;
        Mon, 05 Sep 2022 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=1/CSZliGEG7b87tWE/OyRdvmIwKwuX3MSVamtvlK4Lc=;
        b=YaIXoVg7PTKbxLfSGmRGh/Z13E6MTDY5NtG78KzIEft8ddcN7m3nAUCBCYugdqpfsx
         mTM0xVt9CdzA5QDdlSU/G8+h3E1pk6Bu4CA/6V4EXpc5RlRyWfaVg+QVkUWklIM6GO+t
         kpbUZitQRbe38qDQzdo6qX5uZ6WEkt5aiOmTQE4+9AFJQELV0Per+zuneGH5pPQ3F0ga
         1r5jwRpOST+738tH+jLQhYgyHlDRbWOZovJvSPMWUOrBDTjxUIqvVzyNuU8KXV6ymFbe
         WAyDSZQkm5AoTJK/LgpEC/WORWQNklcwbPp2EQ2coqehGRRt/eTLHO1x96v+itskSyGn
         L89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1/CSZliGEG7b87tWE/OyRdvmIwKwuX3MSVamtvlK4Lc=;
        b=o8HvS9DzJ+VswXKLA/L+JCyEdxSST7Gi5vvFgwNiMDSKULZBtXrplPmzBuO/qBpEk+
         KvlH708hT9WXSuQSiI5mqHc3QLlYxH8U5Wbpru+C4t7RDs6HEZv3j0MeOw4Xfzjhzwuu
         kZcfqPONZueA96HKQC4ehIjV9YfDoFgtMfhudrQt34UDAlIK6cOWC9CnzpYaZ09P5Jvf
         ecFpL0R7JVb7WDCS8mjK2cL+uROGkarV1YFANzPf9/hAP9cBpkht+pI6OWyltu1ykj5I
         zjAJUUGW+XCNCl9D6d3uxnLKMfhj2QdTIK+Bjgf/KVD7teNChQ02gPb/ETgdGTToU5lf
         bKVQ==
X-Gm-Message-State: ACgBeo1Mcy7ilNwgeGp5w19DbOJWQgVn0jOgeMxWL+ot6xE0nZngyjOi
	xvmbF35s2gVvZF3bb+2lbTsM+rM8Xsz6YhMdByYzztZOH5E=
X-Google-Smtp-Source: AA6agR50gN3mKdNPdrSimy90BJliGO4J9kwj9RxtopitzKOZRyDkynLtzMIAHtaNv4RDQBZOnW32HESzgjPskNW/6JQ=
X-Received: by 2002:a05:6870:8181:b0:127:806f:ab0b with SMTP id
 k1-20020a056870818100b00127806fab0bmr2380301oae.217.1662409319467; Mon, 05
 Sep 2022 13:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2209050952300.2731@hadrien>
 <20220905090915.3569051-1-jtojnar@gmail.com> <alpine.DEB.2.22.394.2209051246490.2731@hadrien>
 <CAFGSp1ud+X_xHa4zwhwPEzOvoC+4zwmONLi5HCQn76WHzfwoHQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2209051427090.2731@hadrien> <CAFGSp1umoczUe4npSesAUOLgSq=9VkvLUOV3x1hSvSajqQkGfw@mail.gmail.com>
 <alpine.DEB.2.22.394.2209051445570.2731@hadrien> <CAFGSp1vuGyiT86c7vq9MmYWaP06vRLo4OLQTREpHK_fw8vfEyg@mail.gmail.com>
 <alpine.DEB.2.22.394.2209052150160.3611@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2209052150160.3611@hadrien>
From: Jan Tojnar <jtojnar@gmail.com>
Date: Mon, 5 Sep 2022 22:21:48 +0200
Message-ID: <CAFGSp1vDA7DBgmtQeYu255M_e9zQYCPVAryL15OikEz+Rf1qyQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH v2] Exit with non-zero status when spatch on a
 directory fails
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 547
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/CAFGSp1vDA7DBgmtQeYu255M_e9zQYCPVAryL15OikEz%2BRf1qyQ%40mail.gmail.com>

On Mon, 5 Sept 2022 at 21:51, Julia Lawall <julia.lawall@inria.fr> wrote:
>
> The patch has been applied, followed by another one that dropped th e
> --keep-trying option and that addresses the parmap issue.

Thanks, that will work for us, except that you probably accidentally
made it so that patching only happens when a failure occurs =E2=80=93 there
should be `not` before `patching_failed` on this line:
https://github.com/coccinelle/coccinelle/blob/5448bb2bd03491ffec356bf7bd6dd=
cdbf4d36bc9/enter.ml#L1419

Additionally, it looks like you keep introducing more tab characters
into the indentation, resulting in mixed tabs and spaces. This makes
diffs more noisy than necessary and the code can end up displayed
misaligned in some text editors.

May I suggest adding the following .editorconfig file to the root of
the repository? Hopefully, your editor has support for that standard
and will use consistent formatting:
https://editorconfig.org/#pre-installed

root =3D true

[*]
end_of_line =3D lf
insert_final_newline =3D true

[*.{ml,mli}]
indent_style =3D space
indent_size =3D 2
tab_width =3D 8
