Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB09C7619A
	for <cocci@archiver.kernel.org>; Tue, 11 Apr 2023 11:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rXRE+eSh2Nq3WZT4zcqvNzAngJK2UdFNOyUaX65fdH8=;
  b=GosduE4nwgI/vwNFrWEvTYL8Ve+CY3HxIXEjwhzKPj/iqZ3dlNDRr4r8
   7VKBVzdE2B4L9hROHoG3fwrfyS4AbJBoAZXZ40EQF2UWp2+5MkEMn6RJx
   Q+iJhHzYG7CmM5WMcROEJJBeX9ItbOzS53heo0+9DfiU89GzQieMIJdOL
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102411426"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2023 13:02:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3BD12E7329; Tue, 11 Apr 2023 13:02:47 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 76B63E72F8
	for <cocci@sympa.inria.fr>; Tue, 11 Apr 2023 11:47:26 +0200 (CEST)
IronPort-SDR: 64352cad_tMsDBPUppUvoqK5tHJcz6K14lM0MN75QdGkevTXKJ+HV8cZ
 ETtaVfkMnw0B6ceOw6Uzt3kv4LJD2pggIy9qwRw==
X-IPAS-Result: =?us-ascii?q?A0HbAgA8LDVkfzaAVdFaHgEBCxIMQIFEC4IudVYvBFGEU?=
 =?us-ascii?q?40mgkAGgUSJGYIVLQWRfYFAFigPAQMBCwEBPQUCBAEBAwSEfwKFPQIdBwEEM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABARkJGQcODgUkh?=
 =?us-ascii?q?WgNgjcpARFkTQM4AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQQCDQcYOQEfAQEBAxIRBAsBDQEbDw4BAwwGBRgCAiYCAiMRAQUBHAY1g?=
 =?us-ascii?q?lwBgicBAzEBAgcJnzqBBEKLM38WBQIWgQGCCQaBQQGaSgoZKA1sgVsCAQYJA?=
 =?us-ascii?q?QiBAi2EOyNSjAgCJ4EYgRCBPIJTMD6CYgQBF4Fbg0aCZwSOZYptAQMCAgMCA?=
 =?us-ascii?q?gMGBAICAgUEAgEDBAIOBA4DAQECAgEBAgQIAgIDAwIIDxMDBwIBBgUBAwECB?=
 =?us-ascii?q?gQCBAELAgUCCgECBAECAgIBBQkBAwEDAQwCAgcCAwUGBAIDDQIBAQMCAgINA?=
 =?us-ascii?q?wIDAgQBBQUBARACBgQHAQYDCwIEAQQDAQIFBwMGAwICAgIIBBICAwICBAUCA?=
 =?us-ascii?q?gIBAgQFAgcGAgECAgIEAgEDAgQCAgQCAgQDGwIDBQMOAgICAgEJCwIDBwQCA?=
 =?us-ascii?q?wMBBwICDAEDGAMCAgICAgIBAwcKBAsCBQECAQQLAQUBDQQCAgICAgMCAQEDB?=
 =?us-ascii?q?ggBBQMKAgUEAwMGCQ8PCAUDAQQDAgMCAQgJAgMCAgQIAgMBAgIBBgIDAQICA?=
 =?us-ascii?q?QICAQsBAQIDBQICEQECAgICAgEBAgMCAwEHAQICFwYEBQMDBAICAQQBAgIEB?=
 =?us-ascii?q?AULAgQDAQEBAgICAgMCCwMFAwEGAwMKAwQEAQgCBQMEAgUEBQQGAgICAgIBB?=
 =?us-ascii?q?AEECQMCBAQDAwYDCQICDAIUAgMPBgEECwsEAQICAg0DBAYCAwMCBQgEAgICA?=
 =?us-ascii?q?gIDBgIHBAICAgEDAgIDAwcDAQICAgMBBAUGAwIEAgEDAgQCAgYDBAEHAgICA?=
 =?us-ascii?q?gMBAgIDAwECAQYDAgIFAgIBCAIDAgICAgMDDgEBAQIKAgMBAQEFBAICBAQEB?=
 =?us-ascii?q?AECAgICAgwDAgICAwIEAwICAxIDAgUCBAwBAgQCAgYCAgICAgICAgECAgICA?=
 =?us-ascii?q?wUEAQIDAwIEBQMDAgIDAgIFAQMEAQcEAgIGAgIFBgICBQEDBAECAhIDAwMCA?=
 =?us-ascii?q?gIBAgEBAgMHCQYCCQEYAwIEAgUDAgIDAgIBAgcCAgMCAgICAgQCCAIFBQIOA?=
 =?us-ascii?q?gICAgMCBBEEAgQHBAIGAgQDAgMCAwICAQYCAgMDDQEBAgECAQUJBQEGAQIBA?=
 =?us-ascii?q?gMEAwMDCwYKDwMDAiADRB0CCQMjDwIBCwkIExcoBgwHMAQEDCgBCQsRBwcwD?=
 =?us-ascii?q?QEEAgIGAwQBCgUGBQQDAggBAgEBBgIEAgcJDAIBAgQBBQICAwIBBQIBAgQDA?=
 =?us-ascii?q?QICAgIFCgMEAQQDEwMBAQQDAgECAQIDAgMHAwIEAgMBAgMEBgYBCQQGBAENA?=
 =?us-ascii?q?wQCAgECAQEDBAQEAgIBAgIDAQQCAgEBAwMDAgICAwQCAwMLBAkHBAIBBQsCA?=
 =?us-ascii?q?gIDAgEDAQYEBQQCAgYBAgQCAgICAgIDAQEDCQQCAQMCAgQDBgIBAgEJBQIBC?=
 =?us-ascii?q?QMBAgECAQQBAwkBAgIECQIEBwUKAgICAggCAg4DAwIBAQQCAgQDAgkBAgcCB?=
 =?us-ascii?q?QEBAwUHAgIBAgIBBAMBCQQBAgMCAQEDEgMDAQQCBQMDFQYCAgEDAgENAwECA?=
 =?us-ascii?q?QIDAQUFFwMIBxQDBQICBAQBBwICAwMDAgECCQYBAwEFAg4DAgIEBgECAQECA?=
 =?us-ascii?q?w8CAwEBAQEXAQMEAgMBBAMBAQIBAgMPBAEEBQwDHAIEAQgIAgIDAwECAwUBA?=
 =?us-ascii?q?gMEAgEIBgQCAgICCQIKAwIDAQMFAQMCCQMBBQECBwIGAQEBAgICBgIIAgMLA?=
 =?us-ascii?q?QMCAwYCAQICAQUCAQICBQMFAgICAgQNAgUCAgIFAQIHBAICAgMBAgIGBQECB?=
 =?us-ascii?q?wcCBQICAgMDCgQEAgoEAQEBAgEBBQECAQMDAQQBAgECBQMGAgICAgECAgEBA?=
 =?us-ascii?q?QgCAgICAgIDBAIFA5wEgV2CLIFFGoEYVgEBomKfWCEJAQYCXYFdgQIaKotyl?=
 =?us-ascii?q?QAGDwQvlwkMki2Xc41TlF+FRAIKBwYQIxKBLjqBSA0HTSOBboFJEzwDGQ+OI?=
 =?us-ascii?q?DeDO2qPEj40AjsCBwEKAQEDCYVDJhOFSQEB?=
IronPort-PHdr: A9a23:8IcuaBQPUrbUlc1ZSdwPjxRWDNpsotWWAWYlg6HPa5pwe6iut67vI
 FbYra00ygOTAMOBu64P0ruempujcFJDyK7JiGoFfp1IWk1NouQttCtkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhEmjqwbalsI
 Bi1ogjdudQajI9/Iast1xXFpWdFdOtRyW50P1yYggzy5t23/J5t8iRQv+wu+stdWqjkfKo2U
 KJVAi0+P286+MPkux/DTRCS5nQHSWUZjgBIAwne4x7kWJr6rzb3ufB82CmeOs32UKw0VDG/5
 KplVBPklCEKPCMi/WrJlsJ/kr5UoBO5pxx+3YHUZp2VNOFjda/ZZN8WWHZNUtpUWyFHH4iyb
 ZYAD/AZMOhWr4fzuUUDowa9CwmiC+zg1iJHiHD00qAhz+QsEhvL0BA8E94SsnnZqsj+OqcIU
 eCyyanF1TvNYOlQ2Tzg9oXHaAohoemSUrJ2bcre11MvHB7Cg1qOs4zlJTSV1v4Tv2WZ9OdgW
 uevhHQmqwF1uDSg2sAsiozQi48T11vL+jl3zpwvKt2kVE50f8SkEJ1IuiyHM4Z7X8wsT31pt
 Ss417ELpZy2cSsUxJk52hPSdeCLfYeW7hztSuqfLzd1iXBrdr+8hxu/7Eiux+P9W8S6zFpHq
 DdOnNfLtnAIzRPT686HR+Nm/ke9wzmAywPT6uZaIU8qj6rbJZohwrk+l5YJrUvDGSr2lF3qg
 6+ObkUk4Pan6+r5bbX8uJCcMZN7hR/kPqsyncy/BPw0PRQLX2iG4+izyqDs/VD/Tb5XjfM2i
 rHUvI7GKckfvKK0AA9Y3pw+5xqhDDqqytQVkHYfIF5YZB6LkZLlNl/PLfziE/uznUqgnC12y
 /zbILHsBIjGIGLZn7f7Z7l97lZRyAotwtBb4JJZErQBL+jyWk/1rdDZABo5PxGtz+bpCNhw2
 ZkSWW2IAq+eP6PStUGH6vgzLOmLYY8ZoDf9K/476P7ylXI1h0MRcK2z0ZYUaH20BOlqL1uab
 Hb2gtoMHn8Gvg8kQ+zrjF2CXyRTZ3G3X68k+D47EpimDYDZRoyzgrGMxyi7HphMaWBHDlCAC
 2vnd4KBW/sUbiKdOddukiYYWri5V48hyRauuRfkx7Z/NOrb5jUYtY7/1Nhy/+DTkQs99DJuA
 MSZ12GAVGB1nmINRzAtxqBwu1ZxylaF0ahigvxXD8Zf5/1TUgsiL57T0/R6C8zuWgLGZtqGV
 FGmTcm6DjEwVd8x2N8PY0NlG9q4lBzD3iyqA6UUl7ORHpA0/LjcjDDNIJNf1nLH3eEFhkYvR
 s8HYW+7gq92sQzaGIfNl22YkbyrfOISxnie2n2EyD+itUcQewdqSajDQX0FLh/bt87+/BmdZ
 7CrALUjdABGzJjReeNxdtT1gAAeF7/YM9PEbjf0wj/obf7p7raFbY6xPn4YwD2YE08c1QYa4
 XeBMwE6QCanuWPXSjJ0Rhr0e0251+54pTugS1MsiRmQZhhszaCy4ERKrfOZQvIXmLkDvXRps
 C16SW60xMmeEN+cv0xkdaRYb8k65QJKz3jerVYiFpOlJqFmwFUZdlc/pFvggjNwDIgIis02t
 DUqwQ51fLqfy09EfiiE0IrYP7TWLizt+UnqZfOKnF7Z19mS9+EE7/FQR0zLmgavGwJi9nxm1
 4IQyH6A/tDRCxJUV5vtU0Ex/hw8prfAYyB76ZmGnXtrebK5tDPPwbdLTKMs1wqgctFDMaiFC
 B66EssUANKrIfArnF7hZwwNPeRb/qo5d828cP7O1KmuNedm1DWo6AYPqI1nyEWWrXVURevB3
 pJDyPadn0OGWzr6kFa9o5Xvg4kXLToWH2e51W3lHNsLPvw0LdtNUD3+ZZDrlbAcz9b3VnVV9
 UCuHQYD0c6tIl+JakDlmBZXzQIRqGCmni2xy3p1lSsop+yRxn+roayqeRwZN2pMXGQng03rJ
 N3+gsoAW1LyMCAmkRKk4QDxwK0R98EdZyHDBFxFeST7NTQoX7GqsaDYPOZA7ZoptWNcV+H2M
 hiKD7X6pRUdySbqGWBTkSs6ez+dsZL8hxVmiWiZIR6ftVLhcNprjVfa7d3YHrtK2yYeATJ/k
 X/RD0S9ON+g+ZOVkY3Cu6awTTDpWppWeCjthYSO0UnzrWBwGxqlxa+bldjuEAx82ij+n9VnT
 iTHqh/gb5Kjjfzrd7I6OBAyVBmht4JzAclmn5E1hY0M1HR/5N3d5ncBnWrpcJ1a1a/4cHsRV
 GsOyt/R7hLi3R4rJXaIyoTlE3SFl5E5Np/qPyVPgHJ7spwZbcXcpKZJliZ0vFei+AfYYPwm2
 ywY1eNr83kCxecApAsqyCyZRLEUB0hReyL2xHHqp5izqrtaYGG3fP2+zk17yJqsFquFuFsDc
 Hn8c5YmWyR3648sVTCEmG228YzidNTKOJgerAeTiU2fp+dQIZM10PENgGA0cXK4tnojxekhi
 BVo1pzvp4mLJVJm+6ehCwJZPDn4NKZxsnn9yLxTlcGM08WzD41sT38VCYDwQ6viQ3oC8O7qP
 AGUHHggp2eHTPDBSBSH5h4DzTqHEoj3ZSrKYiBIlZM4GEbbfAsF3EgVRGlowMJ/TFvxgpW/K
 AEhoWlArl/g9kkSlKQxb0O5CiGH413wD1V8AJmHcEgIsEcYuxaTYZTYtqUpR2lZ5sHz81bLc
 zDdPlUSSzlOAxzMBki/bObyo4Carq7AQLL5dqWrA/3GqPQCBa7QldT2jdQgr3DUcZ/Wdnh6U
 69ihREFBCElXZyfw3JWFWQWj36fNZbK4kfhvHQt/obnt620PWCnrYqXV+kIaIsppkDw2PbZc
 bbX3XcxKC4EhMlVmzmSk+lZhwRU02Y3JnG7GLAE/0YhVYr2nalaR14eYiJ3b45T6r4kmxJKI
 Yjdg8/00bhxirg0DU1EXBrvgJPhY8tCOGy7OF7dYSTDfL2bOT3Gxd32aqKgWPVRiutTrRi5p
 TecFQfqID2CkzDjUx3nP/tLiWmXOxlXuYf1dRgIayCrVNX9dhiyK8N6lxUzyLwww2zPbCsSb
 GQ6fERKobmdqyhfh7Q3GmBM6GZkMfjRmyud6Lq9SN5euv9qDyJo0uNCtS5imv0FsWcdHqwzx
 XeBy7wm60urmeSO1Dd9BR9HqzIQwZmOoV0nIqLBsJ9JRXfD+hsJq2SWERUD4dV/WbiN8+hdz
 MbCkKXrJXJM6dXRqIERHdLTMpjYGHUkOBvtXjXTCUFWKFzjfXGanEFbnPyIozeNqYMmr5H3h
 JcUYrpSVVhwCfZDT0o4QJoNJ5B4Wj5imrmexp1thzL2vFzaQ8NUuYrCX/SZDKD0KTqXurJDY
 gMB3bLyKYl73mjT1Elra108l4PPSRK4tTFlpyRgakorpRwI/iUiCGI03E3hZ0Wm53pBTZZcc
 TY5jwJ/ZaIm8zK+uj8K
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:6qlrzq5dzdZCmmCAfAPXwKvXdLJyesId70hD6qkRc3Zom6Oj+f
 xG8M5x6faLslkssQAb9OxoUZPoKU80nqQY3WB+B9aftXHd2FeVEA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="53067766"
X-MGA-submission: =?us-ascii?q?MDHXwvM14s2Nw2tTrETqiHOsfZjI5GP5zdW7oI?=
 =?us-ascii?q?5LxmAmexFV2nKal08DABzLFTQ7XmNvv4PSzNh1oHdYBNBQ6sExftVL+P?=
 =?us-ascii?q?2uQTKjPw/J3StO2w6/ceAmL9UzO54PGmQ4lrhFvuDv4pNTtR6NfWpopl?=
 =?us-ascii?q?QSrt+J2+UGes29E+mOusJ/rA=3D=3D?=
Received: from mail-wm1-f54.google.com ([209.85.128.54])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 11:47:25 +0200
Received: by mail-wm1-f54.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso9211415wmo.0;
        Tue, 11 Apr 2023 02:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681206444; x=1683798444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rXRE+eSh2Nq3WZT4zcqvNzAngJK2UdFNOyUaX65fdH8=;
        b=PI5NV11eigg6FHKuEp1lqhWpqge4bHq5zaUmYoSFyCEliYtHAZS5+722ed4gCYTtCk
         sY2+BkkOpU6ziLxRG3r+BTEbm6VIyBs+/O9khkqajAFyBta2EMg5qCjVXQXl22q1zJK2
         iB8DI1zmfdIhfb5XeyTazMKjkZuCHNSciNTlOyTWMLWgnNjVeb+cMtgl0QfiedGXWgv/
         mn0bbEMogFhDrcuGE/Wa9BjRMKlEu8I+5aJBOSvQCHl+TVRGIYISQdnRBr7f+rlDqCcm
         07cQo2Vpd9YgXUrvJkqyRq9u6cPax21/QqBJhN8KJVAQKTwyr5FU9NeuJsaYzsTmQRO8
         C08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681206444; x=1683798444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXRE+eSh2Nq3WZT4zcqvNzAngJK2UdFNOyUaX65fdH8=;
        b=llmHGZxGn/rMcDctbMd34BT9T1oRz0rH5sMwMhXxZjqHEhk5qqSFj9Z3TeWNz0aowf
         zZAWwEJvCBwsT0AFJeO2OKZGJNPHFIOUzRQwo5nqpZAbWua0GtUbn5pConYq08OUXIzt
         PrQ6iDeArO5igYLfa8VgV5X8cWlN80ha26DejIdLmq7ngI3HtREw/JlvAC5Mla277UKu
         RqycZ/8ysf1Aus9e7DOCeIDmtjZMjFZFm6H0ddN/RVvcy2WycFpBHMhgSCxAdX7rB3Sg
         k/gTeBUDxerd1YZHn70lWwLo5+aRs8oFd1cpybC6dNS/aOX9VtYQFB6LLnMAIzAAitgo
         Mq2A==
X-Gm-Message-State: AAQBX9dMQj9vmAcgAJ9r3AYv6sNwDjk0uUgl/JrtRMQfZSiP4VAJfmQ7
	XmloEhZTANKx+yMInttddPeD90bydzk=
X-Google-Smtp-Source: AKy350bZU53wq9AF95CcsWhg5q8T/32TDbk4POP9TzetPYVgjU8iYnRW/urX8YpORQ7EH4BKM/Zt8w==
X-Received: by 2002:a05:600c:3787:b0:3ed:29d9:56ae with SMTP id o7-20020a05600c378700b003ed29d956aemr9070956wmr.6.1681206444469;
        Tue, 11 Apr 2023 02:47:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p15-20020a1c740f000000b003edc11c2ecbsm16531341wmc.4.2023.04.11.02.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 02:47:24 -0700 (PDT)
Date: Tue, 11 Apr 2023 12:47:10 +0300
From: Dan Carpenter <error27@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr,
	kernel-janitors@vger.kernel.org
Message-ID: <11c630fb-8c17-425c-82fb-becdb90cfbe2@kili.mountain>
References: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <alpine.DEB.2.22.394.2304092044020.3028@hadrien>
 <95caa4c1-2455-2733-ef4b-3ab07783c725@web.de>
 <alpine.DEB.2.22.394.2304100824510.3387@hadrien>
 <2de88997-0732-d0dd-5178-f9d42b5a3be5@web.de>
 <alpine.DEB.2.22.394.2304100959310.3387@hadrien>
 <31b51efc-afbe-ec34-255e-9df60983ec3d@web.de>
 <alpine.DEB.2.22.394.2304101415040.2875@hadrien>
 <5defca25-d893-f61a-ec24-aa99ba39d8a7@web.de>
 <4d2383c7-b923-31a2-2c26-7b34b3b13c7@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d2383c7-b923-31a2-2c26-7b34b3b13c7@inria.fr>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Reconsidering pointer dereferences before null pointer
 checks (with SmPL)
Reply-To: Dan Carpenter <error27@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1027
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/11c630fb-8c17-425c-82fb-becdb90cfbe2%40kili.mountain>

On Tue, Apr 11, 2023 at 09:40:23AM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 11 Apr 2023, Markus Elfring wrote:
> 
> > >>>> https://stackoverflow.com/questions/25725286/does-taking-address-of-member-variable-through-a-null-pointer-yield-undefined-be
> > >>>> https://en.cppreference.com/w/c/language/behavior
> > >>>
> > >>> The statement:
> > >>>
> > >>> "... &((*ptr).second) which dereferences an object instance pointer"
> > >>>
> > >>> is not correct.  &((*ptr).second) does not dereference *ptr any more than
> > >>> &x deferences x.  The semantics of & doesn't work like that.
> > >>
> > >> Does the usage of the operator “member access through pointer” (arrow) mean also
> > >> a dereference in comparison to the asterisk operator in the C programming language?
> > >
> > > Not when there is a & in front.  you can just look at the generated
> > > assembly code to see that.  The goal of & is to take the address of
> > > something, not to evaluate the thing.
> >
> > Would you like to take another look at recent responses by David Svoboda?
> > https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+null+pointers?focusedCommentId=405504153#comment-405504153
> 
> His previous comment says that the standard doesn't mention &a->b so it is
> a problem.  He is surely more of an expert on the C standard than I am.

In the linux-kernel we do a lot of things that are not in the C
standard.  The linux-kernel is written with specific versions of GCC
and Clang in mind.  It's not expected that other compilers will be able
to compile the kernel.

So &a->b is just fine in the linux kernel.

regards,
dan carpenter
