Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD14FC282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 09:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vga/g3evdtXKKUPmygpssFnr7zgCG3URniCGU1ZM1xE=;
  b=htX2itomfBk3zSQIKCON8BqG7AIKsw3viAXU35aO6zSfsL8m2LQkOpxO
   LhPJsvp7Jr+K7SndiEdEgQc88GmD+Ygem6jmFkiicWwAaNj4Mv+9wlR+T
   gUmPz83UFviSY6YbR2b6OTHTdHl7L40C7hWMOb7Gj83Iz6RVATRHjQaLr
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@oracle.com
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213419051"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 10:11:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BB302E0D1E; Tue, 18 Mar 2025 10:11:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7A2DFE0260
	for <cocci@sympa.inria.fr>; Tue, 11 Mar 2025 02:20:09 +0100 (CET)
IronPort-SDR: 67cf8fc7_ttjelfjyOIYYi+qtN1G5fQsXbfunG4fACmWCkygl5izoQP9
 W+1uJ6UGJ4PHSun8g2Z+j2uJuIeltEKoEgp30rQ==
X-IPAS-Result: =?us-ascii?q?A0EZAAAQj89ngyCx3M1AGh0BAQEBCQESAQUFAUCBPwgBC?=
 =?us-ascii?q?wGCQ32BDQQLSIRWiB1fhlOCJII9AZoAgVaBQD4PAQMBCwEBOQsEAQEDAQNDg?=
 =?us-ascii?q?QmDMAICAosaAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBAQE5Bw47hXsNgmIBgRMRUQ0WMAIBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQERAg1eAQEeAQEBAgESEQ8BDQEBNwEECwsODAImAgJGEAYBNIJgAYJBI?=
 =?us-ascii?q?wMRogpDZypZAYEgQokSAQEBeIEygQGCDAEBBt4FAwaBGi4BiE4BgWyDD3A7h?=
 =?us-ascii?q?DwngWREgUeCeD6BUniCDoNGgmmCM4Fpgz6pGQk/CnscA1ksAVUTDQoLBwVkR?=
 =?us-ascii?q?RAzAyAKCwwLEhwVAhQNEA8GEARqBTQKNziCC2lJOgINAjWCGyRYgiuCF4I2h?=
 =?us-ascii?q?DxcLwMDAwODKII/T4JAghFxbAMDI4Iwb3cchEE8hGEuMh1AAwsYDUgRLDcGD?=
 =?us-ascii?q?hsGPQFuB6ERO4V9gkqSb4Qarz4HA4QbjBiVSgQvg3CmZy6HZZBrIo1jmwQCB?=
 =?us-ascii?q?AIEBQIXgWc6gVxRH4M3TwMZD44hGYNhhROKKgG3Sig0PAIHCwEBAwmQHIFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23:cANp/hWZnK2cCqX4LBONWiIyrfTV8KxeWTF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBt+ds6oP0rCO4/GocFdDyKjCmUhBSqAEbwUCh8QSkl5oK+++Imq/EsTXaTcnF
 t9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5/I
 gu6oR/NusUKjoduN7g9xgfKr3ZMZu9b2X5mKVWPkhnz4cu94IRt/yNMtfw/6sVOS7/6f6M2T
 bxZCDQpLWU479D1uBfAUAWC+GISXn0ZnRRUDQfF6gr6XorqvSvhquV9wiiaMtboQr0yRD+v8
 r1kSB7siCcAKj457GTagdF+ga5HvB6soQF0zpXKa4+JKvVxYqLdfcsbRWVfWMZRSzdBCZ64Y
 4cWEuYNIfpUo4z7qlATrxWxGBOsCfvvxDFWmHL4wKM03ecmHw7E0gwvEM4BvnvPodXpN6ofS
 /y5wbPUwTjBaf5dxDfz6JLPchAkufyAU7V+ftDLyUkzFgPFiEibp4n/MziIzOoCrXSb4PR6V
 eK0lWEnrQ99qSWoy8cpkIbJnJ4VylHC9Slj2IY6O8G4R1BhYd6/DpRQsTqXN4xsQsw4X25ov
 Dg1xqcatp68eSgH0ZIqzAPQZPKbaYaH+A7jVPqPLjdignJoYLyyihmy/EWkyuDwStS43UtKo
 CZZndTBq24A2wLc5MSbRPVx4Eev1DaA2g3P5exJIkM5mbTGJ5MgzLA9ipsev0rFEyTrlkv2i
 6qWeV8l+uiu8+nnYavppoWaN4BqjgHyKKMumtawAek+LwMAXHCb9Pyi2LH//UD1WqtGguMqn
 qXDrZzXJ8YWqrS3DgNLyoov9gqzAyu83NgFgXULMEhJdAyHgoT0IV3CPf71APe5jl+xjjprw
 +3GPqb9AprTNHjNjbbhfLdj5ENE1AY+y81U6YhOBbEbOv3zX1f8tNzGAR89NAy52+PnCdph2
 owFQG6DHrOVPL/TvFKM6OIjP/eAaJUNuDblK/gl4OXujWMnllAAZ6WmwZwXaHWgEvRnJUWWf
 2bsj88fHWsWvgcyVvLmhEOeXTJJenq/XaAx6is1BY64FYvDQ5qigL2F3Ce1BJ1WYWVGB0iJE
 XjybYWER/YMaCSILs95jDMESaauS5U61R6wsg/30L1nLvDO9SIEsZLsysJ56PHUlRE37TB0C
 d+S3HmXT25ohmMIWyM23KdnrEBj0luDy7R3g+REFdxP4PNEShs1NZnAwONmCtD/QRnBf9eMS
 Fa+WNqqGzAxTtQrw98PeUlxAduijgrb0yqwH7AVj6CLBIAz8q/E23j+Pch8xGzC1KkllFQnQ
 8pPNWi9ia5l7QffHY/Jk0ODl6arb6sQxiDN9H3QhVaJ6WheXBR9Tu3gWmoDYU2e+d36/kbqS
 76oFKRiPAxcz8KLNqpNbJvul1oQAL/SMc7ZZSqYhWaiHx+UjuedZZDtfSMUwiTPEkEYuwEV4
 XuCcwM5A3Hl60XSATAmOlvlaUr9ub15p3qxREYl5wKHdUts0/yy4BFDwbS+VvcS1/ogsTgor
 zE8SHSg29PfTf6JuANleI1dZ8k86RFJzzSd/yp8NZukJrsqvlcachQ/60Xv3BJzA54GicEur
 WMCzQ97JuSWygUFPxGR2J3rcobSI3PutEStYqvbwRfF1d+M5o8F8vMxp17kuUeiEU90tz1L0
 tJWm1iR4JPHABtaBZ7wWUVx9BV8obzWcwE3/YTd2XZrNO+/tTqUn5pjJuIgxw3oUpF9duuuE
 xPuFMgeCtnkYLgIkl2kdVQuO/xO86swMtKOV/KAw6OtBO96gDSrl39H4Zg72UWJoW40aOfS2
 I0Byu/Q/RqcWjP1xAO5v9r6iahcaCsfDiy0236gTLJYZaRpfYdDKHinIoXj2tRhjp/FQGND+
 RioAFZQnIeCeQCTdBTY1BZX0wxDqniisSWyiTdzlmdt5oiYxyHAi87rfxsEcjpJQ3Jvg3/wJ
 pi1hMgTWkShKQMukU3hrWrz2alX7J9jInPZSA8cczPqIntoW4Orq6GPJcVI7cVs+QRTQe30T
 UqLTbv6vVNO0i/5Dmxbwy4TeDSju5G/lBt/3ibVAHF1o2HZdMd/jSbW4tOUEfJW2DUdRCR+h
 n/GD16zF9Sg5sSPi57Isaa1UTTlHr9edzKj5JOKsybzsWR6Cxqyt/O+gNvqFU420nm/n+lrS
 C/P5DL9Kt371rmwNeNPZERkBFbgrcF9H9c62qc5gZAd3zA+i92w+nMD2TP/Ndhe3qv6RHkAX
 zgGx5jS+geznAVFL3GNzpmxfXyG2cZlL42xa3gN1yYV7M1QDqqQqrtekn0x6nGxtwbWerBYl
 zYazfoo7zZOiOwMkAkg1COQBvYVB0YOeWSmux2S9dG1r+11Ii6Qdr6/ngIqkdK+C7eNigJRQ
 nD0ftElByAmqo1EPVjFy2Hy44esQtTRZtIeslXAiA3Np+tYMpQ8krwNnyUxfSresHw5y6YRk
 Adl3dnuv4KaMG5t1KG0GBhVMnvyfcxFvnnGjbxfhdqRx4DnPphlHioKU9O8TfmoODYJqbLrO
 lDKWAY1pXbTNqDeGAWS8kgu+2nGHJGDOGuWIXMU19okQRTLYARxmgkSX30en9ZtOBqjws+nV
 EZR4CAJoFX/r00IgsdhLRq3eH3YuwHgPj0uT5+ZLRd+7QxY4UrRd8uE4bQ3VxpY94Kn5COQL
 STPfARBEmcGR0usBF35OLSqo97a/L7cTtG3NPDOaP2uoPFTTb/c3tSv25Zr5R6UO8OAI2V4C
 Ps6ygxPUCY9U/zUnToSVzYQkSPdJ+2WvhGx/mVLo8m6uKDoVRjp6I+nE7ZUPshz4RewgLfFO
 +PGwG5XIDxZ0dsh3mPF1rEalAochjpyeiekFJwPsCfMSOTbnaoBS1YgazJ6MYNz8qQw1xMFA
 ob4wofO1q9xi7suFlFJXEanoYSqTcUPLye2M1aRQA6rPbKdbTHGi+7wbK+xAelQgOhbsBC8t
 B6BHkPjNyjFnD7sAVTnEOVUi2m5sAZAuYewdF45CGz7S5TkYwelMdl6ixUywLspljXLM3IRN
 X53dEYb6vWw4CVCg+xiFiRN4zJAKvONlj3Rz+7cMZ0WrPsjViRxl8pa5XR8xr1aqiteErg9o
 ybWsN9o62GvjOiC0HIzSxdKtDdNwpKCo0RvI43T7J5JVX3D+VQG6mDGT1wprt9oEd2nkpgYn
 tvGkK/oKHJL9dvX/tYGQdDJMsuWMX4JOwDuETLfCw5DRjmuYyWXpUVGl/fa2WCTspg9sIDh0
 M4MRbBzRl04Dv5cAU0zWJQmLZBxFgkjlLedi9AT5mv2+B3cQ8NyvZ3dUP+WR/L1J2DdxZRNf
 AQB2/vYJJ4SNoTh0koqPlRznI3QGkrZddRMpDBxKAo1q19K639wUis43EezOS2353pGX9u9h
 AI3jENdJ6wV+Svh+Uw6IBCC8C45ilUwn5P9jCycaiX8Ko+3R4hdDyeyvE80ZMCoCz1pZBG/y
 BQ3fAzPQKhc2v45LTgDYG70vJJOHaUZVqhYeFoLwunRYfw00FNaoyHhxEld5OKDB4Ex3BAyf
 8uKqHRNkxlmcMZzPbbZca9A1ERRgOSWszOlzPs8xicZPU8G9G7UcykN6wQTLrdzHyOz5aR37
 BCa3T5KeWwCTf0v9/dj7F88PaKYwj7tyaVOLGi2LeWUK67fsG/FxoaTWl1l8EQOmgFe+KRul
 8cud03BT0c00L6YDAgEL+LHOVlfKpIKrCaCc37U9/3VwZVuI4ixUOvvSIdirY4yhUSpVEYsF
 oUItYEaG4W0lVrfNYHhJaIEzhMk4ELqIk+EBbJHYkDDljBPuMy5wJJtuOsVbjgAHWVwNzm27
 bfLt0crhvSERtI/fnYdWMMNKHs3XMSwnyMRsW5HCXG71ecQyQ7K6DGZxGyYCTDmc9tlIu+Ze
 R52E9yw0TIl+qOyhBjc9ZCfb2D2ONJ+u8PevPsArsXiabscRr18vkHA3ohAEibyDiiVS4bzf
 sevLdJ2PrmWQj6gX1eyiiw4VZL0Ndepde2ThB3wAJ1TqM+d1SwiMsm0EncfHQ1xrqcN/vEZB
 0VLbpwlbBrvrwl7Oba4JVLS19y0X2erbyNbU/RF1ui8T7tNxiEoY6mxz35qHfRYh6GntFUAQ
 p0HlESUwP+5e4hYFzD+BnFHYAjJjS0jnmNlO6A5xeJ1k3aq+REMdjuMcuJucmlNudoxUEiTL
 XtBAW09X1aAjIDH72ZAxpgq9jBG15ZR2OxB6z3lu4PHJSmrQOqtoInUtCwpaZ4npbdwOMrtO
 JnOuJTblz3ZBJ7e12/NGCuzDeZbnJ5ILT5VWuJFn0kiI8UNvYcH4k00HsszPL1ADqAwq6viM
 2I5S3RIlWlACNzGh2ZKi/zZufOSjhqKdZU+LBEI+I5PhNcQSW8+Yy8TorOiS5SDkmaFTmYRJ
 wJAiGYErAkEl4J2YqXk+N+SFMIKkWQO5asrDW2QTMoNlROzUGydjFnmRe/0luWo2VkX1/fwy
 pwAXwY5D0FBxuFQn09uKbdtKqBWsJSZ113APU78om/pz/OrYVdLzsiBPVjxFpbEsyzkXzER4
 2YZQ6dI0njUEZlUmA18IvVOxh0EMMW9d0Dy6iZxjYFgBaW5U4azykoot20LQQ+tCdNKD+wgu
 1XSEm4AAdjjuNDuPJNcRXVV8ZuWpgJCkUljBCW+zIJVN8BH5jNfFCgKuziWu8G+DdFSwcIjR
 YFZOc9x4j2ufcEMcIjUuXA9vabjj2PU6yxp+knv3y29Que5V74LpTVDXF9zfyLH9RZpVLFk8
 3+OoAqV7xYupb8dX+bSyx4r6l6RB7hoATBEnTCgJlV3FzxdtvlCbb/Sa4paSuUzYhmmP1o/E
 +Qn1gqH5xM8m3CxeCF0ugZAnkKVFwApSSkYhKvskjwCu4mmPzEdUZdBcTQmaW/MNQuanSldu
 BsXZVttXtgVBdNM+rdT2oUxnIKKUUG3NSQMRwBvLCo9waJV0BYb6BvJd3iHSxKwdfHUrhB7O
 8yWqY/hLfj0+htGlpKysO088PZmJTXukgmsTNbC6o7k44fS6w3ULv++arLjJySbH12uxViqi
 LwpDofH5X3WOQtfcNxhzGY8JIPmESjNNAhHIKQSIwxaU7p7YJNIuLM/BYcsdaAX9KtqHh/CS
 AnoHdnlqfBcMlfVAyzTMyib6eG5iYXJ5LfZRK7rYcnGlBOlC+pne4x37zX2AeKgyYhF5k//w
 etg7Gt/WQDMdnjZ9IqwKFtRotG6dkz5opAlWzjRBd0j9RiljlEFfM0RTSqw9Z0ew54M83f8R
 9Vz1U3rufFT/b1pgWHYy7dzwMywKOHZLvEI6CeP4zCRFl1gs811WDYuSTgLJPcJKPDKYakVy
 8vprrKvf0TywBqP8uddZJ3MIESTwqGC
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:iKdVvKg4Ujq4/a8PcW6jBrituHBQXicji2hC6mlwRA09TyVXrb
 HNoB19726ItN9xYgBbpTnkAsO9qBznhPpICOUqXYtKGTOWwVdAT7sSlrcKoQeQfBEWn9Q1vc
 wMH8cRaeEYT2IK9foSizPIdurIruP3k5xA/d2uqUtFfEVScKdn4B5+CgGHVmNLZCQuP+tJKL
 OsovNdoTyuYHIWadn+IEIkcazsm/3n/aiWHyLvIXYcmXazZPeTmcLHLyQ=
X-Talos-CUID: =?us-ascii?q?9a23=3AHoDjiGh2oq7EZ+3T4xMvqsF4yDJudV/P/Er5HGu?=
 =?us-ascii?q?DFiUwdJ6UcX/XyKR/jJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AhzgL2g4pLuLw2slQZcJ483+UxoxCxaajI2wRoa4?=
 =?us-ascii?q?DnPDYORFZY3SMqQueF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,237,1736809200"; 
   d="scan'208";a="111198911"
X-MGA-submission: =?us-ascii?q?MDFuqc4EI9xpzjic1b6QeqCbDC/mU+d/I7ttyr?=
 =?us-ascii?q?ICUTeMlLr1nKaCLULMfwwC/x3PzTwOzofHswe+IR2XWE8rOgTDr6JwDF?=
 =?us-ascii?q?R0uOZ0oUbtVL3IbOZ+4lXP+bFntrrNJbsdEQ/WNmiv0IPOTFUUF4Ez0h?=
 =?us-ascii?q?LYCdFjarEA5PMv2xCwp4eMPg=3D=3D?=
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 02:20:08 +0100
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ALfsCC014731;
	Tue, 11 Mar 2025 01:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vga/g3evdtXKKUPmygpssFnr7zgCG3URniCGU1ZM1xE=; b=
	NJKW6AJBCUgSa6sEAdBIf4DaXLPeUgHAKf41rBKDFGo5SjRdlrRbpN54Ty58ItXM
	oGD7nb3Q0uwkkdmnp0ycEArwam9sgXQD4YMaPgqr389Bd8TyLohkh6ZIKN4rNlT+
	Bpympy+L/hcrIhDn/kD55cVKOSw8ejQJO36KmiNlf5XfUeQJp6m8Q24vYP8Mf0v1
	oKp3AZovYIdtDEz3r1hCsceNjBHmSOkEWBsfM1GQaIvGVRKwNq/8RKyo4biJAYa9
	89xwFFS5UP2nMoHsh70+Pxwh1HmLupNHk+onNTJ3wMWxaPvJ89/dKt8k67AV9RhX
	i4SZZq8dgRCgXyDYLj3clg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cacbvd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 01:19:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52ANxWwp015363;
	Tue, 11 Mar 2025 01:19:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbencn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 01:19:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52B1JfrC014960;
	Tue, 11 Mar 2025 01:19:44 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 458cbencm8-4;
	Tue, 11 Mar 2025 01:19:44 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Yaron Avizrat <yaron.avizrat@intel.com>,
        Oded Gabbay <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, cocci@inria.fr,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org,
        ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>, Carlos Maiolino <cmaiolino@redhat.com>
Date: Mon, 10 Mar 2025 21:19:03 -0400
Message-ID: <174165504986.528513.3575505677065987375.b4-ty@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110007
X-Proofpoint-ORIG-GUID: sv1nwOEp4AdaVFwdqzCD5uTWITacYh8x
X-Proofpoint-GUID: sv1nwOEp4AdaVFwdqzCD5uTWITacYh8x
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] (subset) [PATCH v3 00/16] Converge on using
 secs_to_jiffies() part two
Reply-To: "Martin K. Petersen" <martin.petersen@oracle.com>
X-Loop: cocci@inria.fr
X-Sequence: 2596
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/174165504986.528513.3575505677065987375.b4-ty%40oracle.com>

On Tue, 25 Feb 2025 20:17:14 +0000, Easwar Hariharan wrote:

> This is the second series (part 1*) that converts users of msecs_to_jiffies() that
> either use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000) or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> where N is a constant or an expression, to avoid the multiplication.
> 
> [...]

Applied to 6.15/scsi-queue, thanks!

[02/16] scsi: lpfc: convert timeouts to secs_to_jiffies()
        https://git.kernel.org/mkp/scsi/c/a131f20804d6

-- 
Martin K. Petersen	Oracle Linux Engineering
