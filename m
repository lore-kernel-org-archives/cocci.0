Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA77C43334
	for <cocci@archiver.kernel.org>; Wed, 29 Jun 2022 17:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pmONYFPhVvbuuP07BNgNPuZhlQnCYjLfJ/ajX1UqFPg=;
  b=n8+RdwwjVTzptsY24r6X+61cBeryOfiXeR4robf05s611r2V2neVhTLA
   E+eyvSnPgjL4dazhXjZzLjIMK3FuQm+mMd2PEYdkZ+HyBtR4TWVKPKLma
   raxEcrKSPSEwyeoOVhwFyp2p2Cenxr29DfYXN8dgeu2Hu0ky/5lcafdwt
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.92,231,1650924000"; 
   d="scan'208";a="43487972"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2022 19:54:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9D215E436E; Wed, 29 Jun 2022 19:54:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F17D7E2680
	for <cocci@sympa.inria.fr>; Wed, 29 Jun 2022 19:54:44 +0200 (CEST)
IronPort-SDR: N5Mdqm/JjJVMlmawgh9c7PLX+pz1o98Rij/nCAAQNpv7MXWmoC00j7kpSeEAX4ZWHs0szbMGRz
 TvKhrsCNwOMWiKjHKd2iE04E6Ngpf4BtqMk1PJz9kejknlyzpBdtD85RWKTfPdWOJLJVrsWnor
 1pwQlf5BHDrkiT2dljaYS0uqqSdphL8TceN0K7DmXYu3s055pnwajtVvJc+h8mv3+CgJsGSqIq
 kl5GpLKFGgMaij1QGCiu5I/16qfhYoFtshXeiyI3btSa85k9lHP2np1OuVmYIJAijiVODDMfsr
 fMamYCZR/01x9pOyyTCDh1bs
X-IPAS-Result: =?us-ascii?q?A0DNAQALkbxigA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CJIEBVi4EC0SETo5ngXcxhCOOKYwjCwEDAQ05BgECBAEBPoFSgmoKAoVKA?=
 =?us-ascii?q?h0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQ0NCQUIC?=
 =?us-ascii?q?gcODgU4Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBBAsLGgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJ5AYJkAQMNIwcLrD6BMYEBgggBAQaBPwEDAgwCQ4I1HywiUoFcA?=
 =?us-ascii?q?waBESyNfXonEIFVRIEVJ4JTMD6BD4FTA4U1gmWOMYRshm4mBA8DGi0vEoEgb?=
 =?us-ascii?q?gEIBgMDBwoFMAYCDBgUBAITElMcAhIFBwobDhQcJBcMDwMSAxEBBwIJEggVK?=
 =?us-ascii?q?wgDAgMIAwIDIAsCAxYJBwoDHQgKHBIQFAIEER4LCAMZHiwJAgQOA0AICwoDE?=
 =?us-ascii?q?QQDExgJFggQBAYDCC8NJwsDBQ8NAQYDBgIFBQEDIAMUAwUkBwMhDyYNDQQbB?=
 =?us-ascii?q?x0DAwUlAwICGwcCAgMCBhUGAgJuLg0IBAgENyQPBQIHLwUELwIeBAUGEQgCF?=
 =?us-ascii?q?gIGBAUCBAQWAhAIAggnFwcTGBsZAQUyJxAJIRwKHwoGBQYWAyFuBQo7Dyg0N?=
 =?us-ascii?q?jwsHxsKgRosKxYDBAQDAgYaAwMiAhIpBjcDFgYoBiIBGwKbLGuBCTYCpGOea?=
 =?us-ascii?q?zQHghSBPYFEDIlRlGAGEy2WVg4GkXqWciCNEZoRgXiBfjMaJIM3EzsBAgECD?=
 =?us-ascii?q?QECAgMBAgECCQEBAo4dN4NugQuDVoVMPzQCAQEBNgIGCwEBAwmFRwEBiTwBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23:kqH66BL2dpdsacpHMtmcuNVsWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCFvrM00A6CBNyGo9t/yMPu+5j6XmIB5ZvT+FsjS7drEyE/tMMNggY7C9SEA0CoZNTjbig9A
 dgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1oLejpB4Lelcu62/689pHJfglFiz6wbbxvI
 BmrrQjaq9Ubj5ZlJqst0BXCv2FGe/5RxWNmJFKTmwjz68Kt95N98Cpepuws+ddYXar1Y6o3Q
 7pYDC87M28u/83kqQPDTQqU6XQCVGgdjwdFDBLE7BH+WZfxrzf6u+9g0ySUIcH6UbY5Uim54
 qx1VBHnljsINz8h8GHWlMNwir5boAm8rBB72oLYfZ2ZOOZ7cq7bYNgUR3dOXtxJWiJCDI2zY
 IUAAfcfM+tGoYnzp1kBogexCwS3GOPiyCVFimPq0aA00eksFxzN0gw6H9IJtXTZtNL7O70IU
 eC20anI1ijIYfxS2Tfz8ojIcxYhof6RVr93dsTe01MvFwDYjlWLs4DrMDeV1uoXs2ia6epgW
 vmiimA5pA5quDSg29kjh5DPi4kIxV/K6T93z5wpJd2kVkF7e9ikHYNQuiyGK4d7QcwvTm9mt
 isnxLALvYO2cSsXxJkp2xPTd/yKf5SW7h/tW+ucISl0inx5db+xmRu+7Eutx/HzWMSp1ltBs
 yRLkt7Jtn8X1hzT7NCKSvhj8Ue73zaAyQTT5vtDIUAumqrXM58hwrgqlpoSq0vPBCH2mF/wg
 aSLdUsk4vCl5/r6brn4vJOQKZF4hwPkPqgzmsGzG/k0PwcWU2Wf9+mwzqDv8EP3TblQk/E6j
 KbUvIrbKMgFoKOyHhVb3Zw56xmlCjeryNQYkmcDLFJCYB+Hio/pO0zSIPziA/awnU+jnC12y
 P/YJrHhA5PNIWbfkLr5Y7px9lBQxBAtwdxB5Z9YEKwNLfLpVkPsu9HUFho5PBa1w+bjBtV9z
 IQeWWeXD6GeKqzSq1yI5v80I+WWa4EVvDj9K+Ik5/7ogn80glEccrey0pcNdX+3AOxqI0OCb
 nX0mNcODX8KvhYiTOztkFCOTyZfZ2yuUKIk+jE7FIWmAJ/fSYCqnLOOwCa7E4ZNZmFGD1CMC
 W3ne5+FW/cKciKSI9VuniYKVbi7U4Mhzw2htBfmy7p7KerZ4ikYuojt1ddv4+3TkQo/9D11D
 8SYyG6NVXt7knkJRz8wxqB/oFZyxk2N0ahi0LRkEolx+vdIW08ePIHVy+gyX9LvXgPIONOAV
 1+iRv2nByswR5Q/2YlKK2T8AVSnnyfn0iSjHqUY3+iJCYY597Oa23X/Lttnxl7A2bUok1whB
 MBIMDv1qLR48l32DpTKjl7RuqKkb6Ua02aZ0W6ZzneV+mxcXhRxV6rtQn0VIEfb+4eqrnjeR
 qOjXOx0ejBKztSPf+4TMoWBZTRuQf7iPI+beGetgyKrAg7OwLqQbY3scmFb3SPHCUFCnRpAt
 W2eO10YASGs63nbECQoDUjmNmbl6+pjszWWSkEuzgeFR1Js3fy5901dnuSSHssaxalMoyI9s
 3NxFVe50cjRDo+lrhBiYb4aTNcz+lZB2krGugY7MpHzZ7t6iAs4dAJ691jryw0xCohElp0yq
 2g2yQNpNa+C+FZGai/ewp36fLHaQoXr1DaobaOemlTX0dLNv7wK9Ox9sFL7+gegCksl9Xxjl
 dhTyXqVoJvQXkIUVtrqX0A7+gIfxfmSazQh547SyXxnMLWl+j7E1dUzAeI5yxGmN95BOaKAH
 QX2HoUUHc+rYOAtnlGoaFoDMoUwvOYRNtmlauDA9aqlJudmkxq5gG4B7I08mkOA+ixgS/LZi
 o4fyqLQ1Q+GWjHgyVa555quw8YeP25URzf5kHS3YewZLrd/dosKF2q0dsi+x9ElwoXoR2Yd7
 1m7QVUPxM6ufxOWKV37xwxZk0oN8hnF0WO1ySJ5lzYxo++RxivLlq7HfQAEJ3UNaW1sl1bqL
 qCrgtpcUEXiPG1L3FO1oF33waRWvvE1CmDJQlpTOQXyIXtjVKSYqbeIJcJCosBN020fQKG3Z
 laUTaT4qh0R3nb4HmdQ8zs8cimjppTzmxESZHu1FH9otzKZfMhxwUya/9nAXbtK2SJAQiBki
 D7RD1z6Pt+z/NzSmY2R+uy5UmugUNVUf0yJhculvTG4+HYsLBmxhfG1lfX4HAJ83SKz29RxV
 CrOpQrxecGxjv78a7g4OBA1Qgago8NhUplziI4xmI0d1R14zt2O8HwLnH2yedRX1KTibWYcE
 DsCwtrb+g/giwVoKnOEwZ68V23ImJI7IYPgPSVPh2Rks5Mvau/c9rFPkCprr0DtqAvQZaM4h
 TIB0b4172ZchegVuQ0rxyHbA7YIHEAeMza/8nbAp924sqhTY36iNLaq008r1/WoFrKfuUdxX
 Hjje5EtNTB95INzPRiftR+7opGhY9TWYd8J41exmg3DkvMTBZY/jPsMigJ4NGi7sXBvmItZx
 VR+mJq9uoaAMWBk+qm0VwVZOjPCbMQW4jjxjKxak5Xez8W1E55mADlOQIrwQKfiDmcJrfq+f
 VXrcnV0ujKBFLHYBwPa9Ep2syeFDcWwL3/ObHgBkYc4HUPbfhYAxllOAnNjxM5+TF3PpoSpc
 V8ltGpIvBii8EQKk78ub16lDy/evFv6MG5uDsLFc1wPsUcaoB2Kec2GsrApRn4eocfn9V3Xb
 DbHN0MSXARrEgSFHwyxbuPovIedtbHFV6zmaKGQKbSW9b4EDqjOmsjpiNM5uW7LbJrHP2E+X
 adihQwcBzYgSp6fxWlIEXJy9WqFbtbH9kfmvHQp84blqqWtAVm3rYqXV+kCa5M2pU3w2/zbc
 bTKzGNwLTISvn8V7VnPzrVXnFsbiiU1MiKoDaxFrinVCqTZhq5QCRcfLSJ1LspBqawmjEFLP
 obAh9X526Qd7LZ9AkpZVVHnhsCiZNAba2C7OlTdAU+XNbOAbTTVysDzaKm4RPVeluJR/xG3v
 D+aFQfkMFHh33HxUAuzNOhXkCyBFBlZpZ37bRtnT2TuDZrnZhC9LN5rnGg2zLkz1RaofSYXN
 TlxdV8Ir6XFt3oCxK8lRCoYszw8cbrh+W7R9eTTJ5cIvOE+By11k7kf+3Em0/5O6zkCQvVpm
 SzUp9ooole8k+DJxCA0NXgG4jtNmo+Pul1vfKvD8ZwVE1PN5hEQ9iO9DxoQpt1qIsLiseZcx
 5Kc8cC7YCcH6N/S8cYGUoLML9mbNXM6LRfzMDvTERdDUjOhc23SzR848rna5jieqZ40rYLpk
 ZwFR+pAVVA7IfgdD1xsAN0IJJofttYMjrORysIFtyLWRPj5QcJHotbYW/jUDfi9cF5xYpFba
 hFOzb6qdOwu
IronPort-Data: A9a23:vmLyraOARrKKjjXvrR2KkcFynXyQoLVcMsEvi/4bfWQNrUon0TYFm
 2QWCmmAPPuMM2ajedgnaouxpk0H7MTXxoUxGXM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EgLd9IR2NYy24DnWVLV4
 LsenuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB25sshq8
 fEdqqWuCgImfbb2h8UcTRNhRnQW0a1uoNcrIFC6ttGPiVLLeT3gzp2CDmlsZNdeoLwoRzgTs
 6VEQNwORkjra+ae5buhSfR3wOknItPqOow3pXxqiz3UZRojacmTGvyXvIcCtNs2rv8eFKfXd
 cFJUwF+VDXhaBlwO0o8KbtryY9EgVGmLmEG8QvLzUYt2EDYywd60ZD2Id/Nc5qLQ99UlwCWv
 Aru+23mCxUeHM6ezDCf+zStgPXOlGX1Quov+KaQ8/l3nBuMy2ZVBBB+uUaHTeeRumOmQOt7e
 1Mt5GkrouspzlOKT8f3ZkjtyJKbhSI0V91VGuw8zQiCzKvI/gqUblToqBYeMbTKU+dpHFQXO
 k+1c8DBWW036ObOIZ6J3ufI92zuUcQABTJaPUc5oR05D87LjKxbYvjnbd95FLWvk934cd0b6
 2/U9XNh71n/peQC26i9uG9sVyiwupXMRAMv6W3qso+N6wRkeMi6aobu5VWzARd8wGSxEQLpU
 Jsswpn2AAUy4XelynXlrAIlQunB2hp9GGeA6WOD5rF4n9hXx1atfJpL/BZ1L1pzP8APdFfBO
 RGO518NvccIYCTzMMebhr5d7ex1nMAM8vy6BpjpgiZmPsEZmPKvoX0/OxXKt4wTuBJ1y/5gU
 XtkTSpcJS9HVfo+lWTeqxY1iPFyjiE42W7JQ53nhx2ouYdyl1bFIYrpxGCmN7hjhIvd+Fu92
 48Ga6OilksCOMWjPHi/2dNCdTgicClgbbir+pw/XrDZfmJORjp7Y9ePmuNJRmCQt/4F/gs+1
 iriCxAwJZuWrSGvFDhmnVg4MuOzDMYj9S9gVcHuVH7xs0UejU+UxP93X/MKkXMPrYSPFNZ4E
 KsIfduuGPNKRmiV8jgRd8evs4FoMhim3FrcMy2gaTk5XphhWw2Qpo66JFSyrnFWA3rlr9Y6r
 p2hyhjfH8gJSTNiO8CKOvih+FW84CoGk+VoUkqUedReIR2+8IVjJyHroOUwJsUAdUfKyjeAi
 VSJDB1eqeSU+90599zAhKalqYa1ErIiTxQAQDSBte67bHCI8HCizIlMVPezUQrcDG6kqr+/Y
 eh1zu3nNKNVllh9s716T+Rhw5U46oa9vLRd1AllQC7GYln3WLNtJn6KgZtGuqFXn+YLvAyrR
 gSQ99McNbjQYJHpF1sYJQwEaOWf1KhIy2eIsqlveB33tH1t4b6KcUROJB3S2iZTG7tCNt93y
 +kWvsNLuRe0jQAnM4rdgy0IpX6AKGcMD/cuup0AWda5jw021hddbJaaBiKvuMODbNBFM08LJ
 D6IhfOe1uoGmReYKyI+RSrXwO5QpZUSoxQUnlUMEFS+nIaXjPEA2hAMoy88SR5Yz0kc3u9+U
 oSx25aZ+UlTE/ZUaMl/s6SEHgZcGFuG90a3x1ZheKg1iaW3fjSlEYH/Eb/lEIMlH6Z0YTVRu
 r2VoIogeSi/Z9n/h0PeRmY8w8EOjrVNGsnqh82tWciId3X/jfwJnYf2DVc1R9Db7Q/dSaEJS
 SSGPAq9VEEjCRMtng==
IronPort-HdrOrdr: A9a23:OZg4SKpwLa41z9fPRGEJKpgaV5viL9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6La90dq7MArhHP9OkP0s1NKZMDUO11HYSL2KgbGC/9SCIVyIygc+79
 YGT0EWMrSZYjZHZK3BkWqF+qMbsby6GdeT9IXjJhlWLT1CWuVF1UNUGwybGkp5SE1tHpwiDq
 eR4cJBun6JZWkXRt7TPAhNY8Hz4/nw0L72ax8PABAqrCOUiymz1bL8Gx+Emj8DTjJ0x6s4+2
 StqX2w2kzjiYDx9vbv7R6f031koqqs9jJ3Pr3HtiFaEESitu/iXvUYZ1TLhkFPnAjo0iddrD
 CEmWZbA+1jr3zWZW27uh3rxk3p1ysv8WbrzRuCjWLkutGRfkNINyNtv/MpTvLi0TtRgPhslK
 ZQm26JvZteCh3N2Cz7+tjTThlv0k65u2Arn+Ifh2FWFdJ2Us4lkaUPuEdOVJsQFiPz744qVO
 FoEcHH/f5TNVeXdWrQsGVjyMGlGn4zAhCFSE4fvdH96UkloJm49Tpn+CUypAZ9yHtmceg42w
 3tCNUWqI1z
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,231,1650924000"; 
   d="scan'208";a="18115102"
X-MGA-submission: =?us-ascii?q?MDFXw/gol6+DS5881tv3JsUKZ0JLfcjuCCPali?=
 =?us-ascii?q?GRTGe2itwA3xYvPwFSNKPRwRHNUfCtiS0+FGeI//XIreCQUU8u0JkbG8?=
 =?us-ascii?q?Kt1WJbmcng6CCcG8NzwxYeuL0LixJGo501dwTUAGHKzVvXTD+QQcVaB5?=
 =?us-ascii?q?I72PA77pPcYUgEp7Fbvv9zMQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 19:54:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656525280;
	bh=neMZhwZ8yd1D9ykHZDRACqLWH/42yjlJFDJUmruq4Fs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gYt+aN3qAgBHVqyZiqhE4EjU++hDD3HK70wsBdB5Phg/lS7djVSZ08x7YiudsCP3j
	 5v/TGwMOl+IN48IRfFElkH+GCx7nUTxE9dN4A43O2x+8/2HjofiOKxGH6KHGVRXo0V
	 fhizE3Cmjjw151s71yowRK465xOMk3dyqNzRdOkk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.133.124.62]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Icd-1nkFtf1Lpn-00x8Ik; Wed, 29
 Jun 2022 19:54:40 +0200
Message-ID: <bdb10f50-f4c8-b87d-1c17-b9b15721c378@web.de>
Date: Wed, 29 Jun 2022 19:54:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>,
 =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>
Cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
References: <AS8PR03MB76039ED18663E85F7E8234CF93B59@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <AS8PR03MB76032BE6B27D43AD020D810D93B89@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <alpine.DEB.2.22.394.2206281246160.2182@hadrien>
 <AS8PR03MB7603A0EDD52082F08387477993B89@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <alpine.DEB.2.22.394.2206281635110.2121@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2206281635110.2121@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6cNHCdgQgEiv8iqons0Sl+8BkdPUBfWAIhac2y2kNEx3GNeXY/P
 3CaWGcVPvipVImIwADHz3Xu3YsamY9Dc2jeChLRTua6i/ZnfRsFu43+vyBsFfwDL05fx0QR
 wf6FG8mlYebaJWdtsPGBv/BdCoI7uXR77WyoxDVcskDDHZ1rQJpGvQqVRCZCEel64ezB3It
 kFSwCiUV8M0wIPjWt7oUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ei3ZpLlUJQI=:KQJaSSr+PkrAJ1CXi8zdBg
 H/fR3M/jY5SNR+kmTR+RDV2gubHJc60rNQVNzsw3m35htgkx2qCMhdpiulh4a+5KikG/Jvk0I
 QLmn8HApU+v9Pkf4pKp7EwortHJ/QU8K8JXz9FDRGVnF91IY3qJmetmcWdtQsgAWXh9DXoHwD
 j75GeSxp8Jmk/P+2CASkT7InM3Kr+NeDmTEm2WUNIg+FeLz8fFo5Q9fnW7sFy0kSUVJu5lRSn
 ie4FEdmzA3j4LCtFPiZ631yFnHTbpmpq+iIcaRHhus7lqG5tGwcin6aIUp52PjFt09kkvgKXS
 42WUQmicmv3bCgJ2ihIpQxhg2m7WIwYl874jPrp4ff3tYfwTAoIVYDakPb0/yK7C737J854CB
 TFKk/dPVfz6W/yBQRdK2YAv7JG73vg6WJskQqdo+jRlcmPSRxDUzVh+Qn7WOsM/Rg0mFHLERm
 lTsLzyWILfGooq7fjvK0DmtsASR1gR4xIbPIq4PoY4Lxi/Ni8znKK1iOxgxVBOvs646ibc46h
 jkMvcafsG6PuLhT1lqqAUrm4UTIKDvJkzNnYqdCsqtp1C0HoMoiquRb49juigE3pEcevlc2al
 bCNcfqgxiYnB238kkLAu9pHykrU3qyh19ec6nd6/FhuSQtQTbZv5zxbzbRIS+jnFu+HweAhDx
 7/noD8eC7Fy/6aBmHpNm4skGXqs2EfSxc+659F4f7EhF35ynM51HV0ARjBnFfLJmy3vL/06M/
 thFNcspA6ToIgGNBmIM9vTicOU034m2dWtJzt46DCL+3t2gknTZKnTm3C6RsNDNxWS84RJY77
 5SHe/QFGMdyj4Q6GqCqNHfZwobiyQlpPmzpqWsRqEUOGMTGLP8gx8KP64PFex5W/JVO2SdTVl
 Mv+V5FbKDjAYuQWL7BDYE4fXKQsvJfOKY+niqXaUMflzVFJuq4iOJFp/vvMpkW9ufxs850v9U
 ORMXUy5VeYRqSEnfQxK0cXMCBxo5bK8lWsh0ORPX6MsLujFVS/3Z41mOlP2sQxadKGNPbc22N
 fKfNXZ04RtxO40KMn9kNzR/KblQRvmPCyD4SuduvVqqdVBBL22DN1lYwVTqupgkjno85QxpQW
 bVCWXMJN+bLvROkcLHhw7lTUTA9U2hGNjla3EZmXkX9srVzxCUW1GMqhA==
Subject: Re: [cocci] [v4] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 467
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/bdb10f50-f4c8-b87d-1c17-b9b15721c378%40web.de>

>> I get that the &x allows to match the `!= NULL` case thanks to the
>> isomorphism `X => X != NULL` but I don't get how the `== NULL` case only
>> could match the test address without negation as the isomorphism is
>> `X == NULL => !X`.
> I think you should have \(&x == NULL \| &x != NULL\)


Does this suggestion express a questionable contradiction?



> If you have if (&x) S1 else S2 then it will consider the possibility of
> exchanging the branches and negating the test.  But if you just have a
> positive test expression by itself, it won't consider the possibility of
> changing it into a negative one.


How does this response fit to your proposal to reduce a SmPL search pattern?
* https://lore.kernel.org/cocci/alpine.DEB.2.22.394.2206072138160.2960@hadrien/
* https://sympa.inria.fr/sympa/arc/cocci/2022-06/msg00011.html


How do you think about to extend the documentation for the Coccinelle software
another bit also according to the mentioned use case?

Regards,
Markus

