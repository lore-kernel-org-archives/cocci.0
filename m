Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C8DC433EF
	for <cocci@archiver.kernel.org>; Wed, 11 May 2022 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=BOdn4w9CduEGfm9RTVgf4v0Sfp93Mvs/EUQREaa6n2k=;
  b=aa9X/w065cjfMyNw8S7x2qfnmfu/e60kP93BnIfhptm2EoC8Lsb53mUe
   GzZNTpOCQ2S+WP1QI2kWgtiXTLQyPmVAhJjz7VORj2+EqUYCj4y3BPzLq
   HE//8CFsoJtHqyBEDCDjSglviVtL3wjwRv7mtmvv++myJfr7B67UrLydf
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.91,216,1647298800"; 
   d="scan'208,217";a="35694046"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2022 09:38:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2A176E0269; Wed, 11 May 2022 09:38:58 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F3697E0098
	for <cocci@sympa.inria.fr>; Wed, 11 May 2022 09:38:55 +0200 (CEST)
IronPort-SDR: 29jsZvJ7JqUAdKoCmXL6mrHeDVDWYuSA1HQtsrPXZ2Z8ENNjsFSCJT5WrjqHLee/T60ytOLwUX
 91xV7V+FqcfGultISXokBXGX6SUNfP0LmqU+4umAsvvlJQbXf+c14D1UPw64m37z5y/l8PWlTw
 pyHVli8YPQuHdMnxmmG2eVxy3r4PubATXVqXRb3zot/8YrJVzsnrmFFAqPhGAkooqLVvqQ5cVg
 5zn8q6XAQUkoi50L5Zz74SyeRdsrmuZtudyGXEp2+p6f2k0GB6FPOe+eHUIIwiQDFzwJQL8Aby
 kHhnO3p3qiVGfzn5UojAMOfg
X-IPAS-Result: =?us-ascii?q?A0AdBQCIZ3tifyzZVdFaHQEBPAEFBQECAQkBgWaCIjMBg?=
 =?us-ascii?q?R4uBAtDhE6BI41DgiUDiyeBBYl4iDsLAQMBDRIBLwQBAYUCAoU+Ah0HAQQ0E?=
 =?us-ascii?q?wECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQ0LCQcICgcODgVgA?=
 =?us-ascii?q?WEDAUSBT4F0CwMxDYI1KQGDZAEBAQIBEhEdARsSCwEDAQsGBQs3AgIiAREBB?=
 =?us-ascii?q?QEcBhMbB4JbgmMBAw0kn2SBBEGLMoEVBReBAYIJBoRLChkoDWcDgVkCBxKBK?=
 =?us-ascii?q?gGGFoEkAQGHIycQgVVEgUuCPTc+iBqCZQSVIwQHAwQGAQYOAwMCEBQBAgEMJ?=
 =?us-ascii?q?iQPDwgFEgIDNAICAQELAgYGBAYDAQEGAwkCBAISAgIEBxgKEggUAwIGAiAFA?=
 =?us-ascii?q?QcFAQQDEgYMEQEKBgYBBAIKAQICBQUMAwERAQQCBgIEBAQYFAQCBAQFBgIJC?=
 =?us-ascii?q?AcFFgsECgIWAR0CAQYMCAICAgICBBUHAQ0FAgIEDwIHBgMLAgMFBwMDBAcMB?=
 =?us-ascii?q?gwOAQMBBwEEBQMNBAEBBgILAwUKAgECAwwBAQcECAEBAgIKAgEEAgcBAgUDA?=
 =?us-ascii?q?gMIAwIDAwICAQEEEQIDBAMEAgMBBgEBBQMCBQEDAwIBAwMDAgEEAwYJCgQIA?=
 =?us-ascii?q?QQEAQEBEQIHBwIGAwMCAgICBQECDQECAQIEAwgGAgMVAQIEAQoBBQIDCgIHA?=
 =?us-ascii?q?wEBAgcFCgIHBQIHAgIDAgEFAw0BAwUCAwEBAwMCBAECAQMDCQEDAgMDAgICA?=
 =?us-ascii?q?gUCAwICAgkDBAEHAwIBAQQFAQQDAQIKBAQDBAIEAgcCBwIEBwIBBAYDBwYBA?=
 =?us-ascii?q?wIBBwEBBAoEAwMDAQEHAQIFAgIDAgYSBgcCBAEDBAQKAgIMAgcBAQIBAQEBA?=
 =?us-ascii?q?gMCBwUOAQEBAwIDBgIFAgIBAQMICAMCAQQBBQMBBAUDBwIBBQkCCQMDAQgDA?=
 =?us-ascii?q?QEFAQMBCQMDAwIJAwECAgILBAMIAwMCAwQCAgICAQMCBwUIBAEECgICAgECA?=
 =?us-ascii?q?gIEAgEDGgECAwUCAgkMAQQCAgMBAwEBAggECQQCAwQCAQEDAgECAgEFAgMNB?=
 =?us-ascii?q?gEBAQECAwMBAgMBAQYHAggCMxYBAwMCAQICAgIFAgIBAgMCAg0BAQEEAgECA?=
 =?us-ascii?q?QIGAQMBAgIDAQMBAgIGAgwDCQIBBwEFAwMCAgMBAQUQAgQCAQQCAQIJBQIBA?=
 =?us-ascii?q?QEEAQMEBAgCAgEDAwIOAgQBBAECAQEjAwQCAwICAxcBAgECAwMDBAYHBgIBA?=
 =?us-ascii?q?hMBAgEBAQUBAgEBBAIEBAcKAwICAgYDAwUBAQIDAgEBAQcMAgICEwIECgkDA?=
 =?us-ascii?q?QYBCgYGFQMCBAICAQICAgoDAQICAQMCCQIBAgEFJQMBAQ8kAQECAgECAgMEB?=
 =?us-ascii?q?wIBBAcDDQMCAQEBBQYNAwIDCAwCAwsDAgEDAwUBAgICBAECBAwKAQIDAQICB?=
 =?us-ascii?q?AUFAwMCAggGBicBAQVnA5ZrRBY7MByBJRkgIZJvjgygCjQHg0yBOwYMnjcxg?=
 =?us-ascii?q?3WMOpgklmOnEhAjEoFDgX5NI1AxgjdOAQIBAQENAQIBAQMBAgECCQEBApIPi?=
 =?us-ascii?q?mBCMTsCBgEKAQEDCY0HAQE?=
IronPort-PHdr: A9a23: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
 PaR
IronPort-Data: A9a23:ke83NqOvZjcifRHvrR1xkcFynXyQoLVcMsEvi/4bfWQNrUor0mcBz
 DNKD22OOP2IZ2OjfNh+Po/j8R4BvcXRyYRhHHM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EsLd9IR2NYy24DkWlrV4
 LsenuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB3Ohc1M2
 Y9xqKWgbiQUEavylcBAcVpHRnQW0a1uoNcrIFC6uM2XilPdKj7in6koA0YxMokVvO1wBAmi9
 9RCcGFLPk3F3bvphu7nIgVvrpxLwM3DNYcSoWppyz3DCrAtSIrGQqPD+d5w0zI5h8QIFvHbD
 yYcQWM0M0mdOUceUrsRIMMzn82IuUHcSCB3qm++iYwM+1jx6xMkhdABN/KMIoDQLSlPpW6cr
 33P+2DREBAfPsaWjzuD6HOlwOHV9QvwX4kZFZWj5/tyiRuSwHYSAVsYTzOGTeKRj0e/X5dBM
 BVR9HZy66c180OvQ5/2WBjQTGO4UgA0HMBNLvxg1By02o333imfOGUgExwCd4lz3CMpfgAC2
 liMltLvIDVgtryJVH6Qnot4SxviaED5ykdSNUc5oRs5D8rL+95s00qeJjp3OOvk0Y2vQGCYL
 yWi9XBm390uYdg3O7JXFG0rbhqpr5nNCxAuv0DZAj7j4QR+a4qoIYev7DA3DMqszq7JEjFtX
 1Bew6ByCdzi67nTz0Rhp81TRtmUCw6tamG0vLKWN8BJG86R03CiZ5tMxzp1OV1kNM0JERewP
 hKJ41sOuMQOZir6BUOSX25XI5R7pUQHPYS1Ps04kvITCnSMXFTao3kxPRD4M57FyRF0wflX1
 WinnTaEVC5GU8yLPRK5QOAS1bJD+8zN7TK7eHwP9Dz+ieD2TCfNF98taQLSBshksv7siFiKq
 753aprSoz0CAbaWSnSGoeY7cwpWRVBlXsueg5IMJoa+zv9OQj5J5wn5muN/JeSIXs19yo/1w
 51KchUGlwCj1SaXeW1nqBlLMdvSYHq2llpjVQREALpi8yFLjV+H4PhNep0pU6Mg8eA/n/d4Q
 +NUKcqFC/VLDD/A/m1FP5X6qYVjcjWthB6Pb3L1OmhhI8Y4Slyb4MLgcyvu6DIKUXi6uM44l
 LuqiVHWTJ8FcAJ9AZuEc/mo1V6w4SMQlbsqDUvFK9VeYmv2941uJ3Cjh/M7OZBeJhDKxz/c3
 AGTWE9Kqe7Iqo4z0d/ImaHU99fzQ7UiRhJXRjCJ46y3OC/W+nuY7bVBCOvYLyrAUG7U+bm5Y
 boHwvz5NsoBlgkYvod5FYFt0vtitdbiorltzjNkEm/OWFKlB+4yOXKBx8RO6vRAy7IF6wu7X
 kWDpotTNbmTYpi3FVcQIE87db3G261I3DbV6vsxLQPx4youpOiLVkBbPh+tji1BLesqbNl0n
 7954MNGuRaijhcKM8qdinwG/Wq7KHFdAb4ssYsXAdO2hwd3mEtOZ4fQVn3/7J2VMY4eN0ArJ
 nqKn/OHiegAgEXFdHU3GD7G2u8E3cYCvxVDzVkjIVWVm4qa2qVmgkUJqTlnHB5Iyhhn0v5oP
 jQ5PUNCI6jTrSxjg9JOXjzxFgxMbPFDFpcdF7fUeKzlo0iUuqjlKWQ8PaOT5xlc/T4AODdc+
 76cxSDuVjOCkAQdGMctcRYNlhAhZYUZGs7+dASPEMGMHp18aj3g6kNrTXRdsAPpWKvdm2Wez
 dSHP49MhWnTOisZoql9AI6fvVjVpNZoO0QaKcxcEGg18a0wtd18NfVi66x8Ry+VG8H3zA==
IronPort-HdrOrdr: A9a23:JC1JI63DFGOSDohQBG6/mwqjBN0kLtp133Aq2lEZdPU1SKylfq
 +V8cjzuSWatN9zYhAdcK67UpVoKEm0nfVICOIqU4tKMjOLhFeV
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,216,1647298800"; 
   d="scan'208,217";a="13755229"
X-MGA-submission: =?us-ascii?q?MDFnwCPqejhVuTpqUNvcluJ9r3txOrFjDudNkX?=
 =?us-ascii?q?qe0PWcO0wfYwuiihgIdq68zYTviVt17DRvnGvluSeKezLxTfYeRNUd51?=
 =?us-ascii?q?0a6APIgTB64saB1HRkkiTUqbKQAMLBOIcTkhLyDXt58suNtW3f+AO651?=
 =?us-ascii?q?u46zkyqC14/KGcO7TUKF35vA=3D=3D?=
Received: from mail-vs1-f44.google.com ([209.85.217.44])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 09:38:54 +0200
Received: by mail-vs1-f44.google.com with SMTP id x8so1092969vsg.11;
        Wed, 11 May 2022 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOdn4w9CduEGfm9RTVgf4v0Sfp93Mvs/EUQREaa6n2k=;
        b=DFLbJpK8HWx+14r8HUHF7PlRyqXd0SQckNJr2ZGb7QxWlavJlak7UzhyEOFgFOJucS
         pgeOWFWmPkjJDGbHQMxWjjwmXZaZ95wFM9GQ0peSEG7ovx6AKpHzFF16n7ymy1hRn6YM
         dvb/DiMe/Pxylc9BusLGPUkKsikbBdjJ+nkO6eEEsoKP18WBqEfvWda1+USAe6XHK0My
         MNVMkIsBmPaDgfbNiB6mx6tAIWkPGKLj1eC7tXRKw83fOmkTu2OKHPZyM0WQJhceT2yo
         aYxzU8cFr4lK6ZyaG7oAbvz+snO1p121O3NDtGn8wzpmFaFlc3ZRJ5sMdjADrg5gK+cD
         ba6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOdn4w9CduEGfm9RTVgf4v0Sfp93Mvs/EUQREaa6n2k=;
        b=wlS8iIBgEXk7Uo50hHd+4EvbIv+LpJdrrRuDQqy1l/78d99PL17asvc912O9XGQ71T
         59PW9CoceqFVGSs/3omTYzsIxf26vtHvR5Tr/1ZVE2dOGdTxjtSed4a+OVTe9dIOMs3o
         qWl+nCSAgpKhd2tCwfFxC5f4mxrdG9yDD7cDvhe+PB9j/z1kqRcLkfj9ddGYADFIUtwG
         qOji2bXAAteStx+OVUvDt+nH5Bl0ef7ced4LQsdJARpbZVo/z1Gcwr0QwE9m2jwLUHyO
         EtWQ/2IlyahBF3zvfajnTcgAyz/rGSJpy9EG0nZUiVWjYzGEn8l51TrXVqXKHlWymPev
         Ux6A==
X-Gm-Message-State: AOAM530SFqQaG9PnvjHoyVFsL8QNlpLJ0B8MQ/U9EGsOWzqHPMLQbeFT
	SNeWWZk/m7dPzVszp2RnmsqQXsqav9KMW5VwNtcZGK9yZyc=
X-Google-Smtp-Source: ABdhPJyKveRyjh9tRUcW4A6fn3QBUKfrMwyPRebakfGR4K8PSQpGVngUtn1daZFy6+GX3llbyzqOoHKfdab64Tfiaiw=
X-Received: by 2002:a05:6102:508b:b0:32d:4378:93c3 with SMTP id
 bl11-20020a056102508b00b0032d437893c3mr12927061vsb.30.1652254733037; Wed, 11
 May 2022 00:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
 <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de> <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com>
 <alpine.DEB.2.22.394.2205100957160.2667@hadrien> <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101123120.2667@hadrien> <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101236050.2667@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2205101236050.2667@hadrien>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Wed, 11 May 2022 09:38:17 +0200
Message-ID: <CAPp5cGQzYtDVjE-K_Vpt3cbqYW-cwNTLmt_KwdpMdds9L7rXug@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: multipart/alternative; boundary="00000000000070f16d05deb78868"
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Alessandro Carminati <alessandro.carminati@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 378
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/CAPp5cGQzYtDVjE-K_Vpt3cbqYW-cwNTLmt_KwdpMdds9L7rXug%40mail.gmail.com>

--00000000000070f16d05deb78868
Content-Type: text/plain; charset="UTF-8"

I'm planning to stop bugging this mailing list, but before that, please
allow me a final question. That is related to what I have done so far.
My current implementation is the following.
```
@excluded@
type T;
identifier i;
position p;
@@

(
 T i@p(...);
|
 extern T i@p;
|
 T i@p(...,......);
)


@r@
type T;
identifier i;
expression E;
position q != excluded.p;
position p : script:python(i) { p[0].current_element == i};
attribute name __randomize_layout;
@@

(
 T i@q@p;
|
 T i@q@p=E;
)

@rr@
type T;
identifier i;
expression E;
attribute name __randomize_layout;
@@

(
 T i;
|
 T i=E;
)

@script:python@
i << excluded.i;
@@
print (i)
```
It is a suboptimal version of Julia's last proposition.
It happens that in a file a statement I expect to be matched is not
detected.
Troubleshooting the issue, I see a behavior that does not fit the model I
have in my mind. This suggests to me that things (coccinelle under the hood
mechanisms) are more complicated than I think.
back to the point:
Running the script and printing only the rule "rr", which is the same as
"r" without positions, the results presents a set of entries containing the
entry I'm interested in.
Running the same script but printing only the rule "excluded", I see that
the result is an empty set.
Finally, running the script using only the "r" rule, the entry I'm
interested in is not there.

Surprisingly (for me), removing the position constraints coming from the
rule "excluded" (position q != excluded.p;) from the rule "r", the entry
appears.
My question then is the following: How can the rule "excluded" that
presents an empty set influence the rule "r"?
Speculating Julia's words on a previous answer I got, I guessed that
somehow an empty set could be treated differently, so I added a line into
the target c file to make at least "excluded" match one line. But it didn't
make any difference.

Alessandro



Il giorno mar 10 mag 2022 alle ore 12:39 Julia Lawall <julia.lawall@inria.fr>
ha scritto:

> Here is a suggested solution for all of the problems reported so far:
>
> @r@
> type T;
> identifier i;
> expression E;
> position p : script:python(i) { p[0].current_element == i };
> attribute name __randomize_layout;
> @@
>
> (
> T i(...);
> |
> T i(...,......);
> |
> extern T i;
> |
> T i@p;
> |
> T i@p=E;
> )
>
> @script:python@
> i << r.i;
> p << r.p;
> @@
> print (i)
>
> ----------------------
>
> The problem with __randomize_layout is that the Coccinelle parser is not
> recognizing it as an attribute.  You can force that by putting a
> declaration in the semantic patch.
>
> It seems that ... in a function parameter list does not match the ... in C
> for a variable list of arguments.  That ... can be matched explicitly by
> ...... so I have added another case with that.
>
> I als combined all of the patterns into one rule.  By inheriting the
> position varaible p into the python rule at the end, that python rule is
> only executed if p is defined, which makes it select the cases of interest
> and ignore the others.
>
> julia
>

--00000000000070f16d05deb78868
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;m planning to stop bugging this mailing list, but be=
fore that, please allow me a final question. That is related to what I have=
 done so far.<br>My current implementation is the following.<br>```<br>@exc=
luded@<br>type T;<br>identifier i;<br>position p;<br>@@<br><br>(<br>=C2=A0T=
 i@p(...);<br>|<br>=C2=A0extern T i@p;<br>|<br>=C2=A0T i@p(...,......);<br>=
)<br><br><br>@r@<br>type T;<br>identifier i;<br>expression E;<br>position q=
 !=3D excluded.p;<br>position p : script:python(i) { p[0].current_element =
=3D=3D i};<br>attribute name __randomize_layout;<br>@@<br><br>(<br>=C2=A0T =
i@q@p;<br>|<br>=C2=A0T i@q@p=3DE;<br>)<br><br>@rr@<br>type T;<br>identifier=
 i;<br>expression E;<br>attribute name __randomize_layout;<br>@@<br><br>(<b=
r>=C2=A0T i;<br>|<br>=C2=A0T i=3DE;<br>)<br><br>@script:python@<br>i &lt;&l=
t; excluded.i;<br>@@<br>print (i)<br>```<br>It is a suboptimal version of J=
ulia&#39;s last proposition.<br>It happens that in a file a statement=C2=A0=
I expect to be matched is not detected.<br>Troubleshooting the issue, I see=
 a behavior that does not fit the model I have in my mind. This suggests to=
 me that things (coccinelle under the hood mechanisms) are more complicated=
 than I think.<br>back to the point:<br>Running the script and printing onl=
y the rule &quot;rr&quot;, which is the same as &quot;r&quot; without posit=
ions, the results presents a set of entries containing the entry I&#39;m in=
terested in.<br>Running the same script but printing only the rule &quot;ex=
cluded&quot;, I see that the result is an empty set.<br>Finally, running th=
e script using only the &quot;r&quot; rule, the entry I&#39;m interested in=
 is not there.<div><br>Surprisingly (for me), removing the position constra=
ints coming from the rule &quot;excluded&quot; (position q !=3D excluded.p;=
) from the rule &quot;r&quot;, the entry appears.</div><div>My question the=
n is the following: How can the rule &quot;excluded&quot; that presents an =
empty set influence the rule &quot;r&quot;?<br>Speculating Julia&#39;s word=
s on a previous answer I got, I guessed that somehow an empty set could be =
treated differently, so I added a line into the target c file to make at le=
ast &quot;excluded&quot; match one line. But it didn&#39;t make any differe=
nce.<br><br><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=
=3D"ltr">Alessandro=C2=A0<br><br><div style=3D"display:inline"></div></div>=
</div></div></div></div></div></div><br></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il giorno mar 10 mag 2022 all=
e ore 12:39 Julia Lawall &lt;<a href=3D"mailto:julia.lawall@inria.fr">julia=
.lawall@inria.fr</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Here is a suggested solution for all of the problems r=
eported so far:<br>
<br>
@r@<br>
type T;<br>
identifier i;<br>
expression E;<br>
position p : script:python(i) { p[0].current_element =3D=3D i };<br>
attribute name __randomize_layout;<br>
@@<br>
<br>
(<br>
T i(...);<br>
|<br>
T i(...,......);<br>
|<br>
extern T i;<br>
|<br>
T i@p;<br>
|<br>
T i@p=3DE;<br>
)<br>
<br>
@script:python@<br>
i &lt;&lt; r.i;<br>
p &lt;&lt; r.p;<br>
@@<br>
print (i)<br>
<br>
----------------------<br>
<br>
The problem with __randomize_layout is that the Coccinelle parser is not<br=
>
recognizing it as an attribute.=C2=A0 You can force that by putting a<br>
declaration in the semantic patch.<br>
<br>
It seems that ... in a function parameter list does not match the ... in C<=
br>
for a variable list of arguments.=C2=A0 That ... can be matched explicitly =
by<br>
...... so I have added another case with that.<br>
<br>
I als combined all of the patterns into one rule.=C2=A0 By inheriting the<b=
r>
position varaible p into the python rule at the end, that python rule is<br=
>
only executed if p is defined, which makes it select the cases of interest<=
br>
and ignore the others.<br>
<br>
julia<br>
</blockquote></div>

--00000000000070f16d05deb78868--
