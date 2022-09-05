Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21EBECAAD5
	for <cocci@archiver.kernel.org>; Mon,  5 Sep 2022 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=npsYX/bTwrFWxNhDfvppge5BD4o6PzKmhB4VxsgxbuM=;
  b=J4+fFxOdCfgK4Mehm9Sco2Kq9kffkPWVge4XbhEtD1Hob/5ph96muYAv
   5xlqCGwQhX1PuLUXCqg/ZhAWe+jtviFTpLLb9hQ44xkc8CYddTEzsTVJw
   sKNugXhyGbe4YQhg1DG5sQF1LX8heSQ5x28JQp/3cH+l/FD6toE90/PZu
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
X-IronPort-AV: E=Sophos;i="5.93,291,1654552800"; 
   d="scan'208";a="51367371"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2022 16:19:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B3AECE779C; Mon,  5 Sep 2022 16:19:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A2554E779B
	for <cocci@sympa.inria.fr>; Mon,  5 Sep 2022 16:18:59 +0200 (CEST)
IronPort-SDR: fMAziP/Xjh1uDNgQUOUnpdSPcsE7muRFpyL8e8vjXOxQ6SfFlpBDcemICFNot2WR4JsljLpWX3
 7v35Kz7ODXkC8MnERXgNxmVzY5zrX7NIHBw5nkfB57FNTuSv/11H8jtNRyfa18VRWqGK4CQgl+
 JysnajqvGG0eQjtll9nCtMCR8OiQZ6Z7mTBFu4uJAGTvUWz4jGHpG0H7b/KwCxe7+3JnoSyeTK
 qNJci/z/faOCFIevRktvX43yP+Hdjk/RBW40cR9Oq1xTin12rPOEns+QPvLw3wwEUYFwCuBYKt
 DLeU4qne5Zl1ppAe9byCLNRA
X-IPAS-Result: =?us-ascii?q?A0AVBQAGBBZjfzGgVdFaHQEBAQEJARIBBQUBQIFPgXwog?=
 =?us-ascii?q?QFVLwQLRYROjmuCJQOMP5JCCwEDAQ07BwQBAYUCAgIChGUCHQcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBIRkHDg5lAWEDAUSBT4F0C?=
 =?us-ascii?q?wMxDYI1KQGDYwEBAQECARIRHQEbHQEDAQsGBQsNAgImAgIiAREBBQEcBhMIG?=
 =?us-ascii?q?oJcgmwBAw0jAxCbEIEEQoo4eoEVBReBAYIJBoFBAQMFgwUKGSgNZwOBWQIBB?=
 =?us-ascii?q?hJ/LIhChmN6JxyBSUSBS4JEMD6CYgEDgTUBKBWDQYJlBJchAQMHAwQGBQ8DA?=
 =?us-ascii?q?wIhAQIBRB4CCQMjEQMLEAgUFyQGBgEEAQEMAgEEAQUDAQQFAwcCAQUGAgkDA?=
 =?us-ascii?q?wkDAQEFAQMEAwMDAgcDAQIMBAgDAwIDBAICAgIBAwIHBQgEAgcCAgIBAgICB?=
 =?us-ascii?q?AIBAwkBAgMFAgIJCwEEAgIDAQMBAQIIBAkEAgMEAgEBAwIBAgIBBQIOBQEBA?=
 =?us-ascii?q?QECBQECAwEGBwIIAhwKAQMDAwICBQICAQIDAg0BAQQCAQIBAgYBAwECAgMBA?=
 =?us-ascii?q?wECAgMCBgkCBAEFAwMCAgMBAQUPBQIEAgECBgUCAQEBBAEDBAQGAgIBAwMCD?=
 =?us-ascii?q?gIEAQQBAgEBIwMEAgMBAxcBAgECAwMDBAYHBQIBAhMBAgEBAQUBAgEBAwQEB?=
 =?us-ascii?q?wkDAgIEAwMFAQECAwIBAQEHDAICAhICEwMBBgEOBRQDAgQCAgECAgoDAQICA?=
 =?us-ascii?q?QMCCQIBAgEFIAMBAQ8kAQECAgICAwQHAgEEBgMNAgIBAQEFBg0DAgMIAQwCB?=
 =?us-ascii?q?wMCAQMFAgIEAQIECgkBAgIBAgQFBwIBCAQFDQUJCwEBAgEDBwQDEQIFAwUFA?=
 =?us-ascii?q?wMCAQoFAgMBAgEBAwQBAwQGAQECAwICAQYCAgEBAwMEAwECBgICBwIDAgEEA?=
 =?us-ascii?q?gMDAQEBBAIBAgICAwMIAwIIBwUBBgECAQQDAgIBAgcBBAEIAgEDAwUDBAEKD?=
 =?us-ascii?q?wMFAwEDAwIUCgUBAwgGCQIEBQIFAwIEAgMDAgIIAwIEAwILAwUEAgcEDwcCA?=
 =?us-ascii?q?wICBQICAgICBQQDAQICAgICAgUCAwIBBQECAgECAgIEAQICBwQCAwEDBA4EA?=
 =?us-ascii?q?wICBwECAgEGAgcDAQIBBAMBAQQCBAECBQIEAQMBAgYCBAMKAgMCAgIGCAMDD?=
 =?us-ascii?q?AkCAwUCBAEBAgcEAgILAQYCBwICAxABAwEEBQUDAwMJAgIDAgQCAgoBAQEBA?=
 =?us-ascii?q?gIBBQUCBAcPAgICBAICAgEDAgIBAQICBQQJEgEBAgMGBAYFAwIIGAEGAgIBA?=
 =?us-ascii?q?QICAwMCBgIBAggCBAEEBQIBAgICAgQBAwYCAwEBAgECAgMDAgMCBAMDAQIBA?=
 =?us-ascii?q?gICAwICAgMCAgEQAgYGAQICAgICAgICAQIBBQECAQIEAgcCBAMCAQICBQICA?=
 =?us-ascii?q?gMBAQYCBAsBAwIHBgEDAgcFAgMBBAMEAwMLBQwIAQUBAwEhAwICCAIHAgEFA?=
 =?us-ascii?q?wUBDwMCAgMCAgEECgIDBQIEAgEECQcCBAECCQMDBgIHBRgBAgIHBAwKAgICB?=
 =?us-ascii?q?QYCBAEBAQEDAQICAQIDBAIDAgQFAQUCAQIFBAICAQECBQIMAQIBBwYCBwMCA?=
 =?us-ascii?q?gIDAQQCAQIBAwMCAwEBAQMGBgUGBAIDAwYCAgIGAgIDAhIDCAIGAwIEAQ0PB?=
 =?us-ascii?q?QQHCAECAQECBwIEAgcJAg4CAQYBBwICAwICAQUCAQYEBwEDAgICAgICBQgFA?=
 =?us-ascii?q?wQFAgMGR5Vzggg0EDgGCQooBE8xgUgCwWhhgnuLLY10hwcyhD+kN5cHjTmVA?=
 =?us-ascii?q?YUXECMSgUMjgVtNIxVsgjZOAQIBAQENAQIBAQMBAgECCQEBAlWNSIEmAQKCS?=
 =?us-ascii?q?YE+iSJCMQIJMAIGAQoBAQMJiAoBJ4IgAQE?=
IronPort-PHdr: A9a23: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
 sJmolBzW1k8F/dcAUNgToVqHQ==
IronPort-Data: A9a23:/B+J4qJ5Qb/clcOcFE+R+JMlxSXFcZb7ZxGr2PjKsXjdYENS1TQGz
 mofCGvSb/jfZWqneNpwYIi1oxhSvJHQx9NmQQId+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M48wIFqtQw24LhUlvQ4
 YqaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhj+1P8
 NhSt4OLWFkAI53roLg3CUdZHHQrVUFG0OevzXmXtMWSywjBeiKpzak/Sk4xOoIc96B8BmQmG
 f4wcmhcKEDewbvomPTnG4GAhex7RCXvFIEDvXNmxCvxAvMvQJSFSKLPjTNd9G1q1pEVRauAD
 yYfQQdrcBbnXhx3Bm1NF7sBpMaEi13PShQN/Tp5ooJuuzSJpOBr65DpOcXcftiiV8RQlFyR4
 GPA5WXwRB8AXPSUzjGO81q3l+rXlGX6XpgTHfu27JZXbEa7w2USDFgRXAL+r6XozEG5XN1bJ
 gof/S9GQbUOGFKDXuTDZxCnomG/r0A1Rup3K7EQsl+Mxf+Bi+qGPVQsQjlEYd0gkcY5Qz02y
 1OE9+8F4xQ/4NV5rlrNpt+pQSOO1Ts9djBdOHdVJecRy5yy/9Fp10OnosNLSfbt1rXI9SfML
 ydmRRXSap0WhM8PkqKypBXJ32PqqZ/OQQo4oA7QWwpJDz+Vhqb1OORECnCBt56sybp1qHHf4
 RDofODAt4gz4WmlznDlfQn0NOjBCwy5GDPdm0VzOJIq6i6g/XWuFagJvm8kfx43aJxUI2G1C
 KM2he+3zM8DVJdNRf8nC79d9+x3pUQdPY+4DqiMM4ImjmZZLVbfoXgGibGsM5DFyRBwy8nTy
 L+UdsGjCXtyNEiU5Gveegvp6pdynnpW7TqLG/jTlk37uZLAPiL9YeleazOmMLtphJ5oVS2Pr
 L6zwePRm0sBOAA/CwGLmbMuwacidCJrW82r8JEPK4Zu4GNOQQkcNhMY+pt5E6QNokifvr6gE
 qiVVhAKxVzhq2fALAnWOHlvZKm+D5l6pHM/eycrOA/wiXQkZI+u6oYZdoc2LeF3rrw9kaYsQ
 qlXYdiED9ROVi/DpGYQYJz7m4poK0amiAeICCy6bWVtZJVnXQHIpoTpc1K3pikDBya6r+Ukp
 Lik2l+JSJYPXVUwA8PfafbpxFS05CBPlOV3VkrOA99SZES8qNgwe3Kt1qc6epheJw/Cyz2W0
 xetLS0Z/eSd8ZUo9NTphLyfq9j7HuZ7GH1cFTaJ4LuzMx7c4TP/k4JNVeC/fQfdWnnxz6Osa
 LgH1Pr7KvAGwA9HvocgQbZmyaUyu4nmq7NAlF82GXzKaxGsA+olLCXXm8ZIsaJJy/lSvg7vA
 hCD/dxTOLOoPsL5EQ5OeFB0MLzbjfxEyCPP6fkVIVnh4HMl9rSwV0gPbQKHjzZQLecoPY55k
 /0tvtUat162hhYwaI3UiylV8yGLJyVFXfl28J4dB4Dvh0wgzVQbOc7QDSr/4ZeubdRQMxl1f
 mXF2vKa37kMlFDfd3cTFGTW2bYPj5o5vh0XnkQJIE6Em4aYi/I6tPGLHe/bkuiIItR7P+NP1
 qxDMkR0IeCJ9m4tipQSGW+rHA5FCVuS/UmZJ57lUoHGZxHAa4APBDRV1SWxEIQx/GdVfzwd9
 7adoIogeSi/Z9n/h0PeRmY8w8EOjrVNGsnql8WuHsDDFJ4/CdYgbmlCekJQwyba7QgNaIEra
 AWkECucqUE2CMLIn5AGNg==
IronPort-HdrOrdr: A9a23:N50njK+Gxb1zkiF10Wduk+Ggdr1zdoMgy1knxilNoENuE/Bwxv
 rBoB1E73DJoR4LUnAhhtyMfIGcKEmsp6KdgbNwAV+jNDOWw1dAX7sSl7cKogeQfhEWmdQtsp
 uITZIOTuEYYWIK9PoTDmGDYoUdKPfuytH1uQ719QYxcenzAJsQvzuQM26gYxxLrOMvP+tnKH
 Pk3LsYm9PCQwVqUi3YPAhgYwGZnayT5crbiHc9bnZNgmTj/FDYioISdSLomyv2fAk/movKml
 K10TARiJ/Ty81ThiWssVM6uP9t6abcI5Z4dbuxYo9/EESdtu6XDr4RH4GqjXQQmqWC+VwqmN
 7Dr1MJONly0WrYeiWQrQH20wft/T4y4zu6oGXoyEfLkIjcfnYXGsBBjYVWfl/w7Fchhsh11O
 Zu03iCv5RaIBvclGDW5sTOVTttik2oyEBS59I7vjh6a88zebVRpYsQ8Ad8F4oBJjvz7MQdHO
 xnHKjnlYRrWGLfS0qcknhkwdSqUHh2NAyBWFI+tsuc1CUTtGxlzmMDrfZv1EsoxdYYcd1p9u
 7EOqNnmPVlVckNd59wA+8HXI+eFnHNexTRK2ifSG6XX53vA0i956If3Y9Fq91DIPczvdUPcd
 X6IRtlXFcJCg/T4Zbk5uwLzvjPKF/NLggFhPsup6SRgYeMOoYDARfzN2zGrPHQ0sn3IverLs
 pba6gmd8MLa1GeWrqg1GfFKt5vAEhbV8tQss0wWlKQrqvwW9fXitA=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,291,1654552800"; 
   d="scan'208";a="22893056"
X-MGA-submission: =?us-ascii?q?MDF3rEc6CdC99qnofJolbo39q6vUl1rec5NvYS?=
 =?us-ascii?q?LjXusPqFxA+IYMJ3qMXDxy6Lrt49mrZM0VHyLbX8crgcKpY61LOneB0Y?=
 =?us-ascii?q?LMB4PIxRq4YG1jsBWxKRErND/Y5bUqTtDY9Bq4V3iUshyMseiW+LuxnK?=
 =?us-ascii?q?Wp1YKC/PapsudR4H5kvAYpUQ=3D=3D?=
Received: from mail-oa1-f49.google.com ([209.85.160.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 16:18:59 +0200
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1279948d93dso1910597fac.10;
        Mon, 05 Sep 2022 07:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=npsYX/bTwrFWxNhDfvppge5BD4o6PzKmhB4VxsgxbuM=;
        b=DN1sG5aZuWEUcqMSN7iXUbrYDbEVvITRbQanMz/MXzIZwiC32K39fNe+wzlXAOjE9w
         yvGr0gRTcW3GVN15KloPD4+TstoWMNoxnIsuewKXTkquMfkM+jZ5ZP819cU2O4ynR9pr
         oisnW6g+6yGYemltpwyAtkD2HARQ24yf9VizOeRu4oOfBhv1VH17egCc55jvbV4+Vmkn
         DjNIIYd47oT/UIiJdhg8xQ/RD441zX9j+d2fOcqUWuCv/Ql0vohBOpylIJQGQqYPMdJV
         SS0gmxF84Kq7G0BBkAeMA5m25r1q5sJJEQCStoY7uCVGrNRwSNO/W1GW54jDNmsxUifK
         lKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=npsYX/bTwrFWxNhDfvppge5BD4o6PzKmhB4VxsgxbuM=;
        b=UiBL9dz1H+ocEO9Ou/P8L6PXDye90UMDRBuleJJ3TD1dZymNo8InTgTEmC9BMgcq3U
         LIMhy3IBvZoJ5Au6pXQB14kBXYWb5Fccz/Hva55okr/2S6SE9FuVZap+SYQu+8dcylet
         62MHxuBvsGGA6s88AFtFbL32LMR8mWozQPYF+EiuPkbSHp0ZDL/LGz3KVAgq9e27uRei
         nWehumEAgrVJj+D/p8r6qXFb82YSd/DDukWZrB19nNraeN5id4zO/QohqdjnY96nu7WN
         juEuhd35uskCT3iig+mny+RucYmbwHnq0IIRlY5mH4oRuEUG+t/97DBa7XDJWmh5q/4Y
         zHSw==
X-Gm-Message-State: ACgBeo3AFbloWJPy5dl1yLPVIN6eQe8OFUl33U47qt2Ch01uSiiB0E+M
	eg1AqCx8hT/k5O5DUAzL8Ic1aPF8FosYfpa6h0nMp/ajJZY=
X-Google-Smtp-Source: AA6agR6l2sJHi8Y/8CJVF6dK9+2tX591lLjtpjAsxc/WxVXBb+f+0W3IBGe3czGc1bcEh5J/CrtB1GKMIwUd5kr7Rjg=
X-Received: by 2002:a05:6870:8181:b0:127:806f:ab0b with SMTP id
 k1-20020a056870818100b00127806fab0bmr1608121oae.217.1662387536678; Mon, 05
 Sep 2022 07:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2209050952300.2731@hadrien>
 <20220905090915.3569051-1-jtojnar@gmail.com> <alpine.DEB.2.22.394.2209051246490.2731@hadrien>
 <CAFGSp1ud+X_xHa4zwhwPEzOvoC+4zwmONLi5HCQn76WHzfwoHQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2209051427090.2731@hadrien> <CAFGSp1umoczUe4npSesAUOLgSq=9VkvLUOV3x1hSvSajqQkGfw@mail.gmail.com>
 <alpine.DEB.2.22.394.2209051445570.2731@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2209051445570.2731@hadrien>
From: Jan Tojnar <jtojnar@gmail.com>
Date: Mon, 5 Sep 2022 16:18:45 +0200
Message-ID: <CAFGSp1vuGyiT86c7vq9MmYWaP06vRLo4OLQTREpHK_fw8vfEyg@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH v2] Exit with non-zero status when spatch on a
 directory fails
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 544
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/CAFGSp1vuGyiT86c7vq9MmYWaP06vRLo4OLQTREpHK_fw8vfEyg%40mail.gmail.com>

On Mon, 5 Sept 2022 at 14:51, Julia Lawall <julia.lawall@inria.fr> wrote:
> But Coccinelle is not so fast.  It would be unfortunate to run it for
> several hours on something complex, have it fail in one case, and get no
> feedback at all.

Unless the user runs it with --quiet, there should be feedback.
This patch only terminates it once all transformation happen so that
user can see all failures without having to run Coccinelle repeatedly.

> I think you want some python function that aborts in a more aggressive
> way, not to have that be the default behavior.

I would say that raising an exception is as aggressive as one can get
without interfering with user=E2=80=99s environment, like shutting down the=
ir computer.

We could limit ourselves to only e.g. FatalPycocciException and
catch any other exceptions. But I would again argue that any exception
already signifies an abnormal behaviour, and any spatch run where
one occurs should be considered tainted and the exception should
be resolved before user can continue.

> Most of the time when Coccinelle doesn't do what you want, it is because
> the semantic patch is doing something, but it is just designed in the
> wrong way.  Not because of something that Coccinelle will perceive as an
> error.  So I think that an exit error status is of limited usefulness.

Indeed, and there is not much we can do about those cases.
But here the code explicitly fails by calling raising a Failure (using
failwith function)
and will terminate immediately when working with a single file:
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/d5f94f9bdca5ba23aabf51=
5072fa7fe67239e221/enter.ml#L1362-1371
This behaviour implies that user is supposed to notice the failure,
yet with the current behaviour, it is easy to overlook it.

> But it could happen that some script code is written badly, such that som=
e
> input values cause a crash.  I'm not sure at all that that means that one
> doesn't want to see any information about all of the other cases where th=
e
> semantic patch applied.

Again, all the information is still there, only the changes are not written=
 when
`--in-place` or `--out-place` is used. We could move the exiting at the end=
 of
the main_action so that everything would be as before, except for exit
status code.

But I would say that when such failure occurs, all bets are already off and
users would need to clear the repo any way, as scripts that contain errors
are hardly guaranteed to be idempotent.

And I just noticed the exit code is still zero when running spatch in
parallel mode
but it is not clear to me why. Maybe the patching_failed ref is not accessi=
ble
from parmap created =E2=80=9Cthreads=E2=80=9D.
